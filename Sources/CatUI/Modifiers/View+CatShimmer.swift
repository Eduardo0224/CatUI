import SwiftUI

// MARK: - Shimmer Modifier

/// Adds a shimmer/loading animation overlay to any view.
///
/// Uses `.mask(content)` to ensure the shimmer conforms to the content's shape,
/// respecting rounded corners, text glyphs, and other non-rectangular bounds.
///
/// ## Important: ScrollView / List Usage
///
/// **Apply ONLY to individual static shapes or components.**
/// **NEVER apply to ScrollView, List, or any container whose content
/// can scroll on its own.**
///
/// During the rubber-band bounce of a scroll view, a shimmer applied to the
/// entire scrollable area will have its mask anchored to the original frame
/// while the real content moves, producing visual duplicates ("ghosts").
/// Applying `.shimmer()` to each placeholder rectangle individually prevents
/// this because every piece is static and its mask always matches its position.
///
/// ```swift
/// // ❌ WRONG — shimmer masks desync during bounce
/// ScrollView {
///     VStack { ... }
/// }
/// .shimmer()
///
/// // ✅ CORRECT — each placeholder owns its shimmer
/// ScrollView {
///     VStack {
///         RoundedRectangle(cornerRadius: 14)
///             .fill(Color.secondary.opacity(0.2))
///             .frame(width: 110, height: 110)
///             .shimmer()
///     }
/// }
/// ```
///
/// ## Accessibility
///
/// When Reduce Motion is enabled in system settings, the shimmer animation
/// is automatically disabled. The overlay remains static, and the view
/// should be combined with `.redacted(reason: .placeholder)` for a
/// motion-free skeleton loading state.
public struct ShimmerModifier: ViewModifier {

    // MARK: - States

    @State private var phase: CGFloat = -1

    // MARK: - Environment

    @Environment(\.accessibilityReduceMotion) private var reduceMotionEnabled

    // MARK: - Initializers

    public init() { }

    // MARK: - Body

    public func body(content: Content) -> some View {
        content
            .overlay {
                shimmerOverlay
                    .mask(content)
            }
    }

    // MARK: - Private Views

    private var shimmerOverlay: some View {
        GeometryReader { geometry in
            LinearGradient(
                colors: [
                    .clear,
                    .white.opacity(0.35),
                    .clear
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
            .frame(width: geometry.size.width * 0.5)
            .offset(x: shimmerOffset(for: geometry))
            .onAppear {
                guard !reduceMotionEnabled else { return }
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase = 1.5
                }
            }
        }
        .clipped()
    }

    // MARK: - Private Functions

    /// When Reduce Motion is enabled, the shimmer is kept at its midpoint
    /// so the gradient is visible but static — still works as a loading
    /// indicator when paired with `.redacted(reason: .placeholder)`.
    private func shimmerOffset(for geometry: GeometryProxy) -> CGFloat {
        if reduceMotionEnabled {
            return 0.25 * geometry.size.width
        }
        return phase * geometry.size.width
    }
}

public extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

// MARK: - Previews

#Preview("Shimmer", traits: .catUIFonts, .sizeThatFitsLayout) {
    RoundedRectangle(cornerRadius: CatRadius.radius12)
        .fill(Color.catSurfaceSecondary)
        .frame(height: 80)
        .shimmer()
        .padding()
}

#Preview("Shimmer Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    RoundedRectangle(cornerRadius: CatRadius.radius12)
        .fill(Color.catSurfaceSecondary)
        .frame(height: 80)
        .shimmer()
        .padding()
        .background(Color.catSurfacePrimary)
        .preferredColorScheme(.dark)
}
