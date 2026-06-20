import SwiftUI

@MainActor
@Observable
class ResetPasswordViewModel {
    var password = ""
    var resetToken = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    private let service: AuthServicing

    init(resetToken: String, service: AuthServicing = AuthService.live) {
        self.resetToken = resetToken
        self.service = service
    }

    var passwordError: String? {
        guard submitted else { return nil }
        if password.isEmpty { return ValidationMessage.passwordRequired }
        if password.count < 6 { return ValidationMessage.passwordTooShort }
        return nil
    }

    func resetPassword(authStore: AuthStore) async {
        submitted = true
        guard passwordError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            try await service.resetPassword(resetToken: resetToken, newPassword: password)
            authStore.pendingToast = "Password changed successfully"
            authStore.didResetPassword = true
        } catch {
            errorMessage = error.userMessage()
        }
    }
}
