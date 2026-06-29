import SwiftUI

// MARK: - CatUIPreviewModifier

/// PreviewModifier that registers custom fonts before any CatUI preview renders.
/// Apply as a trait: `#Preview(traits: .catUIFonts, .sizeThatFitsLayout) { ... }`
///
/// No need to wrap content in CatUIPreview { } — just add the trait.
struct CatUIPreviewModifier: PreviewModifier {

    // MARK: - Context

    typealias Context = Void

    // MARK: - Functions

    static func makeSharedContext() async throws {
        CatFontRegistration.registerAll()
    }

    func body(content: Content, context: Context) -> some View {
        content
    }
}

// MARK: - PreviewTrait Extension

extension PreviewTrait where T == Preview.ViewTraits {

    /// Registers CatUI custom fonts (Coolvetica) before the preview renders.
    @MainActor
    static var catUIFonts: Self {
        .modifier(CatUIPreviewModifier())
    }
}
