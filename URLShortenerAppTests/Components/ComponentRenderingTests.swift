import SwiftUI
import Testing
@testable import URLShortenerApp

@MainActor
struct ComponentRenderingTests {
    private func renders(_ view: some View) -> Bool {
        let renderer = ImageRenderer(content: view.frame(width: 320, height: 200))
        _ = renderer.uiImage
        return true
    }

    private var sampleLink: URLShortenerApp.Link {
        URLShortenerApp.Link.samples[0]
    }

    private var sampleStats: LinkStats {
        LinkStats(clicks: 128, createdAt: .now, lastVisitAt: .now)
    }

    @Test func primaryButtonRenders() {
        #expect(renders(PrimaryButton(title: "Sign In") {}))
    }

    @Test func primaryButtonLoadingRenders() {
        #expect(renders(PrimaryButton(title: "Sign In", isLoading: true) {}))
    }

    @Test func secondaryButtonRenders() {
        #expect(renders(SecondaryButton(title: "Create Account") {}))
    }

    @Test func floatingAddButtonRenders() {
        #expect(renders(FloatingAddButton {}))
    }

    @Test func authHeaderRenders() {
        #expect(renders(AuthHeader(title: "LinkShort", subtitle: "Shorten. Share. Track.")))
    }

    @Test func authTextFieldRenders() {
        #expect(renders(AuthTextField(placeholder: "Email", icon: "envelope", text: .constant(""))))
    }

    @Test func otpFieldRenders() {
        #expect(renders(OTPField(code: .constant("123"))))
    }

    @Test func skeletonBarRenders() {
        #expect(renders(SkeletonBar(width: 140, height: 24)))
    }

    @Test func successOverlayRenders() {
        #expect(renders(SuccessOverlay(message: "Done!")))
    }

    @Test func toggleOptionRowRenders() {
        #expect(renders(ToggleOptionRow(
            icon: "lock",
            iconColor: .appPrimary,
            title: "Passcode",
            subtitle: "Require a 4-digit code.",
            isOn: .constant(true)
        )))
    }

    @Test func expirationPickerRenders() {
        #expect(renders(ExpirationPicker(selected: .constant(.never))))
    }

    @Test func linkRowRenders() {
        #expect(renders(LinkRowView(link: sampleLink)))
    }

    @Test func linkRowDeletingRenders() {
        #expect(renders(LinkRowView(link: sampleLink, isDeleting: true)))
    }

    @Test func linkDetailHeroCardRenders() {
        #expect(renders(LinkDetailHeroCard(shortURL: "short.ly/abc", isCopied: false) {}))
    }

    @Test func linkDetailStatCardRenders() {
        #expect(renders(LinkDetailStatCard(icon: "calendar", iconColor: .orange, value: "Oct 12", label: "Created")))
    }

    @Test func linkDetailStatsSectionRenders() {
        #expect(renders(LinkDetailStatsSection(link: sampleLink, stats: sampleStats)))
    }

    @Test func linkDetailStatsSectionLoadingRenders() {
        #expect(renders(LinkDetailStatsSection(link: sampleLink, stats: nil, isLoading: true)))
    }

    @Test func homeEmptyStateRenders() {
        #expect(renders(HomeEmptyStateView()))
    }

    @Test func homeErrorRenders() {
        #expect(renders(HomeErrorView(message: "Something went wrong.") {}))
    }

    @Test func homeSkeletonRenders() {
        #expect(renders(HomeSkeletonView()))
    }

    @Test func welcomeStatsCardRenders() {
        #expect(renders(WelcomeStatsCard()))
    }

    @Test func profileAvatarRenders() {
        #expect(renders(ProfileAvatarSection(name: "Lucas Dias", email: "lucas@example.com")))
    }

    @Test func profileStatsSectionRenders() {
        #expect(renders(ProfileStatsSection(totalClicks: 1284, activeLinks: 42)))
    }

    @Test func setPasscodeSheetRenders() {
        #expect(renders(SetPasscodeSheet(passcode: .constant("1234")) {}))
    }

    @Test func createLinkFormSectionRenders() {
        #expect(renders(CreateLinkFormSection(viewModel: CreateLinkViewModel(service: MockHomeService()))))
    }
}
