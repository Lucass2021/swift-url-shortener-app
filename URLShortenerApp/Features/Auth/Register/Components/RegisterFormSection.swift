import SwiftUI

struct RegisterFormSection: View {
    @Bindable var viewModel: RegisterViewModel

    var body: some View {
        VStack(spacing: 16) {
            AuthLabeledField(label: "Full Name") {
                AuthTextField(
                    placeholder: "John Doe",
                    icon: "person",
                    text: $viewModel.name,
                    error: viewModel.nameError
                )
            }

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
                    contentType: .newPassword,
                    error: viewModel.passwordError
                )
            }

            AuthLabeledField(label: "Confirm Password") {
                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $viewModel.confirmPassword,
                    isSecure: true,
                    contentType: .newPassword,
                    error: viewModel.confirmPasswordError
                )
            }

            Text(
                "By creating an account, you agree to our **[Terms of Service](https://github.com/Lucass2021/nest-api-url-shortener-context)** and **[Privacy Policy](https://github.com/Lucass2021/nest-api-url-shortener-context)**"
            )
            .font(.default)
            .tint(Color.appPrimary)
            .foregroundStyle(Color.appTextSecondary)
            .multilineTextAlignment(.center)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = RegisterViewModel()
    RegisterFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
