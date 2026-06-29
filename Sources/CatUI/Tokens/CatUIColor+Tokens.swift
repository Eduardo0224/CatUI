import UIKit

// MARK: - CatUI UIColor Tokens
//
// UIKit counterpart to Color.cat* tokens. Same palette, same values.
// Use in UIView/UIViewController code. For SwiftUI use Color.cat*.

public extension UIColor {

    // MARK: - Accent

    /// Rose red — #E22E57
    static let catAccent = UIColor(red: 0.886, green: 0.180, blue: 0.341, alpha: 1.0)

    /// Light pink / dark muted rose
    static let catAccentSubtle = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.239, green: 0.125, blue: 0.169, alpha: 1.0)   // #3D202B
            : UIColor(red: 1.0, green: 0.808, blue: 0.871, alpha: 1.0)      // #FFCEDE
    }

    // MARK: - Surface

    /// Main background — white / dark charcoal
    static let catSurfacePrimary = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.098, green: 0.086, blue: 0.090, alpha: 1.0)   // #191617
            : UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)          // #FFFFFF
    }

    /// Cards, elevated surfaces — warm tint / lighter charcoal
    static let catSurfaceSecondary = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.165, green: 0.141, blue: 0.149, alpha: 1.0)   // #2A2426
            : UIColor(red: 1.0, green: 0.957, blue: 0.941, alpha: 1.0)      // #FFF5F0
    }

    // MARK: - Text

    /// Primary text — dark charcoal / white
    static let catTextPrimary = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)          // #FFFFFF
            : UIColor(red: 0.098, green: 0.086, blue: 0.090, alpha: 1.0)    // #191617
    }

    /// Secondary text — muted dark / muted light
    static let catTextSecondary = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.690, green: 0.627, blue: 0.647, alpha: 1.0)   // #B0A0A5
            : UIColor(red: 0.420, green: 0.357, blue: 0.369, alpha: 1.0)    // #6B5B5E
    }

    /// Text over accent — always white
    static let catTextOnAccent = UIColor.white

    // MARK: - Destructive

    /// Destructive actions — delete, remove
    static let catDestructive = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor(red: 0.937, green: 0.325, blue: 0.314, alpha: 1.0)   // #EF5350
            : UIColor(red: 0.827, green: 0.184, blue: 0.184, alpha: 1.0)    // #D32F2F
    }

    // MARK: - Separator

    /// Borders, dividers — black 10% / white 15%
    static let catSeparator = UIColor { trait in
        trait.userInterfaceStyle == .dark
            ? UIColor.white.withAlphaComponent(0.15)
            : UIColor.black.withAlphaComponent(0.10)
    }
}
