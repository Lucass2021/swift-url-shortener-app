import SwiftUI

struct VerifyResetCodeBottomSection: View {
    var viewModel: VerifyResetCodeViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Verify Code", isLoading: viewModel.isLoading) {
                Task { await viewModel.verifyResetCode() }
            }
        }
    }
}

#Preview {
    VerifyResetCodeBottomSection(viewModel: VerifyResetCodeViewModel(email: "test@example.com"))
        .padding()
        .background(Color.appBackground)
}
