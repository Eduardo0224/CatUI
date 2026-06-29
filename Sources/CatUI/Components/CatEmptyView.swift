import SwiftUI

// MARK: - CatEmptyView

/// Empty state with icon, title, subtitle, and optional action button.
public struct CatEmptyView: View {

    // MARK: - Properties

    let icon: String
    let title: String
    var subtitle: String?
    var actionTitle: String?
    var action: (() -> Void)?

    // MARK: - Body

    public var body: some View {
        VStack(spacing: CatSpacing.spacing16) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.tertiary)

            VStack(spacing: CatSpacing.spacing8) {
                Text(title)
                    .font(.catHeadline)
                    .foregroundStyle(Color.catTextPrimary)

                if let subtitle {
                    Text(subtitle)
                        .font(.catBody)
                        .foregroundStyle(Color.catTextSecondary)
                        .multilineTextAlignment(.center)
                }
            }

            if let action, let actionTitle {
                CatButton(actionTitle, variant: .secondary, action: action)
            }
        }
        .padding(CatSpacing.spacing24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    // MARK: - Initializers

    public init(
        icon: String = "tray",
        title: String,
        subtitle: String? = nil,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.actionTitle = actionTitle
        self.action = action
    }
}

// MARK: - Previews

#Preview("Empty State", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatEmptyView(
        icon: "cat",
        title: "No cats found",
        subtitle: "Try adjusting your search",
        actionTitle: "Retry",
        action: { }
    )
}

#Preview("Empty State Dark", traits: .catUIFonts, .sizeThatFitsLayout) {
    CatEmptyView(
        icon: "cat",
        title: "No cats found",
        subtitle: "Try adjusting your search",
        actionTitle: "Retry",
        action: { }
    )
    .background(Color.catSurfacePrimary)
    .preferredColorScheme(.dark)
}
