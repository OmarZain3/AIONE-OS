# Versioning

AIONE follows [Semantic Versioning 2.0.0](https://semver.org/).

## Format

```text
MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]
```

| Segment | Increment When |
| ------------ | --------------------------------------------------- |
| `MAJOR` | Incompatible API or contract changes |
| `MINOR` | Backward-compatible new functionality |
| `PATCH` | Backward-compatible bug fixes |
| `PRERELEASE` | Pre-release identifier (alpha, beta, rc) |
| `BUILD` | Build metadata (optional, does not affect precedence) |

## Current Version

**`v0.1.0-alpha`** — Initial foundation release (pre-1.0).

While `MAJOR` is `0`, the public API is considered unstable. Breaking changes
may occur in `MINOR` releases until `v1.0.0`.

## Pre-release Identifiers

| Identifier | Meaning |
| ---------- | ------------------------------------ |
| `alpha` | Early internal or limited testing |
| `beta` | Feature-complete, wider testing |
| `rc` | Release candidate, production-ready |

Example progression: `v0.1.0-alpha` → `v0.1.0-beta` → `v0.1.0-rc.1` → `v0.1.0`

## Tagging

Git tags use a `v` prefix:

```bash
git tag -a v0.1.0-alpha -m "v0.1.0-alpha: initial foundation release"
git push origin v0.1.0-alpha
```

Tags are created from `main` (or `release/*` branches) only.

## Changelog

All version changes are recorded in [CHANGELOG.md](../../CHANGELOG.md) following
[Keep a Changelog](https://keepachangelog.com/).

### Release Checklist

1. Update version references in affected components.
2. Move `[Unreleased]` entries to a new version section in `CHANGELOG.md`.
3. Create `release/vX.Y.Z` branch from `develop`.
4. Merge to `main`, tag, then merge back to `develop`.

## Compatibility

| Version Range | Support Status |
| ------------- | -------------- |
| Latest `0.1.x` | Active |
| `< 0.1.0` | Unsupported |

Support policy details are in [SECURITY.md](../../SECURITY.md).
