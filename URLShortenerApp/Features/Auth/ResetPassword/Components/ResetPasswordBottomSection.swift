import SwiftUI

struct ResetPasswordBottomSection: View {
    var viewModel: ResetPasswordViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Change Password", isLoading: viewModel.isLoading) {
                Task { await viewModel.resetPassword(authStore: authStore) }
            }
        }
    }
}

#Preview {
    ResetPasswordBottomSection(viewModel: ResetPasswordViewModel(resetToken: "sample-token"))
        .padding()
        .background(Color.appBackground)
}
