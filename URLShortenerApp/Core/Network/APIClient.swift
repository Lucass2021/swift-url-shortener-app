import Foundation

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
            throw APIError(statusCode: httpResponse.statusCode, retryAfter: retryAfter)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailure
        }
    }
}
