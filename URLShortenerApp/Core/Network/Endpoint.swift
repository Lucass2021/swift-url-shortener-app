import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

enum Endpoint {
    case register
    case login
    case refresh
    case forgotPassword
    case verifyResetCode
    case resetPassword
    case me
    case shortenLink
    case myLinks
    case deleteLink(code: String)
    case linkStats(code: String)

    var path: String {
        switch self {
        case .register: "/auth/register"
        case .login: "/auth/login"
        case .refresh: "/auth/refresh"
        case .forgotPassword: "/auth/forgot-password"
        case .verifyResetCode: "/auth/verify-reset-code"
        case .resetPassword: "/auth/reset-password"
        case .me: "/auth/me"
        case .shortenLink: "/links/shorten"
        case .myLinks: "/links/me/links"
        case let .deleteLink(code): "/links/\(code)"
        case let .linkStats(code): "/\(code)/stats"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login, .refresh, .shortenLink, .forgotPassword, .verifyResetCode, .resetPassword:
            .post
        case .deleteLink:
            .delete
        case .myLinks, .linkStats, .me:
            .get
        }
    }

    var requiresAuth: Bool {
        switch self {
        case .register, .login, .refresh,
             .forgotPassword, .verifyResetCode, .resetPassword:
            false
        case .shortenLink, .myLinks, .deleteLink, .linkStats, .me:
            true
        }
    }

    func urlRequest(baseURL: String) -> URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
