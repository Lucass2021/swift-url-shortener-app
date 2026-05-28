import Foundation

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case delete = "DELETE"
}

enum Endpoint {
    case register
    case login
    case refresh

    case shortenLink
    case myLinks
    case deleteLink(code: String)

    case linkStats(code: String)

    var path: String {
        switch self {
        case .register:             return "/auth/register"
        case .login:                return "/auth/login"
        case .refresh:              return "/auth/refresh"
        case .shortenLink:          return "/links/shorten"
        case .myLinks:              return "/links/me/links"
        case .deleteLink(let code): return "/links/\(code)"
        case .linkStats(let code):  return "/\(code)/stats"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login, .refresh, .shortenLink:
            return .post
        case .deleteLink:
            return .delete
        case .myLinks, .linkStats:
            return .get
        }
    }

    func urlRequest(baseURL: String) -> URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
