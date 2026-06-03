import SwiftUI

@MainActor
@Observable
class ForgotPasswordViewModel {
    var email = ""
    var isLoading = false
    var errorMessage: String?
    var showVerifyCode = false
    private var submitted = false

    var emailError: String? {
        guard submitted else { return nil }
        if email.trimmingCharacters(in: .whitespaces).isEmpty { return "Email is required" }
        if !email.contains("@") || !email.contains(".") { return "Enter a valid email" }
        return nil
    }

    func forgotPassword(authStore: AuthStore) async {
        submitted = true
        guard emailError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            authStore.pendingToast = try await AuthService.forgotPassword(email: email)
            showVerifyCode = true
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
}
