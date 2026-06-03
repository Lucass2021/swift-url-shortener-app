import SwiftUI

struct ForgotPasswordFormSection: View {
    @Bindable var viewModel: ForgotPasswordViewModel

    var body: some View {
        VStack(spacing: 16) {
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
        }
    }
}

#Preview {
    @Previewable @State var viewModel = ForgotPasswordViewModel()
    ForgotPasswordFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
