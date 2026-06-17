import SwiftUI

struct MainHeader: ToolbarContent {
    let title: String
    let onProfileTap: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            Text(title)
                .font(.headline.bold())
                .foregroundStyle(.white)
        }
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: onProfileTap) {
                Image(systemName: "person.circle.fill")
                    .font(.title3)
                    .foregroundStyle(Color.appPrimary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Color.appBackgroundApp.ignoresSafeArea()
            .toolbar {
                MainHeader(title: "My Links") {}
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}
