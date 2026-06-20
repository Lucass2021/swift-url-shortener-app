import Testing
@testable import URLShortenerApp

@MainActor
struct ResetPasswordViewModelTests {
    @Test func shortPasswordBlocksReset() async {
        let service = MockAuthService()
        let viewModel = ResetPasswordViewModel(resetToken: "token", service: service)
        viewModel.password = "123"

        await viewModel.resetPassword(authStore: AuthStore())

        #expect(viewModel.passwordError == "At least 6 characters")
        #expect(!service.resetCalled)
    }

    @Test func validPasswordCompletesReset() async {
        let service = MockAuthService()
        let viewModel = ResetPasswordViewModel(resetToken: "token", service: service)
        viewModel.password = "123456"
        let authStore = AuthStore()

        await viewModel.resetPassword(authStore: authStore)

        #expect(service.resetCalled)
        #expect(authStore.didResetPassword)
        #expect(authStore.pendingToast == "Password changed successfully")
    }
}
