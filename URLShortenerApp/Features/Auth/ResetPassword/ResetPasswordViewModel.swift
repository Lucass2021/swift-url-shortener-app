import SwiftUI

@MainActor
@Observable
class ResetPasswordViewModel {
    var password = ""
    var resetToken = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    init(resetToken: String) {
        self.resetToken = resetToken
    }

    var passwordError: String? {
        guard submitted else { return nil }
        if password.isEmpty { return "Password is required" }
        if password.count < 6 { return "At least 6 characters" }
        return nil
    }

    func resetPassword(authStore: AuthStore) async {
        submitted = true
        guard passwordError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            try await AuthService.resetPassword(resetToken: resetToken, newPassword: password)
            authStore.pendingToast = "Password changed successfully"
            authStore.didResetPassword = true
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
}
