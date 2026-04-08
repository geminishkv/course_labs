# Project Security Policy

## Introduction

This security policy describes how we handle security concerns in this project, and how users and contributors can report potential vulnerabilities. We strive to ensure transparency and accountability in security matters to protect our users and the project.

## Reporting a Vulnerability

If you discover a vulnerability or security issue:

1. Please do not disclose it publicly to prevent potential misuse.
2. Report it directly via email to: shmakovis@inbox.ru
3. Provide a detailed description of the vulnerability, including:
   - Steps to reproduce
   - The project version where the issue was found
   - Your contact information for follow-up

We commit to responding within 48 hours to acknowledge receipt of your message.

## Vulnerability Handling Process

1. Receiving and acknowledging the vulnerability report.
2. Analyzing and assessing the risk.
3. Developing a patch with subsequent testing.
4. Releasing a security update.
5. Notifying the public and users after the update is released.
6. Maintaining a log of vulnerabilities and fixes (if applicable).

## Supported Versions

- The current main branch `develop` is supported.
- It is recommended to upgrade to supported versions for security.

## Recommendations for Users

- Always use the latest stable versions of the project.
- Subscribe to security updates in the repository or use automatic update features.
- Report any suspicious activities or security concerns.

## Disclosure Policy

- We strive for open dialogue and timely disclosure.
- Information about critical vulnerabilities will be published after a successful patch release.
- We welcome collaboration with security researchers and the community.

## Branch Protection

The `develop` branch is protected with the following rules:

- **Required reviews:** At least 1 approval from @geminishkv
- **Required status checks:** All CI jobs must pass before merge
- **No force-push:** History rewriting is prohibited
- **CODEOWNERS:** Changes to `.github/workflows/`, `mkdocs.yml`, `hooks.py`, `requirements.txt` require owner approval

## CI/CD Security

- All GitHub Actions are pinned by SHA commit hash (not tags)
- Dependabot monitors actions and pip dependencies weekly
- Gitleaks scans for secrets on every push and PR
- Bandit scans Python code for security issues
- Hadolint validates Dockerfiles

## Additional Information

- Documenting and maintaining security logs.
- Using automated tools for vulnerability scanning.
- Regular security audits and reviews.

---

If you have any questions or suggestions regarding the project’s security, please contact us using the details above.

---

Thank you for contributing to the security of our project!
