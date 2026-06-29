import SwiftUI

// MARK: - CatLoadingView

/// Loading indicator with optional message.
public struct CatLoadingView: View {

    // MARK: - Properties

    var message: String?

    // MARK: - Body

    public var body: some View {
        VStack(spacing: CatSpacing.spacing16) {
            ProgressView()
                .controlSize(.large)

            if let message {
                Text(message)
                    .font(.catBody)
                    .foregroundStyle(Color.catTextSecondary)
            }
        }
        .padding(CatSpacing.spacing24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Initializers

    public init(message: String? = nil) {
        self.message = message
    }
}

// MARK: - Previews

#Preview("Loading", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatLoadingView(message: "Loading cats...")
}

#Preview("Loading Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatLoadingView(message: "Loading cats...")
        .background(Color.catSurfacePrimary)
        .preferredColorScheme(.dark)
}
