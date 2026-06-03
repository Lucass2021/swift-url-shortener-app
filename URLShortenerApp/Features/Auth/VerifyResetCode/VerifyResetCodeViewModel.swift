import SwiftUI

@MainActor
@Observable
class VerifyResetCodeViewModel {
    let email: String
    var code = ""
    var isLoading = false
    var errorMessage: String?
    var resetToken: String?
    var showResetPassword = false
    private var submitted = false

    init(email: String) {
        self.email = email
    }

    var codeError: String? {
        guard submitted else { return nil }
        if code.trimmingCharacters(in: .whitespaces).isEmpty { return "Code is required" }
        if code.count != 6 { return "Enter the 6-digit code" }
        return nil
    }

    func verifyResetCode() async {
        submitted = true
        guard codeError == nil else { return }
        isLoading = true
        defer { isLoading = false }
        do {
            resetToken = try await AuthService.verifyResetCode(email: email, code: code)
            showResetPassword = true
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? error.localizedDescription
        }
    }
}
