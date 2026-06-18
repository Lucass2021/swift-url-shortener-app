import SwiftUI

struct HomeEmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "tray")
                .font(.system(size: 56))
                .foregroundStyle(Color.appTextSecondary)

            VStack(spacing: 8) {
                Text("No links yet")
                    .font(.title3.bold())
                    .foregroundStyle(.white)

                Text("Tap + to create your first short link")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(32)
    }
}

#Preview {
    ZStack {
        Color.appBackgroundApp.ignoresSafeArea()
        HomeEmptyStateView()
    }
}
