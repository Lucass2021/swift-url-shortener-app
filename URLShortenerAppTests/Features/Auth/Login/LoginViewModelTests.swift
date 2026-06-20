import Testing
@testable import URLShortenerApp

@MainActor
struct LoginViewModelTests {
    @Test func invalidEmailBlocksSignIn() async {
        let service = MockAuthService()
        let viewModel = LoginViewModel(service: service)
        viewModel.email = "not-an-email"
        viewModel.password = "123456"

        await viewModel.signIn(authStore: AuthStore())

        #expect(viewModel.emailError == "Enter a valid email")
        #expect(!service.loginCalled)
    }

    @Test func shortPasswordBlocksSignIn() async {
        let service = MockAuthService()
        let viewModel = LoginViewModel(service: service)
        viewModel.email = "user@example.com"
        viewModel.password = "123"

        await viewModel.signIn(authStore: AuthStore())

        #expect(viewModel.passwordError == "At least 6 characters")
        #expect(!service.loginCalled)
    }

    @Test func validCredentialsCallService() async {
        let service = MockAuthService()
        let viewModel = LoginViewModel(service: service)
        viewModel.email = "user@example.com"
        viewModel.password = "123456"

        await viewModel.signIn(authStore: AuthStore())

        #expect(service.loginCalled)
        #expect(viewModel.errorMessage == nil)
    }

    @Test func serviceFailureSetsErrorMessage() async {
        let service = MockAuthService()
        service.loginResult = .failure(APIError.unauthorized)
        let viewModel = LoginViewModel(service: service)
        viewModel.email = "user@example.com"
        viewModel.password = "123456"

        await viewModel.signIn(authStore: AuthStore())

        #expect(viewModel.errorMessage == APIError.unauthorized.errorDescription)
    }
}
