import Foundation
import SwiftUI

@MainActor
@Observable
class AppViewModel {
    var links: [Link] = []
    var isLoading = false
    var errorMessage: String?

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

    func delete(at offsets: IndexSet) async {
        let codesToDelete = offsets.map { links[$0].code }
        links.remove(atOffsets: offsets)
        for code in codesToDelete {
            try? await AppService.deleteLink(code: code)
        }
    }
}
