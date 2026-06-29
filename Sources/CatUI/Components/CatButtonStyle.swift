import SwiftUI

// MARK: - CatButtonStyle

/// Button style with primary, secondary, and ghost variants.
public struct CatButtonStyle: ButtonStyle {

    // MARK: - Variant

    public enum Variant {
        case primary
        case secondary
        case ghost
    }

    // MARK: - Properties

    let variant: Variant

    // MARK: - Body

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.catHeadline)
            .padding(.horizontal, CatSpacing.spacing24)
            .padding(.vertical, CatSpacing.spacing12)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: CatRadius.radius12))
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch variant {
        case .primary: .catTextOnAccent
        case .secondary: .catTextPrimary
        case .ghost: .catAccent
        }
    }

    private var backgroundColor: Color {
        switch variant {
        case .primary: .catAccent
        case .secondary: .catSurfaceSecondary
        case .ghost: .clear
        }
    }

    // MARK: - Initializers

    public init(variant: Variant = .primary) {
        self.variant = variant
    }
}

// MARK: - View Extension

public extension View {
    func catButtonStyle(variant: CatButtonStyle.Variant = .primary) -> some View {
        buttonStyle(CatButtonStyle(variant: variant))
    }
}

// MARK: - CatButton

/// Convenience button using CatButtonStyle.
public struct CatButton: View {

    // MARK: - Properties

    let title: String
    let variant: CatButtonStyle.Variant
    let action: () -> Void

    // MARK: - Body

    public var body: some View {
        Button(action: action) {
            Text(title)
        }
        .catButtonStyle(variant: variant)
    }

    // MARK: - Initializers

    public init(
        _ title: String,
        variant: CatButtonStyle.Variant = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.variant = variant
        self.action = action
    }
}

// MARK: - Previews

#Preview("Button Variants Light", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        CatButton("Like — Primary", variant: .primary) { }
        CatButton("See Details — Secondary", variant: .secondary) { }
        CatButton("Retry — Ghost", variant: .ghost) { }
    }
    .padding()
    .background(Color.catSurfacePrimary)
}

#Preview("Button Variants Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(spacing: 16) {
        CatButton("Like — Primary", variant: .primary) { }
        CatButton("See Details — Secondary", variant: .secondary) { }
        CatButton("Retry — Ghost", variant: .ghost) { }
    }
    .padding()
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
