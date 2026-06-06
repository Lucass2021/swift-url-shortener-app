import SwiftUI

struct VerifyResetCodeFormSection: View {
    @Bindable var viewModel: VerifyResetCodeViewModel

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text("Enter the code we emailed you")
                    .font(.headline)
                    .foregroundStyle(Color.appTextPrimary)

                Text("We sent a 6-digit code to your email address.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .multilineTextAlignment(.center)
            }

            OTPField(code: $viewModel.code)

            if let error = viewModel.codeError {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(Color.appDestructive)
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = VerifyResetCodeViewModel(email: "test@example.com")
    VerifyResetCodeFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
