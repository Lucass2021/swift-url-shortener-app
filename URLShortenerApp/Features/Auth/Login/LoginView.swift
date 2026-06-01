import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @State private var showRegister = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                LoginLogoSection()

                Spacer().frame(height: 48)

                LoginFormSection(viewModel: viewModel)

                Spacer()

                LoginBottomSection(viewModel: viewModel, showRegister: $showRegister)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showRegister) { RegisterView() }
        .toast(message: $viewModel.errorMessage)
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
    .environment(AuthStore())
}
