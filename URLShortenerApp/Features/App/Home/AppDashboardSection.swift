import SwiftUI

struct AppDashboardSection: View {
    let viewModel: AppViewModel

    var body: some View {
        Section {
            HStack(spacing: 0) {
                stat(label: "Total Clicks", value: "\(viewModel.totalClicks)")
                Divider()
                stat(label: "Active Links", value: "\(viewModel.activeLinksCount)")
            }
            .frame(maxWidth: .infinity)
        }
        .listRowBackground(Color.appBackground)
    }

    private func stat(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundStyle(.white)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}
