import SwiftUI

struct AppLinksSection: View {
    let viewModel: AppViewModel

    var body: some View {
        Section {
            ForEach(viewModel.links) { link in
                LinkRowView(link: link)
            }
            .onDelete { offsets in
                Task { await viewModel.delete(at: offsets) }
            }
        }
        .listRowBackground(Color.appBackground.opacity(0.6))
    }
}
