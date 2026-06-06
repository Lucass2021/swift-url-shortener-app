import SwiftUI

struct ForgotPasswordBottomSection: View {
    var viewModel: ForgotPasswordViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Reset Password", isLoading: viewModel.isLoading) {
                Task { await viewModel.forgotPassword(authStore: authStore) }
            }

            Text("Already have an account? \(Text("Sign in").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .onTapGesture {
                    dismiss()
                }
        }
    }
}

#Preview {
    ForgotPasswordBottomSection(viewModel: ForgotPasswordViewModel())
        .padding()
        .background(Color.appBackground)
}
