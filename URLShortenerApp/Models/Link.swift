import Foundation

struct Link: Decodable, Identifiable {
    let code: String
    let originalUrl: String
    let clicks: Int
    let createdAt: Date
    let expiresAt: Date?

    var id: String { code }
}

struct LinkStats: Decodable {
    let totalClicks: Int
    let createdAt: Date
    let lastVisit: Date?
}
