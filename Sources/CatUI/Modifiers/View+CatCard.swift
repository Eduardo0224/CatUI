import SwiftUI

// MARK: - CatCard Modifier

/// Applies card styling to any view: padding, background, corner radius, shadow.
/// Use on VStack/HStack containers that need card appearance.
/// Do NOT apply on CatCardView — it already has this styling built in.
public struct CatCardModifier: ViewModifier {
    public var cornerRadius: CGFloat = CatRadius.radius12
    public var shadowRadius: CGFloat = 4

    public func body(content: Content) -> some View {
        content
            .padding(CatSpacing.spacing16)
            .background(Color.catSurfaceSecondary)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.08), radius: shadowRadius, y: 2)
    }
}

public extension View {
    func catCardStyle(cornerRadius: CGFloat = CatRadius.radius12, shadowRadius: CGFloat = 4) -> some View {
        modifier(CatCardModifier(cornerRadius: cornerRadius, shadowRadius: shadowRadius))
    }
}

// MARK: - Previews

#Preview("Card Style", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: 8) {
        Text("Card via modifier").font(.catHeadline)
        Text("This VStack uses .catCardStyle()").font(.catBody)
    }
    .catCardStyle()
    .padding()
}

#Preview("Card Style Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(alignment: .leading, spacing: 8) {
        Text("Card via modifier").font(.catHeadline)
        Text("This VStack uses .catCardStyle()").font(.catBody)
    }
    .catCardStyle()
    .padding()
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
