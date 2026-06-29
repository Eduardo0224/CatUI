import SwiftUI

// MARK: - CatFloatingButton

/// Circular floating action button for primary actions (like/dislike, add, share).
/// Uses the system glass effect on iOS 26 for a premium feel.
public struct CatFloatingButton: View {

    // MARK: - Variant

    public enum Variant {
        case like      // Heart icon, accent background
        case dislike   // XMark icon, secondary surface
        case share     // Arrow icon, secondary surface

        var icon: String {
            switch self {
            case .like: "heart.fill"
            case .dislike: "xmark"
            case .share: "square.and.arrow.up"
            }
        }
    }

    // MARK: - Properties

    let variant: Variant
    let action: () -> Void

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            Image(systemName: variant.icon)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(foregroundColor)
                .frame(width: 64, height: 64)
                .background(
                    Circle()
                        .fill(backgroundColor)
                        .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                )
        }
        .buttonStyle(.plain)
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch variant {
        case .like: .catTextOnAccent
        case .dislike: .catTextPrimary
        case .share: .catTextPrimary
        }
    }

    private var backgroundColor: Color {
        switch variant {
        case .like: .catAccent
        case .dislike: .catSurfaceSecondary
        case .share: .catSurfaceSecondary
        }
    }

    // MARK: - Initializers

    public init(variant: Variant, action: @escaping () -> Void) {
        self.variant = variant
        self.action = action
    }
}

// MARK: - Previews

#Preview("Floating Buttons", traits: .catUIFonts, .sizeThatFitsLayout) {
    HStack(spacing: 24) {
        CatFloatingButton(variant: .dislike) { }
        CatFloatingButton(variant: .like) { }
        CatFloatingButton(variant: .share) { }
    }
    .padding(32)
    .background(Color.catSurfacePrimary)
}

#Preview("Floating Buttons Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    HStack(spacing: 24) {
        CatFloatingButton(variant: .dislike) { }
        CatFloatingButton(variant: .like) { }
        CatFloatingButton(variant: .share) { }
    }
    .padding(32)
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
