import Foundation

enum AuthService {
    static func register(name: String, email: String, password: String) async throws -> AuthTokens {
        let body = RegisterRequest(name: name, email: email, password: password)
        let response: AuthResponse = try await APIClient.shared.request(.register, body: body)
        return response.tokens
    }

    static func login(email: String, password: String) async throws -> AuthTokens {
        let body = LoginRequest(email: email, password: password)
        return try await APIClient.shared.request(.login, body: body)
    }
}
