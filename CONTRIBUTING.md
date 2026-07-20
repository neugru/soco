# Contributing to soco

To maintain a clean repository history, high code quality, and automated versioning, please follow these guidelines when contributing.

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

Ensure your code passes all static analysis checks without any errors or warnings. You should run both analysis commands to match the CI verification pipeline:

1. **Custom Plugin Analysis** (ensures your code adheres to custom rules defined in [soco_lints](soco_lints)):
   ```bash
   find lib -name "*.dart" | xargs -r dart analyze
   ```
2. **Standard Flutter Analysis** (checks for compile errors, general syntax, and standard Flutter rules):
   ```bash
   flutter analyze
   ```
> Pull Requests with analysis warnings or errors in either command will fail CI validation.

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
| `feat!:` / `fix!:` | Breaking change (denoted with a `!` after prefix) | Major (Minor during `0.x.x` initial development) |
| `feat:` | New feature | Minor (`0.1.0` $\rightarrow$ `0.2.0`) |
| `fix:` | Bug fix | Patch (`0.1.0` $\rightarrow$ `0.1.1`) |
| `perf:` | Performance optimization | Patch (`0.1.0` $\rightarrow$ `0.1.1`) |
| `docs:` | Documentation updates | None |
| `style:` | Code formatting / style changes | None |
| `refactor:`| Code refactoring without functionality changes | None |
| `chore:` | Routine maintenance (build settings, dependencies) | None |

## Project Architecture & MVVM Pattern

The project follows a **Feature-First + Central Core** architecture matching the MVVM (Model-View-ViewModel) design pattern:

*   **`lib/core/`**: Centralized domain/logic layer shared across all features.
    *   `lib/core/models/`: Shared models (e.g., [Bean](lib/core/models/bean.dart), [BrewProfile](lib/core/models/brew_profile.dart), [Machine](lib/core/models/machine.dart), [Grinder](lib/core/models/grinder.dart)).
*   **`lib/ui/core/`**: Shared presentation/style resources (e.g., typography, colors, layouts, and global widgets like [FadingMask](lib/ui/core/ui/widgets/fading_mask.dart)).
*   **`lib/ui/features/<feature_name>/`**: Local feature modules. Each feature folder is organized into:
    *   **`models/` (Model)**: Internal models specific *only* to this feature.
    *   **`views/` (View)**: UI layouts, dialogs, and presentation widgets. Views bind to their ViewModels using a native `ListenableBuilder` (or `AnimatedBuilder`).
    *   **`viewmodels/` (ViewModel)**: State management handlers inheriting from `ChangeNotifier`. ViewModels are instantiated directly inside the `StatefulWidget`'s `initState()` of the view and disposed inside its `dispose()` method. No external state management framework is permitted unless explicitly approved.

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
   dart run build_runner build
   ```

## Updating Custom Icons

To update or add new custom icons to the application:

1. **Prepare:** Save your icons as `.svg` files (preferrably 24x24).
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

