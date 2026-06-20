#if DEBUG
    import Foundation

    extension Link {
        static let samples: [Link] = [
            Link(
                code: "gh2021",
                originalUrl: "https://github.com/Lucass2021/nest-api-url-shortener-context",
                clicks: 42,
                createdAt: Date().addingTimeInterval(-86400 * 2),
                expiresAt: nil,
                isProtected: false
            ),
            Link(
                code: "swiftui",
                originalUrl: "https://developer.apple.com/documentation/swiftui",
                clicks: 1280,
                createdAt: Date().addingTimeInterval(-86400 * 5),
                expiresAt: Date().addingTimeInterval(86400 * 7),
                isProtected: true
            ),
            Link(
                code: "expired",
                originalUrl: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
                clicks: 7,
                createdAt: Date().addingTimeInterval(-86400 * 30),
                expiresAt: Date().addingTimeInterval(-3600),
                isProtected: false
            )
        ]
    }

    struct PreviewHomeService: HomeServicing {
        var links: [Link] = Link.samples

        func fetchMyLinks() async throws -> [Link] {
            links
        }

        func deleteLink(code _: String) async throws {}

        func shortenLink(_: ShortenRequest) async throws -> ShortenResponse {
            fatalError("PreviewHomeService.shortenLink is not used in previews")
        }

        func fetchLinkStats(code _: String) async throws -> LinkStats {
            fatalError("PreviewHomeService.fetchLinkStats is not used in previews")
        }

        func fetchMe() async throws -> User {
            fatalError("PreviewHomeService.fetchMe is not used in previews")
        }
    }

    extension HomeViewModel {
        static var preview: HomeViewModel {
            let viewModel = HomeViewModel(service: PreviewHomeService())
            viewModel.links = Link.samples
            return viewModel
        }

        static var previewEmpty: HomeViewModel {
            HomeViewModel(service: PreviewHomeService(links: []))
        }
    }
#endif
