import Foundation

struct ShortenRequest: Encodable {
    let url: String
    let expiration: String?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        if let expiration {
            try container.encode(expiration, forKey: .expiration)
        }
    }

    enum CodingKeys: String, CodingKey {
        case url, expiration
    }
}
