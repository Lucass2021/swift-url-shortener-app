import SwiftUI

@MainActor
@Observable
class AuthStore {
    private(set) var isAuthenticated: Bool
    var pendingToast: String?
    var didResetPassword = false

    init() {
        isAuthenticated = KeychainHelper.getAccessToken() != nil
        Task { [weak self] in
            await APIClient.shared.setRefreshFailureHandler { [weak self] in
                Task { @MainActor [weak self] in
                    self?.logout()
                }
            }
        }
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
