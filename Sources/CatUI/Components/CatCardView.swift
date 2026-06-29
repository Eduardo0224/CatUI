import SwiftUI

// MARK: - CatCardView

/// Card container with built-in styling: padding, background, shadow, corner radius.
/// Do NOT apply `.catCardStyle()` on top of this view — it already includes card styling.
public struct CatCardView<Content: View>: View {

    // MARK: - Properties

    @ViewBuilder let content: Content

    // MARK: - Body

    public var body: some View {
        content
            .padding(CatSpacing.spacing16)
            .background(Color.catSurfaceSecondary)
            .clipShape(RoundedRectangle(cornerRadius: CatRadius.radius12))
            .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
    }

    // MARK: - Initializers

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}

// MARK: - Previews

#Preview("Card Light", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatCardView {
        VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
            Text("Bengal").font(.catTitle)
            Text("Active, Energetic, Playful").font(.catBody)
                .foregroundStyle(Color.catTextSecondary)
        }
    }
    .padding()
    .background(Color.catSurfacePrimary)
}

#Preview("Card Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatCardView {
        VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
            Text("Bengal").font(.catTitle)
            Text("Active, Energetic, Playful").font(.catBody)
                .foregroundStyle(Color.catTextSecondary)
        }
    }
    .padding()
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
