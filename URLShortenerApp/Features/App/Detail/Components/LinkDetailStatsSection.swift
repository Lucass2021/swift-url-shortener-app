import SwiftUI

struct LinkDetailStatsSection: View {
    let link: Link
    let stats: LinkStats?

    private var clicksText: String {
        guard let stats else { return "--" }
        return stats.clicks >= 1000
            ? String(format: "%.1fk", Double(stats.clicks) / 1000)
            : "\(stats.clicks)"
    }

    private var createdText: String {
        guard let stats else { return "--" }
        return stats.createdAt.formatted(.dateTime.day().month(.abbreviated))
    }

    private var lastVisitText: String {
        guard let stats else { return "--" }
        guard let lastVisit = stats.lastVisitAt else { return "No visits yet" }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: lastVisit, relativeTo: .now)
    }

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundStyle(Color.appAccent)
                    Text(clicksText)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    Text("Total Clicks")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }
                Spacer()
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .background(Color.appSurfaceCard)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
            )

            HStack(spacing: 12) {
                LinkDetailStatCard(
                    icon: "calendar",
                    iconColor: .orange,
                    value: createdText,
                    label: "Created"
                )
                LinkDetailStatCard(
                    icon: "clock.arrow.circlepath",
                    iconColor: .pink,
                    value: lastVisitText,
                    label: "Last Visit"
                )
            }
        }
    }
}

#Preview {
    LinkDetailStatsSection(
        link: Link(
            code: "abc123",
            originalUrl: "https://www.example.com",
            clicks: 42,
            createdAt: Date(),
            expiresAt: nil,
            isProtected: false
        ),
        stats: LinkStats(
            clicks: 1530,
            createdAt: Date().addingTimeInterval(-86400),
            lastVisitAt: Date().addingTimeInterval(-3600)
        )
    )
    .padding()
    .background(Color.appBackground)
}
