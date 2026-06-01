import Foundation

struct AuthTokens: Decodable {
    let accessToken: String
    let refreshToken: String
}

struct AuthResponse: Decodable {
    let tokens: AuthTokens
}
