import Foundation

private struct NestErrorBody: Decodable {
    let message: MessageValue

    var firstMessage: String {
        message.text
    }

    enum MessageValue: Decodable {
        case single(String)
        case multiple([String])

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let string = try? container.decode(String.self) {
                self = .single(string)
            } else {
                self = .multiple((try? container.decode([String].self)) ?? ["Request failed"])
            }
        }

        var text: String {
            switch self {
            case let .single(string): return string
            case let .multiple(strings): return strings.first ?? "Request failed"
            }
        }
    }
}

actor APIClient {
    static let shared = APIClient()

    nonisolated private let baseURL = Config.baseURL
    private let session = URLSession.shared
    private var refreshTask: Task<AuthTokens, Error>?
    private var onRefreshFailure: (@Sendable () -> Void)?

    private static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    private let encoder = JSONEncoder()
    private let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)
            guard let date = APIClient.iso8601.date(from: string) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid date: \(string)"
                )
            }
            return date
        }
        return jsonDecoder
    }()

    private init() {}

    func setRefreshFailureHandler(_ handler: @escaping @Sendable () -> Void) {
        onRefreshFailure = handler
    }

    func request<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil) async throws -> T {
        let token = endpoint.requiresAuth ? KeychainHelper.getAccessToken() : nil

        do {
            return try await perform(endpoint, body: body, token: token)
        } catch APIError.unauthorized {
            guard endpoint.requiresAuth else { throw APIError.unauthorized }
            let newTokens = try await refreshTokens()
            return try await perform(endpoint, body: body, token: newTokens.accessToken)
        }
    }

    private func refreshTokens() async throws -> AuthTokens {
        if let existing = refreshTask {
            return try await existing.value
        }

        let task = Task<AuthTokens, Error> {
            guard let refreshToken = KeychainHelper.getRefreshToken() else {
                throw APIError.unauthorized
            }
            let tokens: AuthTokens = try await self.perform(
                .refresh,
                body: RefreshRequest(refreshToken: refreshToken),
                token: nil
            )
            KeychainHelper.saveAccessToken(tokens.accessToken)
            KeychainHelper.saveRefreshToken(tokens.refreshToken)
            return tokens
        }
        refreshTask = task

        do {
            let tokens = try await task.value
            refreshTask = nil
            return tokens
        } catch {
            refreshTask = nil
            onRefreshFailure?()
            throw APIError.unauthorized
        }
    }

    private func perform<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil, token: String? = nil) async throws -> T {
        guard var urlRequest = endpoint.urlRequest(baseURL: baseURL) else {
            throw APIError.networkFailure
        }

        if let token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try encoder.encode(body)
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkFailure
        }

        guard (200 ..< 300).contains(httpResponse.statusCode) else {
            let retryAfter = httpResponse.value(forHTTPHeaderField: "Retry-After").flatMap(Int.init)

            if [400, 409, 422].contains(httpResponse.statusCode),
               let body = try? decoder.decode(NestErrorBody.self, from: data)
            {
                throw APIError.badRequest(body.firstMessage)
            }

            throw APIError(statusCode: httpResponse.statusCode, retryAfter: retryAfter)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailure
        }
    }
}
