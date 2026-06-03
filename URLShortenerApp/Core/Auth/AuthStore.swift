import SwiftUI

@MainActor
@Observable
class AuthStore {
    private(set) var isAuthenticated: Bool
    var pendingToast: String?

    init() {
        isAuthenticated = KeychainHelper.getAccessToken() != nil
    }

    func saveTokens(_ tokens: AuthTokens) {
        KeychainHelper.saveAccessToken(tokens.accessToken)
        KeychainHelper.saveRefreshToken(tokens.refreshToken)
        isAuthenticated = true
    }

    func logout() {
        KeychainHelper.clearTokens()
        isAuthenticated = false
    }
}
