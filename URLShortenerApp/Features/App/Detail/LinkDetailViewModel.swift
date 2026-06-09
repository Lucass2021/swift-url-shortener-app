import CoreImage.CIFilterBuiltins
import SwiftUI

@Observable
final class LinkDetailViewModel {
    let link: Link

    var stats: LinkStats?
    var isLoading = false
    var errorMessage: String?
    var isCopied = false
    var showQRSheet = false
    var showDeleteAlert = false
    var didDelete = false

    init(link: Link) {
        self.link = link
    }

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            stats = try await AppService.fetchLinkStats(code: link.code)
        } catch {
            errorMessage = "Failed to load stats."
        }
    }

    func copyLink(shortURL: String) {
        UIPasteboard.general.string = shortURL
        withAnimation(.spring(duration: 0.3)) {
            isCopied = true
        }
        Task {
            try? await Task.sleep(for: .seconds(2))
            withAnimation(.spring(duration: 0.3)) {
                isCopied = false
            }
        }
    }

    func delete() async {
        do {
            try await AppService.deleteLink(code: link.code)
            didDelete = true
        } catch {
            errorMessage = "Failed to delete link."
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()

        filter.message = Data(string.utf8)
        filter.correctionLevel = "M"

        guard let outputImage = filter.outputImage else {
            return UIImage()
        }

        let scaled = outputImage.transformed(
            by: CGAffineTransform(scaleX: 12, y: 12)
        )

        guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else {
            return UIImage()
        }

        return UIImage(cgImage: cgImage)
    }
}
