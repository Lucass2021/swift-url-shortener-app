import SwiftUI

struct LoginBottomSection: View {
    var viewModel: LoginViewModel
    @Binding var showRegister: Bool

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Sign In") {
                Task { await viewModel.signIn() }
            }

            Text("Don't have an account? \(Text("Sign Up").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .onTapGesture {
                    showRegister = true
                }
        }
    }
}

#Preview {
    LoginBottomSection(viewModel: LoginViewModel(), showRegister: .constant(false))
        .padding()
        .background(Color.appBackground)
}
