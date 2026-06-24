# Security Policy

## Supported Versions

| Version   | Supported |
| --------- | --------- |
| `0.1.x`   | Yes       |
| `< 0.1.0` | No        |

See [CHANGELOG.md](CHANGELOG.md) and [docs/standards/versioning.md](docs/standards/versioning.md) for release history.

## Reporting a Vulnerability

**Do not report security vulnerabilities through public GitHub issues.**

Send reports to: **security@aione.example** <!-- TODO: Replace with production security contact -->

Include:

- Description of the vulnerability and potential impact
- Steps to reproduce
- Affected component(s) and version/commit
- Proof of concept (if available)
- Suggested remediation (optional)

### Response Timeline

| Stage              | Target        |
| ------------------ | ------------- |
| Acknowledgment     | 2 business days |
| Initial assessment | 5 business days |
| Remediation plan   | 10 business days |

Timelines may vary based on severity and complexity.

## Disclosure Policy

- Reports are handled confidentially until a fix is available.
- Coordinated disclosure is preferred; we will agree on a publication date with the reporter.
- Credit will be given to reporters unless anonymity is requested.

## Secure Development

- Never commit secrets, API keys, or credentials.
- Use `.env` locally; store production secrets in a secrets manager.
- Follow the [code review checklist](docs/standards/code_review_checklist.md) for security-related items.

## Scope

In scope: code, configuration, and infrastructure maintained in this repository.

Out of scope: third-party services, social engineering, and issues in unsupported versions.
