import SwiftUI

struct AppView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var viewModel = AppViewModel()
    @State private var showProfile = false
    @State private var showCreateLink = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackgroundApp.ignoresSafeArea()

                if viewModel.isLoading && viewModel.links.isEmpty {
                    HomeSkeletonView()
                } else if let error = viewModel.errorMessage {
                    AppErrorView(message: error) {
                        Task { await viewModel.load() }
                    }
                } else if viewModel.links.isEmpty {
                    AppEmptyStateView()
                } else {
                    List {
                        AppDashboardSection(viewModel: viewModel)
                        AppLinksSection(viewModel: viewModel)
                    }
                    .contentMargins(.bottom, 120, for: .scrollContent)
                    .listSectionSpacing(20)
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
                AppAddButton { showCreateLink = true }
                    .padding(.bottom, 32)
            }
            .task { await viewModel.load() }
            .toast(message: $viewModel.deleteError, style: .error)
            .navigationDestination(isPresented: $showCreateLink) {
                CreateLinkView {
                    Task { await viewModel.load() }
                }
            }
        }
    }
}

#Preview {
    AppView()
        .environment(AuthStore())
}
