import Foundation

enum Config {
    static let baseURL: String = {
        guard
            let value = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
            !value.isEmpty
        else {
            return "http://localhost:3000"
        }
        return value
    }()
}
