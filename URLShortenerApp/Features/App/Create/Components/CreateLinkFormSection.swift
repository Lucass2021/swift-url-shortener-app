import SwiftUI

struct CreateLinkFormSection: View {
    @Bindable var viewModel: CreateLinkViewModel
    @State private var showPasscodeSheet = false

    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Target Destination")
                    .font(.caption).fontWeight(.semibold)
                    .foregroundStyle(Color.appTextSecondary)
                    .textCase(.uppercase).tracking(0.5)

                AuthTextField(
                    placeholder: "https://example.com",
                    icon: "link",
                    text: $viewModel.url,
                    error: viewModel.urlError
                )
                .onChange(of: viewModel.url) {
                    viewModel.urlError = nil
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Expiration")
                    .font(.caption).fontWeight(.semibold)
                    .foregroundStyle(Color.appTextSecondary)
                    .textCase(.uppercase).tracking(0.5)

                ExpirationPicker(selected: $viewModel.selectedExpiration)
            }

            VStack(spacing: 12) {
                ToggleOptionRow(
                    icon: "lock.fill",
                    iconColor: .orange,
                    title: "Passcode Protect",
                    subtitle: viewModel.passcodeEnabled && viewModel.passcode.count == 4
                        ? "Protected • ••••"
                        : "Require a 4-digit code to access the destination.",
                    isOn: $viewModel.passcodeEnabled
                )
            }
        }
        .onChange(of: viewModel.passcodeEnabled) { _, enabled in
            if enabled {
                showPasscodeSheet = true
            } else {
                viewModel.passcode = ""
            }
        }

        .sheet(isPresented: $showPasscodeSheet, onDismiss: {
            if viewModel.passcode.count < 4 {
                viewModel.passcodeEnabled = false
                viewModel.passcode = ""
            }
        }) {
            SetPasscodeSheet(passcode: $viewModel.passcode) {
                showPasscodeSheet = false
            }
        }
    }
}

#Preview {
    ZStack {
        Color.appBackgroundApp.ignoresSafeArea()
        CreateLinkFormSection(viewModel: CreateLinkViewModel())
            .padding(.horizontal, 20)
    }
}
