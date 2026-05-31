import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    var emailError: String? {
        guard submitted else { return nil }
        if email.trimmingCharacters(in: .whitespaces).isEmpty { return "Email is required" }
        if !email.contains("@") || !email.contains(".") { return "Enter a valid email" }
        return nil
    }

    var passwordError: String? {
        guard submitted else { return nil }
        if password.isEmpty { return "Password is required" }
        if password.count < 6 { return "At least 6 characters" }
        return nil
    }

    func signIn() async {
        submitted = true
        guard emailError == nil, passwordError == nil else { return }
        isLoading = true
        // TODO: conect to POST /auth/login
        print("handle signIn")
        isLoading = false
    }
}
