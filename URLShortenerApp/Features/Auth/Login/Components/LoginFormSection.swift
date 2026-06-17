import SwiftUI

struct LoginFormSection: View {
    @Bindable var viewModel: LoginViewModel
    @Binding var showForgotPassword: Bool

    var body: some View {
        VStack(spacing: 16) {
            AuthLabeledField(label: "Email Address") {
                AuthTextField(
                    placeholder: "name@company.com",
                    icon: "envelope",
                    text: $viewModel.email,
                    error: viewModel.emailError
                )
            }

            AuthLabeledField(label: "Password") {
                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $viewModel.password,
                    isSecure: true,
                    contentType: .password,
                    error: viewModel.passwordError
                )

                Button("Forgot Password?") {
                    showForgotPassword = true
                }
                .font(.default)
                .foregroundStyle(Color.appPrimary)
                .buttonStyle(.plain)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 4)
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = LoginViewModel()
    @Previewable @State var showForgotPassword = false
    LoginFormSection(viewModel: viewModel, showForgotPassword: $showForgotPassword)
        .padding()
        .background(Color.appBackground)
}
