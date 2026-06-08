import Foundation

enum ExpirationOption: String, CaseIterable {
    case sevenDays = "7d"
    case thirtyDays = "30d"
    case never

    var label: String {
        switch self {
        case .sevenDays: return "7 Days"
        case .thirtyDays: return "30 Days"
        case .never: return "Never"
        }
    }
}

@MainActor
@Observable
class CreateLinkViewModel {
    var url = ""
    var selectedExpiration = ExpirationOption.never

    var generateQR = false
    var passcodeEnabled = false
    var passcode = ""

    var isLoading = false
    var urlError: String?
    var errorMessage: String?
    var didSucceed = false

    func shorten() async {
        errorMessage = nil

        guard !url.trimmingCharacters(in: .whitespaces).isEmpty else {
            urlError = "Please enter a URL"
            return
        }
        urlError = nil

        if passcodeEnabled, passcode.count < 4 {
            errorMessage = "Enter a 4-digit passcode."
            return
        }

        isLoading = true
        defer { isLoading = false }
        do {
            let expiration = selectedExpiration == .never ? nil : selectedExpiration.rawValue
            let passcodeValue = passcodeEnabled && passcode.count == 4 ? passcode : nil
            let request = ShortenRequest(url: url, expiration: expiration, passcode: passcodeValue)
            _ = try await AppService.shortenLink(request)
            didSucceed = true
        } catch {
            errorMessage = (error as? APIError)?.errorDescription ?? "Failed to create link."
        }
    }
}
