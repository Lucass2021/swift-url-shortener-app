import Foundation

struct Link: Decodable, Identifiable, Hashable {
    let code: String
    let originalUrl: String
    let clicks: Int
    let createdAt: Date
    let expiresAt: Date?
    let isProtected: Bool

    var id: String {
        code
    }
}

struct LinkStats: Decodable {
    let clicks: Int
    let createdAt: Date
    let lastVisitAt: Date?
}
