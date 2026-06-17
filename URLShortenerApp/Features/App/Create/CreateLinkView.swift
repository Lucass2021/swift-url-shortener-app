import SwiftUI

struct CreateLinkView: View {
    let onSuccess: () -> Void
    @State private var viewModel = CreateLinkViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.appBackgroundApp.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Create Link")
                        .font(.largeTitle).bold()
                        .foregroundStyle(.white)

                    Text("Transform your long URLs into clean, manageable links.")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                }
                .padding(.top, 8)
                .staggeredAppear(0)

                Spacer().frame(height: 40)

                CreateLinkFormSection(viewModel: viewModel)
                    .staggeredAppear(1)

                Spacer()

                PrimaryButton(title: "Shorten URL", isLoading: viewModel.isLoading) {
                    Task { await viewModel.shorten() }
                }
                .padding(.bottom, 16)
                .staggeredAppear(2)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            GoBackHeader(title: "Back") { dismiss() }
        }
        .enableSwipeBack()
        .overlay {
            if viewModel.didSucceed {
                SuccessOverlay(message: "Link created!")
            }
        }
        .onChange(of: viewModel.didSucceed) { _, succeeded in
            if succeeded {
                Task {
                    try? await Task.sleep(for: .seconds(0.9))
                    onSuccess()
                    dismiss()
                }
            }
        }
        .toast(message: $viewModel.errorMessage, style: .error)
    }
}

#Preview {
    NavigationStack {
        CreateLinkView {}
    }
}
