import SwiftUI

struct SetPasscodeSheet: View {
    @Binding var passcode: String
    let onConfirm: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 8) {
                Image(systemName: "lock.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.orange)

                Text("Set a Passcode")
                    .font(.title2).bold()
                    .foregroundStyle(Color.appTextPrimary)

                Text("Anyone with your link will need this\n4-digit code to access the destination.")
                    .font(.subheadline)
                    .foregroundStyle(Color.appTextSecondary)
                    .multilineTextAlignment(.center)
            }

            OTPField(code: $passcode, length: 4)

            PrimaryButton(title: "Confirm", isLoading: false) {
                onConfirm()
            }
            .disabled(passcode.count < 4)
            .opacity(passcode.count < 4 ? 0.5 : 1)
        }
        .padding(24)
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackground(Color.appSurface)
    }
}
