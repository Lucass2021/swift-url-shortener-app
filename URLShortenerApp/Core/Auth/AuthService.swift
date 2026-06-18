import Foundation

protocol AuthServicing: Sendable {
    func register(name: String, email: String, password: String) async throws -> AuthTokens
    func login(email: String, password: String) async throws -> AuthTokens
    func forgotPassword(email: String) async throws -> String
    func verifyResetCode(email: String, code: String) async throws -> String
    func resetPassword(resetToken: String, newPassword: String) async throws
}

struct AuthService: AuthServicing {
    static let live = AuthService()

    func register(name: String, email: String, password: String) async throws -> AuthTokens {
        let body = RegisterRequest(name: name, email: email, password: password)
        let response: AuthResponse = try await APIClient.shared.request(.register, body: body)
        return response.tokens
    }

    func login(email: String, password: String) async throws -> AuthTokens {
        let body = LoginRequest(email: email, password: password)
        return try await APIClient.shared.request(.login, body: body)
    }

    func forgotPassword(email: String) async throws -> String {
        let body = ForgotPasswordRequest(email: email)
        let response: MessageResponse = try await APIClient.shared.request(.forgotPassword, body: body)
        return response.message
    }

    func verifyResetCode(email: String, code: String) async throws -> String {
        let body = VerifyResetCodeRequest(email: email, code: code)
        let response: VerifyResetCodeResponse = try await APIClient.shared.request(.verifyResetCode, body: body)
        return response.resetToken
    }

    func resetPassword(resetToken: String, newPassword: String) async throws {
        let body = ResetPasswordRequest(resetToken: resetToken, newPassword: newPassword)
        let _: MessageResponse = try await APIClient.shared.request(.resetPassword, body: body)
    }
}

private struct MessageResponse: Decodable {
    let message: String
}
