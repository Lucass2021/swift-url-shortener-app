import Foundation
import Testing
@testable import URLShortenerApp

@Suite(.serialized)
@MainActor
struct APIClientTests {
    private func makeClient() -> APIClient {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolStub.self]
        return APIClient(session: URLSession(configuration: config))
    }

    @Test func refreshesAndRetriesOn401() async throws {
        KeychainHelper.saveAccessToken("old-access")
        KeychainHelper.saveRefreshToken("old-refresh")
        defer { KeychainHelper.clearTokens() }

        let counter = CallCounter()
        URLProtocolStub.handler = { request in
            let path = request.url?.path ?? ""
            func reply(_ status: Int, _ json: String) -> (HTTPURLResponse, Data) {
                let response = HTTPURLResponse(
                    url: request.url!,
                    statusCode: status,
                    httpVersion: nil,
                    headerFields: nil
                )!
                return (response, Data(json.utf8))
            }

            if path.contains("refresh") {
                counter.refreshRequests += 1
                return reply(200, #"{"accessToken":"new-access","refreshToken":"new-refresh"}"#)
            }

            counter.dataRequests += 1
            if counter.dataRequests == 1 {
                return reply(401, "")
            }
            return reply(200, #"{"name":"Lucas","email":"refreshed@example.com"}"#)
        }
        defer { URLProtocolStub.handler = nil }

        let user: User = try await makeClient().request(.me)

        #expect(user.email == "refreshed@example.com")
        #expect(counter.refreshRequests == 1)
        #expect(counter.dataRequests == 2)
    }

    @Test func decodesSuccessfulResponse() async throws {
        KeychainHelper.saveAccessToken("access")
        defer { KeychainHelper.clearTokens() }

        URLProtocolStub.handler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, Data(#"{"name":"Lucas","email":"lucas@example.com"}"#.utf8))
        }
        defer { URLProtocolStub.handler = nil }

        let user: User = try await makeClient().request(.me)

        #expect(user.name == "Lucas")
    }

    @Test func mapsBadRequestMessage() async throws {
        KeychainHelper.saveAccessToken("access")
        defer { KeychainHelper.clearTokens() }

        URLProtocolStub.handler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 400, httpVersion: nil, headerFields: nil)!
            return (response, Data(#"{"message":"URL is invalid"}"#.utf8))
        }
        defer { URLProtocolStub.handler = nil }

        do {
            let _: User = try await makeClient().request(.me)
            Issue.record("Expected request to throw")
        } catch let error as APIError {
            guard case let .badRequest(message) = error else {
                Issue.record("Expected .badRequest, got \(error)")
                return
            }
            #expect(message == "URL is invalid")
        }
    }
}
