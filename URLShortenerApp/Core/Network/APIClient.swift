import Foundation

private struct NestErrorBody: Decodable {
    let message: MessageValue

    var firstMessage: String { message.text }

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
            case .single(let string): return string
            case .multiple(let strings): return strings.first ?? "Request failed"
            }
        }
    }
}

actor APIClient {
    static let shared = APIClient()

    private let baseURL = Config.baseURL
    private let session = URLSession.shared

    private init() {}

    func request<T: Decodable>(_ endpoint: Endpoint, body: Encodable? = nil, token: String? = nil) async throws -> T {
        guard var urlRequest = await MainActor.run(body: { endpoint.urlRequest(baseURL: baseURL) }) else {
            throw APIError.networkFailure
        }

        if let token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        if let body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.networkFailure
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            let retryAfter = httpResponse.value(forHTTPHeaderField: "Retry-After").flatMap(Int.init)

            if [400, 409, 422].contains(httpResponse.statusCode),
               let body = try? JSONDecoder().decode(NestErrorBody.self, from: data) {
                throw APIError.badRequest(body.firstMessage)
            }

            throw APIError(statusCode: httpResponse.statusCode, retryAfter: retryAfter)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailure
        }
    }
}
