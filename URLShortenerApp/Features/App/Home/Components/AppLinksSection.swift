import SwiftUI

struct AppLinksSection: View {
    let viewModel: AppViewModel
    @Binding var selectedLink: Link?
    @State private var linkToDelete: Link?

    var body: some View {
        Section {
            ForEach(viewModel.links) { link in
                Button { selectedLink = link } label: {
                    LinkRowView(
                        link: link,
                        isDeleting: viewModel.deletingLinkIDs.contains(link.id)
                    )
                }
                .buttonStyle(PressableButtonStyle())
                .disabled(viewModel.deletingLinkIDs.contains(link.id))
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button {
                        linkToDelete = link
                    } label: {
                        Label("Delete", systemImage: "trash")
                            .labelStyle(.iconOnly)
                    }
                    .tint(.red)
                }
            }
        }
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
        .listRowSeparator(.hidden)
        .alert("Delete Link?", isPresented: Binding(
            get: { linkToDelete != nil },
            set: { if !$0 { linkToDelete = nil } }
        ), presenting: linkToDelete) { link in
            Button("Delete", role: .destructive) {
                Task { await viewModel.delete(link) }
                linkToDelete = nil
            }
            Button("Cancel", role: .cancel) {}
        } message: { _ in
            Text("This action cannot be undone.")
        }
    }
}
