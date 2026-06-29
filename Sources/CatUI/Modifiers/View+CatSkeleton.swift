import SwiftUI

// MARK: - CatSkeleton Modifier

/// Combines `.redacted(reason: .placeholder)` with `.shimmer()` and disables
/// interaction during loading to create a complete skeleton loading state.
///
/// ## Important: ScrollView / List Usage
///
/// **Apply ONLY to individual static shapes or components.**
/// **NEVER apply to ScrollView, List, or any container whose content
/// can scroll on its own.**
///
/// During the rubber-band bounce of a scroll view, a skeleton applied to the
/// entire scrollable area will have its mask anchored to the original frame
/// while the real content moves, producing visual duplicates ("ghosts").
///
/// ```swift
/// // ❌ WRONG — skeleton masks desync during bounce
/// ScrollView {
///     VStack { ... }
/// }
/// .catSkeleton(true)
///
/// // ✅ CORRECT — each card skeleton is independent
/// ScrollView {
///     VStack {
///         ForEach(0..<5) { _ in
///             skeletonCard
///                 .catSkeleton(true)
///         }
///     }
/// }
/// ```
///
/// ## Usage
///
/// ```swift
/// CatCardView {
///     VStack {
///         Text("Loading...")
///         Text("Subtitle")
///     }
/// }
/// .catSkeleton(true)  // grayed out + shimmer + disabled
/// .catSkeleton(false) // normal appearance
/// ```
public struct CatSkeletonModifier: ViewModifier {

    // MARK: - Properties

    var isLoading: Bool

    // MARK: - Initializers

    public init(isLoading: Bool = true) {
        self.isLoading = isLoading
    }

    // MARK: - Body

    public func body(content: Content) -> some View {
        if isLoading {
            content
                .redacted(reason: .placeholder)
                .shimmer()
                .disabled(true)
        } else {
            content
        }
    }
}

public extension View {

    /// Apply skeleton loading effect with redacted placeholder, shimmer animation,
    /// and disabled interaction while loading.
    /// - Parameter isLoading: Whether the loading state is active
    /// - Returns: View with skeleton loading effect when loading
    func catSkeleton(_ isLoading: Bool = true) -> some View {
        modifier(CatSkeletonModifier(isLoading: isLoading))
    }
}

// MARK: - Previews

#Preview("Skeleton Loading", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(spacing: CatSpacing.spacing24) {
        // Loading state
        CatCardView {
            VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
                Text("Cat Name Placeholder")
                    .font(.catHeadline)
                Text("Breed Description Placeholder")
                    .font(.catCaption)
                    .foregroundStyle(Color.catTextSecondary)
                Text("Additional details that span multiple lines of text")
                    .font(.catFootnote)
                    .foregroundStyle(Color.catTextSecondary)
            }
        }
        .catSkeleton(true)

        // Loaded state
        CatCardView {
            VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
                Text("Bengal")
                    .font(.catHeadline)
                Text("Active, Energetic, Playful")
                    .font(.catCaption)
                    .foregroundStyle(Color.catTextSecondary)
                Text("The Bengal is a highly active, intelligent cat that loves to climb and play.")
                    .font(.catFootnote)
                    .foregroundStyle(Color.catTextSecondary)
            }
        }
        .catSkeleton(false)
    }
    .padding()
    .background(Color.catSurfacePrimary)
}

#Preview("Skeleton Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    VStack(spacing: CatSpacing.spacing24) {
        CatCardView {
            VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
                Text("Cat Name Placeholder")
                    .font(.catHeadline)
                Text("Breed Description Placeholder")
                    .font(.catCaption)
            }
        }
        .catSkeleton(true)
    }
    .padding()
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
