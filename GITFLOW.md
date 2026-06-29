# Git Workflow Strategy

This document defines the Git workflow and branching strategy for the CatUI project.

## Overview

We follow a **simplified Gitflow** workflow optimized for a single developer with clear feature separation and professional commit history.

## Branch Structure

```
main (production-ready)
  ↑
develop (integration)
  ↑
feature/* (individual features)
```

### Branch Types

| Branch | Purpose | Lifetime | Protected |
|--------|---------|----------|-----------|
| `main` | Production-ready code, tagged releases | Permanent | ✅ Yes |
| `develop` | Integration branch for features | Permanent | ⚠️ Semi |
| `feature/*` | Individual feature development | Temporary | ❌ No |
| `release/*` | Release preparation (optional) | Temporary | ❌ No |
| `hotfix/*` | Emergency fixes for production | Temporary | ❌ No |

---

## Branch Naming Conventions

### Feature Branches
```
feature/<feature-name>
```

**Examples**:
- `feature/image-cache`
- `feature/new-component`
- `feature/accessibility`
- `feature/design-tokens`

### Release Branches (optional)
```
release/v<version>
```

**Examples**:
- `release/v0.1.0`
- `release/v0.2.0`

### Hotfix Branches
```
hotfix/<issue-description>
```

**Examples**:
- `hotfix/fix-shimmer-crash`
- `hotfix/image-loading-memory-leak`

---

## Commit Message Format

All commits MUST follow this format (configured in `.gitmessage`):

```
[type](scope): emoji title_in_english

Detailed description of changes:
- What changed
- Why it changed
- Any breaking changes or important notes
```

### Commit Types

| Type | Usage | Emoji |
|------|-------|-------|
| `feat` | New feature | ✨ |
| `fix` | Bug fix | 🐛 |
| `docs` | Documentation changes | 📚 |
| `style` | Code style changes (formatting) | 🎨 |
| `refactor` | Code refactoring | ♻️ |
| `test` | Adding or updating tests | ✅ |
| `chore` | Build process, tools, config | 🔧 |
| `perf` | Performance improvements | ⚡️ |

### Commit Scopes

| Scope | Usage |
|-------|-------|
| `CatUI` | CatUI design system (general) |
| `Tokens` | Design tokens (colors, spacing, typography, radius) |
| `Components` | UI components (CatCardView, CatBadgeView, CatImageView, etc.) |
| `Modifiers` | View modifiers (shimmer, skeleton, card style) |
| `Services` | Internal services (image cache, etc.) |
| `Config` | Project configuration |

### Commit Examples

```bash
# Good commits
[feat](Components): ✨ Add CatImageView with image caching

Implemented CatImageView that uses ImageCacheService for memory and disk
caching of downloaded images.

- Added ImageCacheService actor with memory + disk persistence
- Added ImageCacheServiceProtocol for dependency injection
- CatImageView uses cache service via .task(id: url) for automatic reload

[fix](Modifiers): 🐛 Fix shimmer animation not respecting Reduce Motion

Shimmer now checks @Environment(\.accessibilityReduceMotion) before animating.

[refactor](Tokens): ♻️ Extract spacing values to CatSpacing enum

Created CatSpacing enum to centralize all spacing values used across components.

[test](Services): ✅ Add tests for ImageCacheService

Added comprehensive test suite for:
- Memory cache eviction
- Disk persistence
- Failed URL tracking
- Concurrent access safety
```

---

## Development Workflow

### 1. Initial Setup (One-time)

```bash
# Create and push develop branch
git checkout -b develop
git push -u origin develop

# Set develop as default branch on GitHub (optional)
```

### 2. Starting a New Feature

```bash
# Ensure develop is up to date
git checkout develop
git pull origin develop

# Create feature branch from develop
git checkout -b feature/image-cache

# Push feature branch to remote
git push -u origin feature/image-cache
```

### 3. Working on a Feature

```bash
# Make changes and commit frequently
git add .
git commit -m "[feat](Services): ✨ Add image caching service

Created ImageCacheService with memory and disk persistence.
Actor-based design ensures thread-safe concurrent access.
"

# Push to remote regularly
git push origin feature/image-cache
```

### 4. Completing a Feature

```bash
# Ensure all tests pass
swift test

# Ensure feature branch is up to date with develop
git checkout develop
git pull origin develop
git checkout feature/image-cache
git merge develop

# Resolve any conflicts, test again

# Merge feature into develop (using --no-ff to preserve history)
git checkout develop
git merge --no-ff feature/image-cache

# Push develop
git push origin develop

# Delete feature branch (local and remote)
git branch -d feature/image-cache
git push origin --delete feature/image-cache
```

### 5. Creating a Release

