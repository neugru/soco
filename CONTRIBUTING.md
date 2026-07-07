# Contributing to soco

To maintain a clean repository history, high code quality, and automated versioning, please follow these guidelines when contributing.

## Widgetbook Catalog Utilization

This project uses [Widgetbook](https://widgetbook.io) to develop and preview UI components in isolation without having to run the entire app or navigate user flows.

The Widgetbook app is structured as a separate package inside the `widgetbook/` subdirectory. For detailed setup instructions, writing use cases, and exposing interactive knobs, please refer to the [Widgetbook README](widgetbook/README.md).

### Quick Start

1. **Navigate to the widgetbook directory:**
   ```bash
   cd widgetbook
   ```
2. **Launch the Widgetbook app:**
   We recommend running it on Chrome or Desktop for a side-by-side resizable canvas:
   ```bash
   flutter run -d chrome
   # flutter run -d linux
   ```
3. **Regenerate the navigation tree registry** (after adding, removing, or renaming usecases):
   ```bash
   dart run build_runner build -d
   ```

## Updating Custom Icons

To update or add new custom icons to the application:

1. **Prepare:** Save your icons as `.svg` files.
2. **Place:** Add the SVG files to the `assets/icons/` directory.
3. **Compile & Sync:** Run the generation script:
   * **Linux/macOS:**
     ```bash
     ./scripts/generate_icons.sh
     ```
   * **Windows (PowerShell):**
     ```powershell
     .\scripts\generate_icons.ps1
     ```

> This script compiles the SVG vectors into the binary font file (`assets/fonts/SocoIcons.otf`), prepends lint ignores to the generated Dart class, and syncs the output font to the Widgetbook workspace asset bundle.

## Development Workflow

### 1. Work on a Feature Branch

Never commit directly to the `main` branch. Always create a descriptive feature branch:
```bash
git switch -c feat/your-feature-name
# or git switch -c fix/your-fix-name
# ...
```

### 2. Code Formatting

Format all your Dart files using the standard formatter before merging:
```bash
dart format .
```
> The CI verification pipeline will reject any Pull Request that contains unformatted Dart files.

To prevent the formatter from modifying specific sections of code, wrap the block with formatting comments:
```dart
// dart format off
final matrix = [
  [1, 0, 0],
  [0, 1, 0],
  [0, 0, 1]
];
// dart format on
```

### 3. Code Analysis

Ensure your code passes static analysis checks without any errors or warnings:
```bash
flutter analyze
```
> Pull Requests with analysis warnings or errors will fail CI validation.

In rare cases where a specific linter rule should be bypassed, use the `ignore` comment syntax:
* **For a single line:**
  ```dart
  // ignore: unused_local_variable
  var temp = 'hello';
  ```
* **For an entire file:** Place this at the very top of the file:
  ```dart
  // ignore_for_file: unused_local_variable
  ```

## Merging & Release Rules

When merging your Pull Request into `main`:
1. **Always use "Squash and Merge"** in the GitHub interface.
2. Ensure the **squashed commit message** starts with the appropriate Conventional Commit prefix (e.g., `feat: add beans search`).

### Conventional Commit Message Rules

| Prefix | Type of Change | Version Bump |
| :--- | :--- | :--- |
| `feat!:` / `fix!:` | Breaking change (denoted with a `!` after prefix) | Minor (during `0.x.x` initial development) |
| `feat:` | New feature | Minor (`0.1.0` $\rightarrow$ `0.2.0`) |
| `fix:` | Bug fix | Patch (`0.1.0` $\rightarrow$ `0.1.1`) |
| `perf:` | Performance optimization | Patch (`0.1.0` $\rightarrow$ `0.1.1`) |
| `docs:` | Documentation updates | None |
| `style:` | Code formatting / style changes | None |
| `refactor:`| Code refactoring without functionality changes | None |
| `chore:` | Routine maintenance (build settings, dependencies) | None |
