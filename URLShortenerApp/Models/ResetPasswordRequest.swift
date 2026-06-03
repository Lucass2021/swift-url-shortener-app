import Foundation

struct ResetPasswordRequest: Encodable {
    let resetToken: String
    let newPassword: String
}
