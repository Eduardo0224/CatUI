import SwiftUI

// MARK: - CatImageView

/// Async image loader with placeholder, shimmer, and error states.
public struct CatImageView: View {

    // MARK: - Properties

    let url: URL?
    var cornerRadius: CGFloat = CatRadius.radius12

    // MARK: - Body

    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                placeholder
                    .shimmer()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                placeholder
                    .overlay {
                        Image(systemName: "cat")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
            @unknown default:
                placeholder
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

    // MARK: - Private Views

    private var placeholder: some View {
        Rectangle()
            .fill(Color.catSurfaceSecondary)
    }

    // MARK: - Initializers

    public init(url: URL?, cornerRadius: CGFloat = CatRadius.radius12) {
        self.url = url
        self.cornerRadius = cornerRadius
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
