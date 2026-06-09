import SwiftUI

struct WelcomeStatsCard: View {
    var body: some View {
        HStack(spacing: 0) {
            statItem(value: "4.2M+", label: "Links Created")

            Rectangle()
                .fill(Color.appOutline)
                .frame(width: 0.5, height: 40)

            statItem(value: "99.9%", label: "Uptime")
        }
        .padding(.vertical, 20)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.appOutline, lineWidth: 0.5)
        )
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(Color.appPrimary)
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundApp.ignoresSafeArea()
        WelcomeStatsCard()
            .padding(.horizontal, 20)
    }
}
