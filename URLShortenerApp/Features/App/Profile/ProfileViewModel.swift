import Foundation

@MainActor
@Observable
class ProfileViewModel {
    var user: User?
    var isLoading = false
    var errorMessage: String?

    func load() async {
        isLoading = true
        defer { isLoading = false }
        do {
            user = try await AppService.fetchMe()
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? "Failed to load profile."
        }
    }
}
