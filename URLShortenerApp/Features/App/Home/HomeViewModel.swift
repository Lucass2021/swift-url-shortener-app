import Foundation
import SwiftUI

@MainActor
@Observable
class HomeViewModel {
    var links: [Link] = []
    var isLoading = false
    var errorMessage: String?
    var deleteError: String?
    var deletingLinkIDs: Set<String> = []

    private let service: HomeServicing

    init(service: HomeServicing = HomeService.live) {
        self.service = service
    }

    var totalClicks: Int {
        links.reduce(0) { $0 + $1.clicks }
    }

    var activeLinksCount: Int {
        let now = Date.now
        return links.count(where: { link in
            guard let expiresAt = link.expiresAt else { return true }
            return expiresAt > now
        })
    }

    func load() async {
        isLoading = true
        errorMessage = nil
        do {
            links = try await service.fetchMyLinks()
        } catch {
            errorMessage = error.userMessage(fallback: "Failed to load links.")
        }
        isLoading = false
    }

    func delete(_ link: Link) async {
        deletingLinkIDs.insert(link.id)
        defer { deletingLinkIDs.remove(link.id) }
        do {
            try await service.deleteLink(code: link.code)
            links.removeAll { $0.id == link.id }
        } catch {
            deleteError = error.userMessage(fallback: "Failed to delete link.")
        }
    }
}
