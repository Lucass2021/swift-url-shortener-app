import SwiftUI

struct GoBackHeader: ToolbarContent {
    var title: String = "Back"
    let onBack: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button(action: onBack) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .fontWeight(.semibold)
                    Text(title)
                }
                .foregroundStyle(.white.opacity(0.8))
            }
        }
    }
}

#Preview {
    NavigationStack {
        Color.appBackgroundApp.ignoresSafeArea()
            .toolbar {
                GoBackHeader(title: "Back") {}
            }
    }
}
