import CoreImage.CIFilterBuiltins
import SwiftUI

struct LinkDetailQuickShareCard: View {
    let qrImage: UIImage
    @Binding var showSheet: Bool

    var body: some View {
        Button { showSheet = true } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Quick Share")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.white)
                    Text("Generate QR for this link")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.5))
                }

                Spacer()

                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .frame(width: 56, height: 56)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(16)
            .frame(maxWidth: .infinity)
            .cardSurface()
        }
        .buttonStyle(PressableButtonStyle())
    }
}

private func makePreviewQR() -> UIImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    filter.message = Data("https://example.com/abc123".utf8)
    filter.correctionLevel = "M"
    guard let output = filter.outputImage else { return UIImage() }
    let scaled = output.transformed(by: CGAffineTransform(scaleX: 12, y: 12))
    guard let cgImage = context.createCGImage(scaled, from: scaled.extent) else { return UIImage() }
    return UIImage(cgImage: cgImage)
}

#Preview("Quick Share Card") {
    @Previewable @State var showSheet = false
    LinkDetailQuickShareCard(qrImage: makePreviewQR(), showSheet: $showSheet)
        .padding()
        .background(Color.appBackgroundApp)
}

#Preview("QR Sheet") {
    QRCodeSheet(qrImage: makePreviewQR())
}

struct QRCodeSheet: View {
    let qrImage: UIImage
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.appBackgroundApp.ignoresSafeArea()

            VStack(spacing: 32) {
                Text("Scan to open link")
                    .font(.headline)
                    .foregroundStyle(.white)

                Image(uiImage: qrImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260)
                    .padding(20)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                SecondaryButton(title: "Close") { dismiss() }
                    .frame(maxWidth: 200)
            }
            .padding(32)
        }
    }
}
