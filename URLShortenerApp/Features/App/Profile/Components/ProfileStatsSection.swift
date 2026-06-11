import SwiftUI

struct ProfileStatsSection: View {
    let totalClicks: Int
    let activeLinks: Int

    var body: some View {
        HStack(spacing: 12) {
            ProfileStatCard(
                icon: "arrow.up.right",
                label: "TOTAL CLICKS",
                value: "\(totalClicks)"
            )
            ProfileStatCard(
                icon: "link",
                label: "ACTIVE LINKS",
                value: "\(activeLinks)"
            )
        }
    }
}

#Preview {
    ProfileStatsSection(totalClicks: 1284, activeLinks: 42)
        .padding()
        .background(Color.appBackgroundApp)
}