```bash
# Create release branch from develop
git checkout develop
git pull origin develop
git checkout -b release/v0.4.0

# Bump version, update CHANGELOG.md, final testing
# Make any last-minute fixes

# Merge to main
git checkout main
git merge --no-ff release/v0.4.0

# Tag the release
git tag -a v0.4.0 -m "Release version 0.4.0 — Image caching

Features:
- ImageCacheService with memory + disk caching
- CatImageView now uses cache automatically
- Public API for direct cache access
"

# Push main and tags
git push origin main
git push origin v0.4.0

# Merge back to develop
git checkout develop
git merge --no-ff release/v0.4.0
git push origin develop

# Delete release branch
git branch -d release/v0.4.0
```

### 6. Creating a Hotfix

```bash
# Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/fix-shimmer-crash

# Fix the issue
git commit -m "[fix](Modifiers): 🐛 Fix shimmer animation crash

Fixed crash when shimmer modifier was applied to a ScrollView.
Added documentation warning and guard.
"

# Merge to main
git checkout main
git merge --no-ff hotfix/fix-shimmer-crash

# Tag with patch version
git tag -a v0.3.1 -m "Hotfix v0.3.1 — Fix shimmer crash"
git push origin main
git push origin v0.3.1

# Merge back to develop
git checkout develop
git merge --no-ff hotfix/fix-shimmer-crash
git push origin develop

# Delete hotfix branch
git branch -d hotfix/fix-shimmer-crash
```

---

## Versioning Strategy

We follow **Semantic Versioning** (semver): `MAJOR.MINOR.PATCH`

### Version Numbers

- **0.x.x**: Development phase (pre-release)
- **1.0.0**: First stable release
- **MAJOR**: Breaking changes, major API redesign
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, minor improvements

### Version History

```
0.1.0 → Initial tokens and basic components
0.2.0 → CatCardView, CatBadgeView, CatButtonStyle
0.3.0 → Shimmer/skeleton modifiers, public access control
0.4.0 → ImageCacheService, CatImageView caching
0.5.0 → (future) Additional components
1.0.0 → Stable release 🎉
```

---

## Git Tags

### Annotated Tags (Preferred)

```bash
# Create annotated tag
git tag -a v0.4.0 -m "Release v0.4.0 — Image caching

Major Features:
- ImageCacheService with memory + disk persistence
- CatImageView integrated with cache
- Public API for direct cache control
"

# Push tag
git push origin v0.4.0

# Push all tags
git push origin --tags
```

### Listing Tags

```bash
# List all tags
git tag

# Show tag details
git show v0.4.0
```

### Deleting Tags

```bash
# Delete local tag
git tag -d v0.4.0

# Delete remote tag
git push origin --delete v0.4.0
```

---

## Branch Protection Rules (GitHub)

### For `main` branch:
- ✅ Require pull request reviews before merging
- ✅ Require status checks to pass (tests)
- ✅ Require branches to be up to date
- ✅ Require conversation resolution before merging
- ✅ Do not allow force pushes
- ✅ Do not allow deletions

### For `develop` branch:
- ⚠️ Require pull request reviews (optional for solo dev)
- ✅ Require status checks to pass (tests)
- ⚠️ Allow force pushes (only by admins)
- ✅ Do not allow deletions

---

## Best Practices

### ✅ DO

- Commit frequently with clear messages
- Keep commits focused (one logical change per commit)
- Write descriptive commit messages
- Test before pushing
- Use feature branches for all features
- Delete branches after merging
- Tag all releases
- Keep `main` always deployable
- Update CHANGELOG.md with each release
- Use `--no-ff` for merges to preserve history
- Use design tokens instead of hardcoded values
- Every component must have `#Preview` light + dark variants
- Components must be `public` and stateless

### ❌ DON'T

- Don't commit directly to `main`
- Don't force push to `main` (except for initial setup if needed)
- Don't commit broken code to `develop`
- Don't leave stale branches
- Don't use generic commit messages ("fix", "update", "changes")
- Don't commit secrets or sensitive data
- Don't commit large binary files
- Don't hardcode design values (use CatSpacing, CatRadius, CatColors)
- Don't add business logic to CatUI components

---

## Quick Reference

```bash
# Setup
git checkout -b develop
git push -u origin develop

# Start feature
git checkout develop
git pull origin develop
git checkout -b feature/my-feature

# Work on feature
git add .
git commit -m "[feat](Scope): ✨ Description"
git push origin feature/my-feature

# Finish feature
git checkout develop
git merge --no-ff feature/my-feature
git push origin develop
git branch -d feature/my-feature
git push origin --delete feature/my-feature

# Release
git checkout -b release/v1.0.0
# ... final changes ...
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin main --tags
git checkout develop
git merge --no-ff release/v1.0.0
git push origin develop
```

---

## Current Status

- ✅ `main` branch created and pushed
- ✅ `develop` branch created and pushed
- ✅ Commit template configured
- ✅ v0.1.0 — Initial tokens and basic components
- ✅ v0.2.0 — CatCardView, CatBadgeView, CatButtonStyle
- ✅ v0.3.0 — Shimmer/skeleton modifiers, public access control
- 🔄 Current: `feature/image-cache` — ImageCacheService + CatImageView caching
