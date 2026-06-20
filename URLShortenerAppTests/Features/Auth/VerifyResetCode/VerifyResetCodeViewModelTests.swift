import Testing
@testable import URLShortenerApp

@MainActor
struct VerifyResetCodeViewModelTests {
    @Test func wrongLengthCodeBlocksVerify() async {
        let service = MockAuthService()
        let viewModel = VerifyResetCodeViewModel(email: "user@example.com", service: service)
        viewModel.code = "123"

        await viewModel.verifyResetCode()

        #expect(viewModel.codeError == "Enter the 6-digit code")
        #expect(!service.verifyCalled)
    }

    @Test func validCodeStoresResetTokenAndAdvances() async {
        let service = MockAuthService()
        service.verifyResult = .success("token-abc")
        let viewModel = VerifyResetCodeViewModel(email: "user@example.com", service: service)
        viewModel.code = "123456"

        await viewModel.verifyResetCode()

        #expect(viewModel.resetToken == "token-abc")
        #expect(viewModel.showResetPassword)
    }
}
