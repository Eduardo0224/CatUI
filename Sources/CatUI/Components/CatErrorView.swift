import SwiftUI

// MARK: - CatErrorView

/// Error state built on CatEmptyView with error icon and retry action.
public struct CatErrorView: View {

    // MARK: - Properties

    let message: String
    var retryAction: (() -> Void)?

    // MARK: - Body

    public var body: some View {
        CatEmptyView(
            icon: "exclamationmark.triangle",
            title: message,
            actionTitle: retryAction != nil ? "Retry" : nil,
            action: retryAction
        )
    }

    // MARK: - Initializers

    public init(message: String, retryAction: (() -> Void)? = nil) {
        self.message = message
        self.retryAction = retryAction
    }
}

// MARK: - Previews

#Preview("Error", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatErrorView(message: "Something went wrong") { }
}

#Preview("Error Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatErrorView(message: "Something went wrong") { }
        .background(Color.catSurfacePrimary)
        .preferredColorScheme(.dark)
}
