import SwiftUI

struct LoginView: View {
    @State private var vm = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer()

                    LoginLogoSection()

                    Spacer().frame(height: 48)

                    LoginFormSection(vm: vm)

                    Spacer()

                    LoginBottomSection(vm: vm)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginView()
}
