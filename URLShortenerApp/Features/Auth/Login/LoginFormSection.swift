import SwiftUI

struct LoginFormSection: View {
    @Bindable var vm: LoginViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Email Address")
                    .font(.callout)
                    .foregroundStyle(Color.white)

                AuthTextField(
                    placeholder: "name@company.com",
                    icon: "envelope",
                    text: $vm.email
                )
            }

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Password")
                        .font(.callout)
                        .foregroundStyle(Color.white)

                    Spacer()
                }

                AuthTextField(
                    placeholder: "••••••••",
                    icon: "lock",
                    text: $vm.password,
                    isSecure: true
                )

                Button("Forgot Password?") {}
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
    @Previewable @State var vm = LoginViewModel()
    LoginFormSection(vm: vm)
        .padding()
        .background(Color.appBackground)
}
