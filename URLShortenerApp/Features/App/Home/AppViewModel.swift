import Foundation
import SwiftUI

@MainActor
@Observable
class AppViewModel {
    var links: [Link] = []
    var isLoading = false
    var errorMessage: String?
    var deleteError: String?
    var deletingLinkIDs: Set<String> = []

    var totalClicks: Int {
        links.reduce(0) { $0 + $1.clicks }
    }

    var activeLinksCount: Int {
        let now = Date.now
        return links.filter { $0.expiresAt == nil || $0.expiresAt! > now }.count
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            links = try await AppService.fetchMyLinks()
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? "Failed to load links."
        }
        isLoading = false
    }

    func delete(_ link: Link) async {
        deletingLinkIDs.insert(link.id)
        defer { deletingLinkIDs.remove(link.id) }
        do {
            try await AppService.deleteLink(code: link.code)
            links.removeAll { $0.id == link.id }
        } catch {
            deleteError = (error as? APIError)?.errorDescription ?? "Failed to delete link."
        }
    }
}
