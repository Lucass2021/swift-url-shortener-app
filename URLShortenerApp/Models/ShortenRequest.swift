import Foundation

struct ShortenRequest: Encodable {
    let url: String
    let expiration: String?
    let passcode: String?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        if let expiration {
            try container.encode(expiration, forKey: .expiration)
        }
        if let passcode { try container.encode(passcode, forKey: .passcode) }
    }

    enum CodingKeys: String, CodingKey {
        case url, expiration, passcode
    }
}
