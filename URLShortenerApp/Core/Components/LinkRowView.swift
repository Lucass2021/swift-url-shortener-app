import SwiftUI

struct LinkRowView: View {
    let link: Link

    private var shortDomain: String {
        URL(string: Config.baseURL)?.host ?? ""
    }

    private var expirationText: String {
        guard let expiresAt = link.expiresAt else { return "Never expires" }
        if expiresAt < .now { return "Expired" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return "Expires " + formatter.localizedString(for: expiresAt, relativeTo: .now)
    }

    private var expirationColor: Color {
        guard let expiresAt = link.expiresAt else { return Color.appTextSecondary }
        return expiresAt < .now ? Color.appDestructive : Color.appTertiary
    }

    private var expirationIcon: String {
        guard let expiresAt = link.expiresAt else { return "infinity" }
        return expiresAt < .now ? "clock.badge.xmark" : "clock"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(shortDomain)/\(link.code)")
                .font(.system(.subheadline, design: .monospaced).weight(.semibold))
                .foregroundStyle(Color.appAccent)

            Text(link.originalUrl)
                .font(.subheadline)
                .foregroundStyle(.white)
                .lineLimit(1)

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image(systemName: "cursorarrow.click")
                    Text("\(link.clicks) clicks")
                }
                .font(.caption)
                .foregroundStyle(.white)

                HStack(spacing: 4) {
                    Image(systemName: expirationIcon)
                    Text(expirationText)
                }
                .font(.caption)
                .foregroundStyle(expirationColor)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
        )
    }
}
