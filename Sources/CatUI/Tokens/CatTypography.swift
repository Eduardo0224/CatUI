import SwiftUI

// MARK: - CatUI Typography Tokens
//
// Uses Coolvetica custom font with Dynamic Type support.
// PostScript names: Coolvetica-Regular, Coolvetica-Italic, Coolvetica-HeavyComp
//
// Apple HIG size scale (in points at default Dynamic Type):
//   Large Title: 34pt  |  Title 1: 28pt  |  Title 2: 22pt  |  Title 3: 20pt
//   Headline: 17pt     |  Body: 17pt      |  Callout: 16pt   |  Subhead: 15pt
//   Footnote: 13pt     |  Caption 1: 12pt |  Caption 2: 11pt

public extension Font {

    // MARK: - Display & Titles (Heavy Comp weight)

    /// Large Title — 34pt, Heavy Comp, scales with Dynamic Type
    static let catDisplay = Font.custom("Coolvetica-HeavyComp", size: 34, relativeTo: .largeTitle)

    /// Title 1 — 28pt, Heavy Comp
    static let catTitle = Font.custom("Coolvetica-HeavyComp", size: 28, relativeTo: .title)

    /// Title 2 — 22pt, Heavy Comp
    static let catTitle2 = Font.custom("Coolvetica-HeavyComp", size: 22, relativeTo: .title2)

    /// Title 3 — 20pt, Heavy Comp
    static let catTitle3 = Font.custom("Coolvetica-HeavyComp", size: 20, relativeTo: .title3)

    // MARK: - Headline & Body (Regular weight)

    /// Headline — 17pt, Regular weight, semibold via weight modifier
    static let catHeadline = Font.custom("Coolvetica-Regular", size: 17, relativeTo: .headline)

    /// Body — 17pt, Regular
    static let catBody = Font.custom("Coolvetica-Regular", size: 17, relativeTo: .body)

    /// Callout — 16pt, Regular
    static let catCallout = Font.custom("Coolvetica-Regular", size: 16, relativeTo: .callout)

    /// Subhead — 15pt, Regular
    static let catSubhead = Font.custom("Coolvetica-Regular", size: 15, relativeTo: .subheadline)

    /// Footnote — 13pt, Regular
    static let catFootnote = Font.custom("Coolvetica-Regular", size: 13, relativeTo: .footnote)

    // MARK: - Captions (Regular weight)

    /// Caption 1 — 12pt, Regular
    static let catCaption = Font.custom("Coolvetica-Regular", size: 12, relativeTo: .caption)

    /// Caption 2 — 11pt, Regular
    static let catCaption2 = Font.custom("Coolvetica-Regular", size: 11, relativeTo: .caption2)

    // MARK: - Italic variants

    /// Body Italic
    static let catBodyItalic = Font.custom("Coolvetica-Italic", size: 17, relativeTo: .body)

    /// Caption Italic
    static let catCaptionItalic = Font.custom("Coolvetica-Italic", size: 12, relativeTo: .caption)
}
