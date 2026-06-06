import SwiftUI

struct RegisterLogoSection: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color.appSurface)
                    .frame(width: 100, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 22)
                            .stroke(Color.white, lineWidth: 0.3)
                    )

                Image(systemName: "link")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(Color.appPrimary)
            }

            VStack(spacing: 8) {
                Text("Join LinkShort")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(Color.appTextPrimary)

                Text("Create an account to start managing your \nlinks with precision.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextPrimary)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    RegisterLogoSection()
        .padding()
        .background(Color.appBackground)
}
