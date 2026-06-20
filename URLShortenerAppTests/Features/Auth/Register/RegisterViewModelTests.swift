import Testing
@testable import URLShortenerApp

@MainActor
struct RegisterViewModelTests {
    @Test func emptyNameBlocksSignUp() async {
        let service = MockAuthService()
        let viewModel = RegisterViewModel(service: service)
        viewModel.name = "  "
        viewModel.email = "user@example.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        await viewModel.signUp(authStore: AuthStore())

        #expect(viewModel.nameError == "Full name is required")
        #expect(!service.registerCalled)
    }

    @Test func mismatchedPasswordsBlockSignUp() async {
        let service = MockAuthService()
        let viewModel = RegisterViewModel(service: service)
        viewModel.name = "Lucas"
        viewModel.email = "user@example.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "654321"

        await viewModel.signUp(authStore: AuthStore())

        #expect(viewModel.confirmPasswordError == "Passwords do not match")
        #expect(!service.registerCalled)
    }

    @Test func validFormCallsService() async {
        let service = MockAuthService()
        let viewModel = RegisterViewModel(service: service)
        viewModel.name = "Lucas"
        viewModel.email = "user@example.com"
        viewModel.password = "123456"
        viewModel.confirmPassword = "123456"

        await viewModel.signUp(authStore: AuthStore())

        #expect(service.registerCalled)
        #expect(viewModel.errorMessage == nil)
    }
}
