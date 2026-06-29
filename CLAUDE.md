# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Quick Reference

- **Project**: CatUI — Design System for CatMatch
- **Type**: Swift Package (SPM)
- **Language**: Swift 6
- **Platform**: iOS 26+
- **UI Framework**: SwiftUI (primary) + UIKit (auxiliary)
- **Testing**: Swift Testing framework

## Package Structure

```
CatUI/
├── Package.swift
├── Sources/CatUI/
│   ├── Tokens/
│   │   ├── CatColors.swift            ← Color tokens (.catAccent, .catSurface, etc.)
│   │   ├── CatSpacing.swift           ← Spacing scale (4–32pt)
│   │   ├── CatRadius.swift            ← Corner radius scale (8–16pt)
│   │   ├── CatTypography.swift        ← Font tokens (.catTitle, .catBody, etc.)
│   │   ├── CatFontRegistration.swift  ← Coolvetica font registration
│   │   └── CatUIColor+Tokens.swift    ← UIKit color bridge (light/dark)
│   ├── Components/
│   │   ├── CatCardView.swift          ← Card container (built-in styling)
│   │   ├── CatBadgeView.swift         ← Small badge (filled/accent/outlined)
│   │   ├── CatButtonStyle.swift       ← ButtonStyle + CatButton convenience
│   │   ├── CatFloatingButton.swift    ← Circular floating action button
│   │   ├── CatImageView.swift         ← Async image with placeholder/shimmer
│   │   ├── CatLoadingView.swift       ← Loading indicator
│   │   ├── CatEmptyView.swift         ← Empty state
│   │   ├── CatErrorView.swift         ← Error state
│   │   ├── CatVoteCellConfiguration.swift ← UIKit cell configuration
│   │   └── CatUIPreview.swift         ← Preview traits
│   └── Modifiers/
│       ├── View+CatCard.swift         ← .catCardStyle() modifier
│       ├── View+CatShimmer.swift      ← .shimmer() modifier
│       └── View+CatSkeleton.swift     ← .catSkeleton() modifier
└── Tests/CatUITests/
```

## Golden Rules

1. ✅ Zero business logic — visual elements only
2. ✅ iOS 26+ — no `#available` guards, no fallbacks
3. ✅ One component per file
4. ✅ Every component has `#Preview` light + dark variants
5. ✅ Use design tokens (CatSpacing, CatRadius, CatColors) — never hardcode values
6. ✅ Components are stateless by default (data via `let`, actions via closures)
7. ✅ `public` access on all components, tokens, and modifiers
8. ✅ Swift Testing for tests
9. ✅ Shimmer/skeleton modifiers include ScrollView usage warning in documentation
10. ✅ Respect `@Environment(\.accessibilityReduceMotion)` in animated modifiers

## Key Patterns

### Shimmer & Skeleton

- `.shimmer()` — Apply ONLY to individual static shapes, NEVER to ScrollView/List
- `.catSkeleton()` — Combines `.redacted(.placeholder)` + `.shimmer()` + `.disabled(true)`
- When Reduce Motion is enabled, shimmer stays static (still functional as loading indicator)
- See documentation comments in `View+CatShimmer.swift` for correct/incorrect usage

### UIKit Integration

- `CatVoteCellConfiguration` implements `UIContentConfiguration` for use with `UICollectionView`
- `CatUIColor+Tokens` provides UIKit `UIColor` equivalents with light/dark support
- Keep UIKit code behind `#if canImport(UIKit)` guards when possible

## Integration

This package is consumed by CatMatch as an SPM dependency:

```
https://github.com/Eduardo0224/CatUI
```

## Publishing

1. Develop on feature branches from `develop`
2. PR into `develop` for integration
3. PR from `develop` into `main` for releases
4. Tag releases with semantic versioning: `v0.1.0`, `v0.2.0`, `v0.3.0`, etc.
