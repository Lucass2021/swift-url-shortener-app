import Testing
@testable import URLShortenerApp

@MainActor
struct CreateLinkViewModelTests {
    @Test func emptyURLSetsErrorAndSkipsService() async {
        let service = MockHomeService()
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "   "

        await viewModel.shorten()

        #expect(viewModel.urlError == "Please enter a URL")
        #expect(!service.shortenCalled)
        #expect(!viewModel.didSucceed)
    }

    @Test func passcodeShorterThanFourBlocksSubmit() async {
        let service = MockHomeService()
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "https://example.com"
        viewModel.passcodeEnabled = true
        viewModel.passcode = "12"

        await viewModel.shorten()

        #expect(viewModel.errorMessage == "Enter a 4-digit passcode.")
        #expect(!service.shortenCalled)
    }

    @Test func neverExpirationSendsNilExpiration() async {
        let service = MockHomeService()
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "https://example.com"
        viewModel.selectedExpiration = .never

        await viewModel.shorten()

        #expect(service.shortenCalled)
        #expect(service.lastShortenRequest?.expiration == nil)
        #expect(viewModel.didSucceed)
    }

    @Test func sevenDaysExpirationSendsRawValue() async {
        let service = MockHomeService()
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "https://example.com"
        viewModel.selectedExpiration = .sevenDays

        await viewModel.shorten()

        #expect(service.lastShortenRequest?.expiration == "7d")
    }

    @Test func enabledPasscodeIsForwardedWhenValid() async {
        let service = MockHomeService()
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "https://example.com"
        viewModel.passcodeEnabled = true
        viewModel.passcode = "1234"

        await viewModel.shorten()

        #expect(service.lastShortenRequest?.passcode == "1234")
    }

    @Test func serviceFailureSetsErrorMessage() async {
        let service = MockHomeService()
        service.shortenResult = .failure(APIError.serverError)
        let viewModel = CreateLinkViewModel(service: service)
        viewModel.url = "https://example.com"

        await viewModel.shorten()

        #expect(viewModel.errorMessage == APIError.serverError.errorDescription)
        #expect(!viewModel.didSucceed)
    }
}
