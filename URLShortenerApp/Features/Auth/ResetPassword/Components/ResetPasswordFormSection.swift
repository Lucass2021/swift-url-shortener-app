import SwiftUI

struct ResetPasswordFormSection: View {
    @Bindable var viewModel: ResetPasswordViewModel

    var body: some View {
        VStack(spacing: 16) {
            AuthLabeledField(label: "New Password") {
                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $viewModel.password,
                    isSecure: true,
                    contentType: .password,
                    error: viewModel.passwordError
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = ResetPasswordViewModel(resetToken: "sample-token")
    ResetPasswordFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
