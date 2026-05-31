import SwiftUI

@Observable
class RegisterViewModel {
    var fullName = ""
    var email = ""
    var password = ""
    var confirmPassword = ""
    var isLoading = false
    var errorMessage: String?
    private var submitted = false

    var fullNameError: String? {
        guard submitted else { return nil }
        if fullName.trimmingCharacters(in: .whitespaces).isEmpty { return "Full name is required" }
        return nil
    }

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

    var confirmPasswordError: String? {
        guard submitted else { return nil }
        if confirmPassword != password { return "Passwords do not match" }
        return nil
    }

    func signUp() async {
        submitted = true
        guard fullNameError == nil, emailError == nil, passwordError == nil, confirmPasswordError == nil else { return }
        isLoading = true
        // TODO: conectar to POST /auth/register
        print("handle signUp")
        isLoading = false
    }
}
