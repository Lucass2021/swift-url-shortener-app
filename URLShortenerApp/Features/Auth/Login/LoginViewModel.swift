import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?

    func signIn() async {
        // TODO: conectar ao POST /auth/login
    }
}
