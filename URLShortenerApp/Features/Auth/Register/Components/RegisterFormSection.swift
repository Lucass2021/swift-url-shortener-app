import SwiftUI

struct RegisterFormSection: View {
    @Bindable var viewModel: RegisterViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Full Name")
                    .font(.callout)
                    .foregroundStyle(Color.white)

                AuthTextField(
                    placeholder: "John Doe",
                    icon: "person",
                    text: $viewModel.name,
                    error: viewModel.nameError
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Email Address")
                    .font(.callout)
                    .foregroundStyle(Color.white)

                AuthTextField(
                    placeholder: "name@company.com",
                    icon: "envelope",
                    text: $viewModel.email,
                    error: viewModel.emailError
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.callout)
                    .foregroundStyle(Color.white)

                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $viewModel.password,
                    isSecure: true,
                    contentType: .newPassword,
                    error: viewModel.passwordError
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Confirm Password")
                    .font(.callout)
                    .foregroundStyle(Color.white)

                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $viewModel.confirmPassword,
                    isSecure: true,
                    contentType: .newPassword,
                    error: viewModel.confirmPasswordError
                )
            }

            Text("By creating an account, you agree to our \(Text("Terms of Service").bold().foregroundStyle(Color.appPrimary)) and \(Text("Privacy Policy").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
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
