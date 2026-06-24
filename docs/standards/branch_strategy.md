# Branch Strategy

AIONE uses a Git Flow–inspired model with protected long-lived branches and short-lived topic branches.

## Branches

| Branch       | Purpose                                      | Base Branch | Merge Target     |
| ------------ | -------------------------------------------- | ----------- | ---------------- |
| `main`       | Production-ready releases                    | —           | —                |
| `develop`    | Integration branch for ongoing work          | `main`      | `main` (releases)|
| `feature/*`  | New features and non-urgent enhancements     | `develop`   | `develop`        |
| `release/*`  | Release stabilization and version prep         | `develop`   | `main` + `develop`|
| `hotfix/*`   | Urgent production fixes                      | `main`      | `main` + `develop`|

## Naming Conventions

```
feature/<issue-id>-short-description
release/v0.2.0
hotfix/<issue-id>-short-description
```

Examples:

- `feature/42-user-authentication`
- `release/v0.2.0`
- `hotfix/108-fix-session-timeout`

Use lowercase, hyphens as separators, and include the issue ID when available.

## Workflow

### Features

```bash
git checkout develop
git pull origin develop
git checkout -b feature/42-user-authentication
# ... commits ...
git push -u origin feature/42-user-authentication
# Open PR → develop
```

### Releases

```bash
git checkout develop
git checkout -b release/v0.2.0
# Version bumps, changelog, final fixes only
# Open PR → main; merge back to develop after release
```

### Hotfixes

```bash
git checkout main
git pull origin main
git checkout -b hotfix/108-fix-session-timeout
# ... fix ...
# Open PR → main; cherry-pick or merge back to develop
```

## Protection Rules

Apply on the hosting platform (recommended):

| Branch    | Direct Push | Required Reviews | CI Required |
| --------- | ----------- | ---------------- | ----------- |
| `main`    | No          | ≥ 2              | Yes         |
| `develop` | No          | ≥ 1              | Yes         |

Topic branches (`feature/*`, `hotfix/*`, `release/*`) may be force-pushed by the author before review.

## Merge Strategy

- **Pull requests only** — no direct commits to `main` or `develop`.
- **Squash merge** for `feature/*` → `develop` (clean history, one commit per feature).
- **Merge commit** for `release/*` → `main` and `hotfix/*` → `main` (preserve release context).

## Deletion Policy

Delete topic branches after merge. Long-lived branches (`main`, `develop`) are never deleted.
