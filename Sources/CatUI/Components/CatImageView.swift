import SwiftUI

// MARK: - CatImageView

/// Async image loader with memory + disk caching, placeholder, shimmer, and error states.
///
/// Uses ``ImageCacheService`` internally to cache downloaded images in memory and on disk.
/// For direct cache access, use `ImageCacheService.shared`.
public struct CatImageView: View {

    // MARK: - Properties

    let url: URL?
    var cornerRadius: CGFloat = CatRadius.radius12
    var maxWidth: CGFloat? = nil

    @State private var loadedImage: UIImage?
    @State private var loadFailed = false

    // MARK: - Body

    public var body: some View {
        Group {
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if loadFailed {
                placeholder
                    .overlay {
                        Image(systemName: "cat")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
            } else {
                placeholder
                    .shimmer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .task(id: url) {
            await loadImage()
        }
    }

    // MARK: - Private Views

    private var placeholder: some View {
        Rectangle()
            .fill(Color.catSurfaceSecondary)
    }

    // MARK: - Private Functions

    private func loadImage() async {
        guard let url else {
            loadFailed = false
            loadedImage = nil
            return
        }

        loadFailed = false

        do {
            loadedImage = try await ImageCacheService.shared.image(for: url, maxWidth: maxWidth)
        } catch {
            loadFailed = true
        }
    }

    // MARK: - Initializers

    /// Creates a cached async image view
    /// - Parameters:
    ///   - url: The URL of the image to load and cache
    ///   - cornerRadius: Corner radius applied to the image (default: `CatRadius.radius12`)
    ///   - maxWidth: Optional maximum width in points for the cached image. Uses service default if nil
    public init(url: URL?, cornerRadius: CGFloat = CatRadius.radius12, maxWidth: CGFloat? = nil) {
        self.url = url
        self.cornerRadius = cornerRadius
        self.maxWidth = maxWidth
    }
}

// MARK: - Previews

#Preview("Image Loaded", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatImageView(url: URL(string: "https://cdn2.thecatapi.com/images/beng.jpg"))
        .frame(width: 200, height: 200)
}

#Preview("Image Loading", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatImageView(url: nil)
        .frame(width: 200, height: 200)
        .padding()
        .background(Color.catSurfacePrimary)
}

#Preview("Image Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatImageView(url: URL(string: "https://cdn2.thecatapi.com/images/beng.jpg"))
        .frame(width: 200, height: 200)
        .padding()
        .background(Color.catSurfacePrimary)
        .preferredColorScheme(.dark)
}
