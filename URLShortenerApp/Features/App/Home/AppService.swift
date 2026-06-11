import Foundation

enum AppService {
    static func fetchMyLinks() async throws -> [Link] {
        return try await APIClient.shared.request(.myLinks)
    }

    static func shortenLink(_ request: ShortenRequest) async throws -> ShortenResponse {
        return try await APIClient.shared.request(.shortenLink, body: request)
    }

    static func deleteLink(code: String) async throws {
        let _: DeleteResponse = try await APIClient.shared.request(.deleteLink(code: code))
    }

    static func fetchLinkStats(code: String) async throws -> LinkStats {
        return try await APIClient.shared.request(.linkStats(code: code))
    }

    static func fetchMe() async throws -> User {
        return try await APIClient.shared.request(.me)
    }
}

private struct DeleteResponse: Decodable {}
