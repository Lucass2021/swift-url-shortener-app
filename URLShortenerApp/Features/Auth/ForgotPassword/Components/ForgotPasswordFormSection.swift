import SwiftUI

struct ForgotPasswordFormSection: View {
    @Bindable var viewModel: ForgotPasswordViewModel

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
        }
    }
}

#Preview {
    @Previewable @State var viewModel = ForgotPasswordViewModel()
    ForgotPasswordFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
