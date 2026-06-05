import SwiftUI

struct AppView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var viewModel = AppViewModel()
    @State private var showProfile = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundApp.ignoresSafeArea()

                if viewModel.isLoading && viewModel.links.isEmpty {
                    ProgressView()
                        .tint(.white)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    List {
                        AppDashboardSection(viewModel: viewModel)
                        AppLinksSection(viewModel: viewModel)
                    }
                    .scrollContentBackground(.hidden)
                    .refreshable { await viewModel.load() }
                }
            }
            .toolbar {
                AppHeader(title: "My Links") { showProfile = true }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showProfile) {
                ProfileView()
                    .environment(authStore)
            }
            .overlay(alignment: .bottom) {
                AppAddButton()
                    .padding(.bottom, 32)
            }
            .task { await viewModel.load() }
        }
    }
}

#Preview {
    AppView()
        .environment(AuthStore())
}
