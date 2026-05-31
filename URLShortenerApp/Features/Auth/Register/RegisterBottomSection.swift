import SwiftUI

struct RegisterBottomSection: View {
    var viewModel: RegisterViewModel
    @Binding var showLogin: Bool

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Create Account") {
                Task { await viewModel.signUp() }
            }

            Text("Already have an account? \(Text("Sign In").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
                .onTapGesture {
                    showLogin = true
                }
        }
    }
}

#Preview {
    RegisterBottomSection(viewModel: RegisterViewModel(), showLogin: .constant(false))
        .padding()
        .background(Color.appBackground)
}
