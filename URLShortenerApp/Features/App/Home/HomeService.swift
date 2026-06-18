import Foundation

protocol HomeServicing: Sendable {
    func fetchMyLinks() async throws -> [Link]
    func shortenLink(_ request: ShortenRequest) async throws -> ShortenResponse
    func deleteLink(code: String) async throws
    func fetchLinkStats(code: String) async throws -> LinkStats
    func fetchMe() async throws -> User
}

struct HomeService: HomeServicing {
    static let live = HomeService()

    func fetchMyLinks() async throws -> [Link] {
        return try await APIClient.shared.request(.myLinks)
    }

    func shortenLink(_ request: ShortenRequest) async throws -> ShortenResponse {
        return try await APIClient.shared.request(.shortenLink, body: request)
    }

    func deleteLink(code: String) async throws {
        let _: DeleteResponse = try await APIClient.shared.request(.deleteLink(code: code))
    }

    func fetchLinkStats(code: String) async throws -> LinkStats {
        return try await APIClient.shared.request(.linkStats(code: code))
    }

    func fetchMe() async throws -> User {
        return try await APIClient.shared.request(.me)
    }
}

private struct DeleteResponse: Decodable {}
