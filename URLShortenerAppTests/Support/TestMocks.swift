import Foundation
@testable import URLShortenerApp

final nonisolated class MockAuthService: AuthServicing, @unchecked Sendable {
    var loginResult: Result<AuthTokens, Error> = .success(AuthTokens(accessToken: "access", refreshToken: "refresh"))
    var registerResult: Result<AuthTokens, Error> = .success(AuthTokens(accessToken: "access", refreshToken: "refresh"))
    var verifyResult: Result<String, Error> = .success("reset-token")
    var resetResult: Result<Void, Error> = .success(())
    var forgotResult: Result<String, Error> = .success("Email sent")

    private(set) var loginCalled = false
    private(set) var registerCalled = false
    private(set) var verifyCalled = false
    private(set) var resetCalled = false

    func register(name _: String, email _: String, password _: String) async throws -> AuthTokens {
        registerCalled = true
        return try registerResult.get()
    }

    func login(email _: String, password _: String) async throws -> AuthTokens {
        loginCalled = true
        return try loginResult.get()
    }

    func forgotPassword(email _: String) async throws -> String {
        try forgotResult.get()
    }

    func verifyResetCode(email _: String, code _: String) async throws -> String {
        verifyCalled = true
        return try verifyResult.get()
    }

    func resetPassword(resetToken _: String, newPassword _: String) async throws {
        resetCalled = true
        try resetResult.get()
    }
}

final nonisolated class MockHomeService: HomeServicing, @unchecked Sendable {
    var links: [Link] = Link.samples
    var fetchResult: Result<[Link], Error>?
    var shortenResult: Result<ShortenResponse, Error> = .success(ShortenResponse(shortUrl: "https://short.ly/abc"))
    var deleteResult: Result<Void, Error> = .success(())

    private(set) var shortenCalled = false
    private(set) var lastShortenRequest: ShortenRequest?
    private(set) var deletedCodes: [String] = []

    func fetchMyLinks() async throws -> [Link] {
        if let fetchResult { return try fetchResult.get() }
        return links
    }

    func shortenLink(_ request: ShortenRequest) async throws -> ShortenResponse {
        shortenCalled = true
        lastShortenRequest = request
        return try shortenResult.get()
    }

    func deleteLink(code: String) async throws {
        deletedCodes.append(code)
        try deleteResult.get()
    }

    func fetchLinkStats(code _: String) async throws -> LinkStats {
        LinkStats(clicks: 0, createdAt: .now, lastVisitAt: nil)
    }

    func fetchMe() async throws -> User {
        User(name: "Test User", email: "test@example.com")
    }
}
