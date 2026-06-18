import SwiftUI

struct HomeView: View {
    @Environment(AuthStore.self) private var authStore
    @State private var viewModel = HomeViewModel()
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
                    HomeErrorView(message: error) {
                        Task { await viewModel.load() }
                    }
                } else if viewModel.links.isEmpty {
                    HomeEmptyStateView()
                } else {
                    List {
                        HomeDashboardSection(viewModel: viewModel)
                        HomeLinksSection(viewModel: viewModel, selectedLink: $selectedLink)
                    }
                    .contentMargins(.bottom, 120, for: .scrollContent)
                    .listSectionSpacing(20)
                    .scrollContentBackground(.hidden)
                    .refreshable { await viewModel.load() }
                    .animation(.default, value: viewModel.links)
                }
            }
            .toolbar {
                MainHeader(title: "My Links") { showProfile = true }
            }
            .navigationBarTitleDisplayMode(.inline)
            .overlay(alignment: .bottom) {
                FloatingAddButton { showCreateLink = true }
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
    HomeView()
        .environment(AuthStore())
}
