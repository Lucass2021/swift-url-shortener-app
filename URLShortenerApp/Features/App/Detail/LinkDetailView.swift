import SwiftUI

struct LinkDetailView: View {
    let link: Link
    let onDelete: () -> Void

    @State private var viewModel: LinkDetailViewModel
    @Environment(\.dismiss) private var dismiss

    init(link: Link, onDelete: @escaping () -> Void) {
        self.link = link
        self.onDelete = onDelete
        _viewModel = State(initialValue: LinkDetailViewModel(link: link))
    }

    var body: some View {
        ZStack {
            Color.appBackgroundApp.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 12) {
                    LinkDetailHeroCard(
                        shortURL: link.shortURL,
                        isCopied: viewModel.isCopied,
                        onCopy: { viewModel.copyLink(shortURL: link.shortURL) }
                    )
                    .staggeredAppear(0)

                    originalURLRow
                        .staggeredAppear(1)

                    LinkDetailStatsSection(
                        link: link,
                        stats: viewModel.stats,
                        isLoading: viewModel.isLoading && viewModel.stats == nil
                    )
                    .staggeredAppear(2)

                    LinkDetailQuickShareCard(
                        qrImage: viewModel.generateQRCode(from: link.shortURL),
                        showSheet: $viewModel.showQRSheet
                    )
                    .staggeredAppear(3)

                    deleteButton
                        .staggeredAppear(4)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            GoBackHeader(title: "Back") { dismiss() }
        }
        .enableSwipeBack()
        .task { await viewModel.load() }
        .sheet(isPresented: $viewModel.showQRSheet) {
            QRCodeSheet(qrImage: viewModel.generateQRCode(from: link.shortURL))
        }
        .alert("Delete Link?", isPresented: $viewModel.showDeleteAlert) {
            Button("Delete", role: .destructive) {
                Task { await viewModel.delete() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .onChange(of: viewModel.didDelete) { _, deleted in
            if deleted { onDelete()
                dismiss()
            }
        }
        .toast(message: $viewModel.errorMessage, style: .error)
    }

    private var originalURLRow: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Original URL")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                Text(link.originalUrl)
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .lineLimit(1)
            }

            Spacer()

            if let url = URL(string: link.originalUrl) {
                SwiftUI.Link(destination: url) {
                    Image(systemName: "arrow.up.right.square")
                        .foregroundStyle(Color.appPrimary)
                        .font(.title3)
                }
            }
        }
        .padding(16)
        .cardSurface()
    }

    private var deleteButton: some View {
        Button { viewModel.showDeleteAlert = true } label: {
            HStack(spacing: 8) {
                Image(systemName: "trash")
                Text("Delete Link")
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(Color.appDestructive)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(Color.appDestructive.opacity(0.12))
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.appDestructive.opacity(0.3), lineWidth: 0.5)
            )
        }
        .padding(.top, 12)
    }
}

#Preview {
    NavigationStack {
        LinkDetailView(
            link: Link(
                code: "abc123",
                originalUrl: "https://www.example.com/some/very/long/url",
                clicks: 42,
                createdAt: Date(),
                expiresAt: nil,
                isProtected: false
            ),
            onDelete: {}
        )
    }
}
