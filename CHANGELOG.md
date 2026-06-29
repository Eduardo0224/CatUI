# Changelog

All notable changes to CatUI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `ImageCacheService` — actor-based image caching with memory + disk persistence (SHA-256 hashed filenames)
- `ImageCacheServiceProtocol` — public protocol for cache dependency injection and testability
- `CatImageView` now uses `ImageCacheService.shared` internally instead of `AsyncImage` (no cache)
- `CatImageView(maxWidth:)` — new optional parameter to control cached image width in points
- Public `ImageCacheService.shared` singleton — consumers can call cache directly
- `GITFLOW.md` — Git workflow and branching strategy for CatUI

### Fixed

- Access control: `Color.cat*`, `Font.cat*`, `UIColor.cat*` tokens were `internal` — now `public`
- Access control: `CatCardModifier` struct + body + properties were `internal` — now `public`
- Access control: `CatUIPreviewModifier` methods + `.catUIFonts` trait were `internal` — now `public`

---

## [0.3.0] - 2026-06-29

### Added

- `CatSkeletonModifier` + `.catSkeleton()` modifier — combines `.redacted(.placeholder)` + `.shimmer()` + `.disabled(true)`
- `CatFloatingButton` component — circular floating action button (like/dislike/share variants)
- `CatVoteCellConfiguration` — UIKit `UIContentConfiguration` for vote history cells
- `CatUIColor+Tokens` — UIKit color bridge with light/dark mode support
- `CatFontRegistration` — Coolvetica font registration helper
- `CatUIPreview` — reusable `#Preview` trait for CatUI fonts
- `.preferredColorScheme(.dark)` previews for all components and modifiers
- `@Environment(\.accessibilityReduceMotion)` support in `ShimmerModifier`
- Documentation comments with ScrollView/List usage warning in `ShimmerModifier` and `CatSkeletonModifier`

### Changed

- `ShimmerModifier` — made `public` struct with `public init()` for direct usage
- `ShimmerModifier` — added `.mask(content)` to respect rounded corners, text glyphs, and other non-rectangular shapes
- `ShimmerModifier` — aligned animation with InkuUI (phase: -1→1.5, duration: 1.2s, opacity: 0.35)
- `CatImageView` — added `.empty` placeholder preview
- `CatLoadingView` — dark mode preview

### Fixed

- Shimmer overlay no longer renders as a full rectangle (properly masked to content shape)
- Shimmer animation respects Reduce Motion accessibility setting

---

## [0.1.0] - 2026-06-28

### Added

- Initial SPM package structure (iOS 26+, Swift 6)
- Design tokens: CatColors, CatSpacing, CatRadius, CatTypography
- Components: CatCardView, CatBadgeView, CatButtonStyle, CatButton, CatImageView
- Components: CatLoadingView, CatEmptyView, CatErrorView
- Modifiers: `.catCardStyle()`, `.shimmer()`
- Warm orange accent color palette (#FF8C42)
- Swift Testing test target

---

## Version Guidelines

### Semantic Versioning

- **0.x.x**: Pre-release
- **1.0.0**: First stable release
- **Major**: Breaking API changes
- **Minor**: New components, backward compatible
- **Patch**: Bug fixes

### Change Categories

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Removed**: Removed features
- **Fixed**: Bug fixes
