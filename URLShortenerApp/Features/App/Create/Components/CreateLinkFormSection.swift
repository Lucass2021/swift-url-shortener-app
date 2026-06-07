import SwiftUI

struct CreateLinkFormSection: View {
    @Bindable var viewModel: CreateLinkViewModel

    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Target Destination")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.appTextSecondary)
                    .textCase(.uppercase)
                    .tracking(0.5)

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
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.appTextSecondary)
                    .textCase(.uppercase)
                    .tracking(0.5)

                ExpirationPicker(
                    selected: $viewModel.selectedExpiration
                )
            }
        }
    }
}

#Preview {
    @Previewable @State var viewModel = CreateLinkViewModel()
    CreateLinkFormSection(viewModel: viewModel)
        .padding()
        .background(Color.appBackground)
}
