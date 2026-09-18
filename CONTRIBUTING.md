# Contributing

Thank you for your interest in contributing to our project! Your contributions—whether fixing bugs, adding new features, improving documentation, or sharing ideas—are highly appreciated.

## Getting Started

1. Familiarize yourself with the project documentation to understand its structure and guidelines.
2. Check existing issues to see if someone else is already working on a similar task.
3. Fork the repository and create a separate branch for your changes.

## Creating a Pull Request

- Write clear and informative commit messages.
- Follow the established coding style guidelines.
- When adding new features, update or add documentation accordingly.
- Before submitting the pull request, ensure all tests pass successfully.

## Course Content Rules

- **Vulnerable lab assets stay vulnerable.** Files such as `labs/basic/lab07/vulnerable-app/`, `labs/basic/lab07/sca/pom.xml` and `labs/basic/lab08/vulnerable-app/` are the targets students scan and fix. Solutions belong in your own lab repository and gist report, never in a pull request to this template: a merged fix leaves the next cohort nothing to find. Before changing such a file, run the lab's scanners and confirm the reference findings are still reported.
- **Text is Russian with the letter ё** (отчёт, ещё, её, защищённый).
- **Names stay uniform** across the menu, page titles and text: `Лаб. 01`–`Лаб. 10` for labs, `Тест №1` for tests, `pet-project` (`Pet-project` at the start of a sentence), `gistup`, `AppSecTA`, `OWASP Top 10`; borrowed words as `кэш`, `таймаут`, `чек-лист`.
- **Card grids use rem tracks**: `grid-template-columns: repeat(auto-fill, minmax(min(14rem, 100%), 1fr))`, never `px` — the root font grows on wide screens and a px column stops fitting its heading.
- **Diagrams are Mermaid blocks in Markdown**, not exported images: `flowchart TB` with step curves, GOST 19.701 shapes, `accTitle`/`accDescr`, no emoji.

## Reporting Issues

- Use the issue template if available.
- Provide detailed descriptions, reproduction steps, and environment information.
- Verify the issue has not already been reported.

## Discussion and Support

- Use the Issues section for questions and discussions.
- Maintain a friendly and respectful tone in all communications.

## Code of Conduct

By participating in this project, you agree to abide by the [Code of Conduct](CODE_OF_CONDUCT.md) that fosters a safe and welcoming environment.

---

If you have any questions, feel free to reach out to the project team via issues or email.

Thank you for your contribution!
