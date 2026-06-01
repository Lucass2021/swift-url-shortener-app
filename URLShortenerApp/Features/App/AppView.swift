import SwiftUI

struct AppView: View {
    @Environment(AuthStore.self) private var authStore

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                Text("My Links — coming soon")
                    .foregroundStyle(.white)
            }
            .navigationTitle("My Links")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Sign Out") { authStore.logout() }
                        .foregroundStyle(Color.appPrimary)
                }
            }
        }
    }
}

#Preview {
    AppView()
        .environment(AuthStore())
}
