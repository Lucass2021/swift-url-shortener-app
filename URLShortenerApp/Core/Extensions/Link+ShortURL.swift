import Foundation

extension Link {
    var shortURL: String {
        guard let url = URL(string: Config.baseURL), let host = url.host else {
            return code
        }
        let port = url.port.map { ":\($0)" } ?? ""
        return "\(host)\(port)/\(code)"
    }
}
