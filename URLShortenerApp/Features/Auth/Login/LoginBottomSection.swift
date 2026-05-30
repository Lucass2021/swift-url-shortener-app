import SwiftUI

struct LoginBottomSection: View {
    var vm: LoginViewModel

    var body: some View {
        VStack(spacing: 12) {
            PrimaryButton(title: "Sign In") {
                Task { await vm.signIn() }
            }

            Text("Don't have an account? \(Text("Sign Up").bold().foregroundStyle(Color.appPrimary))")
                .font(.default)
                .foregroundStyle(Color.appTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
    }
}

#Preview {
    LoginBottomSection(vm: LoginViewModel())
        .padding()
        .background(Color.appBackground)
}
