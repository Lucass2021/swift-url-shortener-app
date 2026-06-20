import Testing
@testable import URLShortenerApp

@MainActor
struct HomeViewModelTests {
    @Test func totalClicksSumsAllLinks() async {
        let viewModel = HomeViewModel(service: MockHomeService())
        await viewModel.load()

        let expected = Link.samples.reduce(0) { $0 + $1.clicks }
        #expect(viewModel.totalClicks == expected)
    }

    @Test func activeLinksExcludesExpired() async {
        let viewModel = HomeViewModel(service: MockHomeService())
        await viewModel.load()

        #expect(viewModel.activeLinksCount == 2)
    }

    @Test func loadPopulatesLinks() async {
        let viewModel = HomeViewModel(service: MockHomeService())
        await viewModel.load()

        #expect(viewModel.links.count == Link.samples.count)
        #expect(viewModel.errorMessage == nil)
    }

    @Test func loadFailureSetsErrorMessage() async {
        let service = MockHomeService()
        service.fetchResult = .failure(APIError.serverError)
        let viewModel = HomeViewModel(service: service)

        await viewModel.load()

        #expect(viewModel.links.isEmpty)
        #expect(viewModel.errorMessage == APIError.serverError.errorDescription)
    }

    @Test func deleteRemovesLinkOnSuccess() async {
        let service = MockHomeService()
        let viewModel = HomeViewModel(service: service)
        await viewModel.load()
        let target = viewModel.links[0]

        await viewModel.delete(target)

        #expect(service.deletedCodes == [target.code])
        #expect(!viewModel.links.contains { $0.id == target.id })
    }

    @Test func deleteFailureKeepsLinkAndSetsError() async {
        let service = MockHomeService()
        service.deleteResult = .failure(APIError.networkFailure)
        let viewModel = HomeViewModel(service: service)
        await viewModel.load()
        let target = viewModel.links[0]

        await viewModel.delete(target)

        #expect(viewModel.links.contains { $0.id == target.id })
        #expect(viewModel.deleteError == APIError.networkFailure.errorDescription)
    }
}
