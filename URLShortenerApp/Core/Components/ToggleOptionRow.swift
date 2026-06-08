import SwiftUI

struct ToggleOptionRow: View {
    let icon: String
    let iconColor: Color
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .foregroundStyle(iconColor)
                .frame(width: 36, height: 36)
                .background(iconColor.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(.subheadline).fontWeight(.semibold)
                    .foregroundStyle(Color.appTextPrimary)
                Text(subtitle).font(.caption)
                    .foregroundStyle(Color.appTextSecondary)
            }

            Spacer()

            Toggle("", isOn: $isOn).labelsHidden()
                .tint(Color.appPrimary)
        }
        .padding(14)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    ToggleOptionRow(icon: "bell.fill", iconColor: .orange, title: "Notifications", subtitle: "Receive updates and alerts", isOn: .constant(true))
        .padding()
        .background(Color.appBackground)
}
