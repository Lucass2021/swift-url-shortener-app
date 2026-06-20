import Foundation
import Testing
@testable import URLShortenerApp

struct LinkModelTests {
    @Test func decodesFromAPIJSON() throws {
        let json = """
        {
            "code": "abc123",
            "originalUrl": "https://example.com",
            "clicks": 12,
            "createdAt": "2026-01-01T10:00:00Z",
            "expiresAt": "2026-02-01T10:00:00Z",
            "isProtected": true
        }
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let link = try decoder.decode(Link.self, from: Data(json.utf8))

        #expect(link.code == "abc123")
        #expect(link.clicks == 12)
        #expect(link.isProtected)
        #expect(link.expiresAt != nil)
    }

    @Test func decodesWithNullExpiration() throws {
        let json = """
        {
            "code": "noexp",
            "originalUrl": "https://example.com",
            "clicks": 0,
            "createdAt": "2026-01-01T10:00:00Z",
            "expiresAt": null,
            "isProtected": false
        }
        """
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        let link = try decoder.decode(Link.self, from: Data(json.utf8))

        #expect(link.expiresAt == nil)
    }

    @Test func idMirrorsCode() {
        let link = Link.samples[0]
        #expect(link.id == link.code)
    }

    @Test func shortURLUsesHostAndCode() {
        let link = Link(
            code: "xyz789",
            originalUrl: "https://example.com",
            clicks: 0,
            createdAt: .now,
            expiresAt: nil,
            isProtected: false
        )
        #expect(link.shortURL.hasSuffix("/xyz789"))
    }
}

struct ExpirationOptionTests {
    @Test func labelsMatchEachCase() {
        #expect(ExpirationOption.sevenDays.label == "7 Days")
        #expect(ExpirationOption.thirtyDays.label == "30 Days")
        #expect(ExpirationOption.never.label == "Never")
    }

    @Test func rawValuesAreStable() {
        #expect(ExpirationOption.sevenDays.rawValue == "7d")
        #expect(ExpirationOption.thirtyDays.rawValue == "30d")
    }

    @Test func hasThreeCases() {
        #expect(ExpirationOption.allCases.count == 3)
    }
}
