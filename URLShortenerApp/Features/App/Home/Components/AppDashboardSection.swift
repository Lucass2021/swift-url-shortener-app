import SwiftUI

struct AppDashboardSection: View {
    let viewModel: AppViewModel

    var body: some View {
        Section {
            HStack(spacing: 12) {
                stat(label: "Total Clicks", value: "\(viewModel.totalClicks)")
                stat(label: "Active Links", value: "\(viewModel.activeLinksCount)")
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets())
    }

    private func stat(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(Color.white)
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(label == "Total Clicks" ? Color.appAccent : Color.appTertiary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.appSurfaceCard)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
        )
    }
}
