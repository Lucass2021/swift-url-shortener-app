import SwiftUI

@MainActor
@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    private let service: AuthServicing

    init(service: AuthServicing = AuthService.live) {
        self.service = service
    }

    var emailError: String? {
        guard submitted else { return nil }
        if email.trimmingCharacters(in: .whitespaces).isEmpty { return ValidationMessage.emailRequired }
        if !email.contains("@") || !email.contains(".") { return ValidationMessage.emailInvalid }
        return nil
    }

    var passwordError: String? {
        guard submitted else { return nil }
        if password.isEmpty { return ValidationMessage.passwordRequired }
        if password.count < 6 { return ValidationMessage.passwordTooShort }
        return nil
    }

    func signIn(authStore: AuthStore) async {
        submitted = true
        guard emailError == nil, passwordError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let tokens = try await service.login(email: email, password: password)
            authStore.saveTokens(tokens)
        } catch {
            errorMessage = error.userMessage()
        }
    }
}
