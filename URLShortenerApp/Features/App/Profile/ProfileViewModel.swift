import Foundation

@MainActor
@Observable
class ProfileViewModel {
    var user: User?
    var isLoading = false
    var errorMessage: String?

    private let service: HomeServicing

    init(service: HomeServicing = HomeService.live) {
        self.service = service
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            user = try await service.fetchMe()
        } catch {
            errorMessage = error.userMessage(fallback: "Failed to load profile.")
        }
    }
}
