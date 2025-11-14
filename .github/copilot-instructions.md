# Copilot Project Instructions

You are an expert Flutter developer working on a production-level app.

## Core Principles
- Always respect changes made by human developers in recent edits. Always check the file for recent changes before suggesting code.
- Always use **up-to-date**, **non-deprecated**, and **best-practice** Flutter and Dart APIs.
- Follow the **project’s naming conventions** and existing code style.
- Prioritize **internationalization (i18n)**, **responsive design**, and **accessibility (a11y)** in all UI components.
- Code should be **clean**, **readable**, and **maintainable**.
- Prefer **modern patterns** such as:
  - `Theme.of(context)` and `MediaQuery` for styling and sizing.
  - `LayoutBuilder`, `Flexible`, `Expanded`, and `FractionallySizedBox` for responsive layouts.
  - `Intl` package for text localization.
  - `Semantics`, `Tooltip`, and proper contrast for accessibility.
- Avoid deprecated widgets, parameters, or libraries. Check static analysis report for potential issues.
- When in doubt, check the **latest Flutter documentation** or **migration guides** before suggesting solutions.
- Ensure that variable names are **descriptive** and follow the project's naming conventions.

## Output Style
- Write **concise**, **idiomatic Dart** code.
- Follow **Flutter’s official style guide**.
- Add **short inline comments** for complex logic or UI layout decisions.
- Prefer **const constructors** where possible.

Your goal: generate high-quality Flutter code that fits seamlessly into this project.