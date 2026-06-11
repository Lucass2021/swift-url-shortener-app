import SwiftUI

struct AppView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var viewModel = AppViewModel()
    @State private var showProfile = false
    @State private var showCreateLink = false
    @State private var selectedLink: Link?

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
                        AppLinksSection(viewModel: viewModel, selectedLink: $selectedLink)
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
            .navigationDestination(item: $selectedLink) { link in
                LinkDetailView(link: link) {
                    selectedLink = nil
                    Task { await viewModel.load() }
                }
            }
            .navigationDestination(isPresented: $showProfile) {
                ProfileView(
                    totalClicks: viewModel.totalClicks,
                    activeLinks: viewModel.activeLinksCount
                )
            }
        }
    }
}

#Preview {
    AppView()
        .environment(AuthStore())
}
