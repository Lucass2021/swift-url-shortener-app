import Foundation

struct AuthTokens: Decodable {
    let accessToken: String
    let refreshToken: String
}
