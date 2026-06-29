# CatUI

Design system for CatMatch — reusable SwiftUI components, modifiers, and design tokens.

## Overview

CatUI provides the visual foundation for the CatMatch iOS app. It includes:

- **Design Tokens**: Colors, spacing, corner radius, and typography (Coolvetica font) with light/dark mode support
- **Components**: Cards, badges, buttons, image loaders, loading/empty/error states
- **Modifiers**: Shimmer animation, skeleton loading, card styling
- **UIKit Bridge**: Color tokens and cell configurations for UIKit interop

## Installation

Add CatUI as a Swift Package Manager dependency:

```
https://github.com/Eduardo0224/CatUI
```

Minimum deployment target: iOS 26.

## Quick Start

```swift
import CatUI
import SwiftUI

struct MyView: View {
    var body: some View {
        CatCardView {
            VStack(alignment: .leading, spacing: CatSpacing.spacing8) {
                Text("Bengal").font(.catTitle)
                Text("Active, Energetic, Playful")
                    .font(.catBody)
                    .foregroundStyle(Color.catTextSecondary)
            }
        }
    }
}
```

## Components

| Component | Usage |
|-----------|-------|
| `CatCardView` | Card container with shadow and radius |
| `CatBadgeView` | Small badge (filled, accent, outlined) |
| `CatButton` / `CatButtonStyle` | Styled buttons (primary, secondary, ghost) |
| `CatFloatingButton` | Circular floating action (like, dislike, share) |
| `CatImageView` | Async image with shimmer placeholder |
| `CatLoadingView` | Loading indicator with message |
| `CatEmptyView` | Empty state with icon, text, action |
| `CatErrorView` | Error state with retry action |

## Modifiers

| Modifier | Usage |
|----------|-------|
| `.catCardStyle()` | Apply card styling to any view |
| `.shimmer()` | Shimmer loading animation |
| `.catSkeleton(_:)` | Redacted placeholder + shimmer + disabled |

## Design Tokens

```swift
// Colors (light/dark adaptive)
Color.catAccent          // #E22E57 rose red
Color.catSurfacePrimary  // White / dark charcoal
Color.catSurfaceSecondary // Warm tint / lighter charcoal
Color.catTextPrimary     // Dark charcoal / white
Color.catTextSecondary   // Muted dark / muted light

// Spacing
CatSpacing.spacing4 ... CatSpacing.spacing32

// Radius
CatRadius.radius8 ... CatRadius.radius16

// Typography (Coolvetica)
Font.catDisplay ... Font.catCaption2
```

## Accessibility

- All components support Dynamic Type via relative font sizing
- `ShimmerModifier` and `CatSkeletonModifier` respect Reduce Motion
- Dark mode supported across all components

## License

MIT License. See [LICENSE](LICENSE) for details.
