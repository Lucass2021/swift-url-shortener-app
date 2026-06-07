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
}

private struct DeleteResponse: Decodable {}
