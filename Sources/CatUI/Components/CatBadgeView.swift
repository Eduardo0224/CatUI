import SwiftUI

// MARK: - CatBadgeView

/// Small badge for labels: temperament traits, origin, status.
public struct CatBadgeView: View {

    // MARK: - Style

    public enum Style {
        case filled      // Accent subtle background, accent text
        case accent      // Accent background, white text
        case outlined    // Transparent, accent border
    }

    // MARK: - Properties

    let text: String
    var style: Style = .filled

    // MARK: - Body

    public var body: some View {
        Text(text)
            .font(.catCaption)
            .fontWeight(.medium)
            .padding(.horizontal, CatSpacing.spacing8)
            .padding(.vertical, CatSpacing.spacing4)
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
            .clipShape(Capsule())
            .overlay {
                if style == .outlined {
                    Capsule()
                        .stroke(Color.catAccent, lineWidth: 1)
                }
            }
    }

    // MARK: - Private Properties

    private var foregroundColor: Color {
        switch style {
        case .filled: .catAccent
        case .accent: .catTextOnAccent
        case .outlined: .catAccent
        }
    }

    private var backgroundColor: Color {
        switch style {
        case .filled: .catAccentSubtle
        case .accent: .catAccent
        case .outlined: .clear
        }
    }

    // MARK: - Initializers

    public init(_ text: String, style: Style = .filled) {
        self.text = text
        self.style = style
    }
}

// MARK: - Previews

#Preview("Badge Styles", traits: .catUIFonts, .sizeThatFitsLayout) {
    HStack(spacing: 12) {
        CatBadgeView("Playful", style: .filled)
        CatBadgeView("Active", style: .accent)
        CatBadgeView("Gentle", style: .outlined)
    }
    .padding()
    .background(Color.catSurfacePrimary)
}

#Preview("Badge Styles Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    HStack(spacing: 12) {
        CatBadgeView("Playful", style: .filled)
        CatBadgeView("Active", style: .accent)
        CatBadgeView("Gentle", style: .outlined)
    }
    .padding()
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
