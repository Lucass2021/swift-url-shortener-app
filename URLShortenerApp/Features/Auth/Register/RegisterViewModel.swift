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

    var nameError: String? {
        guard submitted else { return nil }
        if name.trimmingCharacters(in: .whitespaces).isEmpty { return "Full name is required" }
        return nil
    }

    var emailError: String? {
        guard submitted else { return nil }
        if email.trimmingCharacters(in: .whitespaces).isEmpty { return "Email is required" }
        if !email.contains("@") || !email.contains(".") { return "Enter a valid email" }
        return nil
    }

    var passwordError: String? {
        guard submitted else { return nil }
        if password.isEmpty { return "Password is required" }
        if password.count < 6 { return "At least 6 characters" }
        return nil
    }

    var confirmPasswordError: String? {
        guard submitted else { return nil }
        if confirmPassword != password { return "Passwords do not match" }
        return nil
    }

    func signUp(authStore: AuthStore) async {
        submitted = true
        guard nameError == nil, emailError == nil, passwordError == nil, confirmPasswordError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            let tokens = try await AuthService.register(name: name, email: email, password: password)
            authStore.saveTokens(tokens)
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
}
