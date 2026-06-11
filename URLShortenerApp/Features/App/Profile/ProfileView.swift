import SwiftUI

struct ProfileView: View {
    @Environment(AuthStore.self) private var authStore
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ProfileViewModel()

    let totalClicks: Int
    let activeLinks: Int

    var body: some View {
        ZStack {
            Color.appBackgroundApp.ignoresSafeArea()

            VStack(spacing: 24) {
                ProfileAvatarSection(
                    name: viewModel.user?.name ?? "—",
                    email: viewModel.user?.email ?? ""
                )
                ProfileStatsSection(
                    totalClicks: totalClicks,
                    activeLinks: activeLinks
                )
                Spacer()
                signOutButton
                versionText
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            GoBackHeader(title: "Back") { dismiss() }
        }
        .task { await viewModel.load() }
        .toast(message: $viewModel.errorMessage, style: .error)
    }

    private var signOutButton: some View {
        Button {
            authStore.logout()
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign Out")
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.appDestructive)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .padding(.top, 8)
    }

    private var versionText: some View {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        return Text("Version \(version)")
            .font(.caption)
            .foregroundStyle(Color.appTextSecondary)
    }
}

#Preview {
    NavigationStack {
        ProfileView(totalClicks: 1284, activeLinks: 42)
            .environment(AuthStore())
    }
}
