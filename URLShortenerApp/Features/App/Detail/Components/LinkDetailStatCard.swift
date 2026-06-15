import SwiftUI

struct LinkDetailStatCard: View {
    let icon: String
    let iconColor: Color
    let value: String
    let label: String
    var isLoading: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
            if isLoading {
                SkeletonBar(width: 60, height: 18)
                    .padding(.vertical, 1)
            } else {
                Text(value)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.08), lineWidth: 0.5)
        )
    }
}

#Preview {
    HStack(spacing: 12) {
        LinkDetailStatCard(icon: "calendar", iconColor: .orange, value: "Oct 12", label: "Created")
        LinkDetailStatCard(icon: "clock.arrow.circlepath", iconColor: .pink, value: "2h ago", label: "Last Visit")
    }
    .padding()
    .background(Color.appBackgroundApp)
}
