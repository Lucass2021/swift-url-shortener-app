import SwiftUI

struct ProfileStatCard: View {
    let icon: String
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(Color.appPrimary)
                .frame(width: 20, height: 20)

            Text(label)
                .font(.caption2.weight(.semibold))
                .foregroundStyle(Color.appTextSecondary)

            Text(value)
                .font(.title.weight(.bold))
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .cardSurface()
    }
}

#Preview {
    HStack(spacing: 12) {
        ProfileStatCard(icon: "arrow.up.right", label: "TOTAL CLICKS", value: "1,284")
        ProfileStatCard(icon: "link", label: "ACTIVE LINKS", value: "42")
    }
    .padding()
    .background(Color.appBackgroundApp)
}
