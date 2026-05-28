import Foundation

enum APIError: LocalizedError {
    case unauthorized       
    case linkExpired       
    case rateLimited(retryAfter: Int?) 
    case notFound             
    case serverError        
    case networkFailure      
    case decodingFailure     
    case unknown(statusCode: Int)

    init(statusCode: Int, retryAfter: Int? = nil) {
        switch statusCode {
        case 401: self = .unauthorized
        case 404: self = .notFound
        case 410: self = .linkExpired
        case 429: self = .rateLimited(retryAfter: retryAfter)
        case 500...: self = .serverError
        default:   self = .unknown(statusCode: statusCode)
        }
    }

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Session expired. Please sign in again."
        case .linkExpired:
            return "This link has expired."
        case .rateLimited(let retryAfter):
            if let seconds = retryAfter {
                return "Too many requests. Try again in \(seconds)s."
            }
            return "Too many requests. Please wait before trying again."
        case .notFound:
            return "Resource not found."
        case .serverError:
            return "Server error. Please try again later."
        case .networkFailure:
            return "No internet connection. Check your network and try again."
        case .decodingFailure:
            return "Unexpected response from the server."
        case .unknown(let code):
            return "Unexpected error (code \(code))."
        }
    }
}
