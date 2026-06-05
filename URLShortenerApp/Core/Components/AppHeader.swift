import SwiftUI

struct AppHeader: ToolbarContent {
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
