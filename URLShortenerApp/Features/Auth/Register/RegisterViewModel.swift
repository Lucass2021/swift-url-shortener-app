import SwiftUI

@MainActor
@Observable
class RegisterViewModel {
    var name = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    private let service: AuthServicing

    init(service: AuthServicing = AuthService.live) {
        self.service = service
    }

    var nameError: String? {
        guard submitted else { return nil }
        if name.trimmingCharacters(in: .whitespaces).isEmpty { return ValidationMessage.nameRequired }
        return nil
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

    var confirmPasswordError: String? {
        guard submitted else { return nil }
        if confirmPassword != password { return ValidationMessage.passwordsDoNotMatch }
        return nil
    }

    func signUp(authStore: AuthStore) async {
        submitted = true
        guard nameError == nil, emailError == nil, passwordError == nil, confirmPasswordError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let tokens = try await service.register(name: name, email: email, password: password)
            authStore.saveTokens(tokens)
        } catch {
            errorMessage = error.userMessage()
        }
    }
}
