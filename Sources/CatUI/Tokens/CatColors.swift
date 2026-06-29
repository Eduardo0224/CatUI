import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - CatUI Color Tokens
//
// Palette inspired by: https://dribbble.com/shots/25955678-Pet-Marketplace-App-Mobile-Design
//   #191617  Dark charcoal
//   #E22E57  Rose red (accent)
//   #FFCEDE  Light pink (accent subtle)
//   #FFFFFF  White

public extension Color {

    // MARK: - Accent

    /// Rose red — #E22E57 (same in light & dark)
    static let catAccent = Color(red: 0.886, green: 0.180, blue: 0.341)

    /// Light pink in light mode, dark muted rose in dark mode
    static let catAccentSubtle = Color(
        light: Color(red: 1.0, green: 0.808, blue: 0.871),    // #FFCEDE
        dark: Color(red: 0.239, green: 0.125, blue: 0.169)     // #3D202B
    )

    // MARK: - Surface

    /// Main background — white / dark charcoal
    static let catSurfacePrimary = Color(
        light: Color(red: 1.0, green: 1.0, blue: 1.0),         // #FFFFFF
        dark: Color(red: 0.098, green: 0.086, blue: 0.090)     // #191617
    )

    /// Cards, elevated surfaces — warm tint / slightly lighter charcoal
    static let catSurfaceSecondary = Color(
        light: Color(red: 1.0, green: 0.957, blue: 0.941),     // #FFF5F0
        dark: Color(red: 0.165, green: 0.141, blue: 0.149)     // #2A2426
    )

    // MARK: - Text

    /// Primary text — dark charcoal / white
    static let catTextPrimary = Color(
        light: Color(red: 0.098, green: 0.086, blue: 0.090),   // #191617
        dark: Color(red: 1.0, green: 1.0, blue: 1.0)           // #FFFFFF
    )

    /// Secondary text — muted dark / muted light
    static let catTextSecondary = Color(
        light: Color(red: 0.420, green: 0.357, blue: 0.369),   // #6B5B5E
        dark: Color(red: 0.690, green: 0.627, blue: 0.647)     // #B0A0A5
    )

    /// Text displayed over the accent color — always white
    static let catTextOnAccent = Color.white

    // MARK: - Destructive

    /// Destructive actions — delete, remove (light: #D32F2F, dark: #EF5350)
    static let catDestructive = Color(
        light: Color(red: 0.827, green: 0.184, blue: 0.184),    // #D32F2F
        dark: Color(red: 0.937, green: 0.325, blue: 0.314)       // #EF5350
    )

    // MARK: - Separator

    /// Borders, dividers (black 10% / white 15%)
    static let catSeparator = Color(
        light: Color.black.opacity(0.10),
        dark: Color.white.opacity(0.15)
    )
}

// MARK: - Color Scheme Helper

#if canImport(UIKit)
private extension Color {
    init(light: Color, dark: Color) {
        self.init(uiColor: UIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}
#endif
