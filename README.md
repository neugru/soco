# soco

The Social Coffee Networking app.

## Getting Started

If you are checking out this repository for the first time, follow these steps to set up your local development environment.

>If you plan on contributing to this project, check out the [Contributing](#contributing) section.

### Prerequisites
* Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) (Ensure you are on the `stable` channel).
* A mobile emulator (Android/iOS) or a connected physical test device.

### Setup Instructions

1. **Clone the repository**:
   ```bash
   git clone https://github.com/alenscoo/soco.git
   cd soco
   ```

2. **Restore dependencies**:
   Run the following command to download all necessary packages:
   ```bash
   flutter pub get
   ```
   *(Note: This is mandatory whenever you clone, switch branches with modified dependencies, or run `flutter clean` to resolve index/unresolved import errors in your IDE).*

3. (optional) **Verify the environment**:
   Run code analysis and verify code style:
   ```bash
   flutter analyze
   ```

 ### Launch the application
   Start the application on your connected emulator or device:
   ```bash
   flutter run
   ```

## Contributing

To maintain a clean repository history and automate our versioning, please follow these guidelines when contributing:

### 1. Work on a Feature Branch
Never commit directly to the `main` branch. Always create a descriptive feature branch:
```bash
git checkout -b feat/your-feature-name
# git checkout -b fix/your-fix-name
# ...

# or using modern git:
git switch -c feat/your-feature-name
# git switch -c fix/your-fix-name
# ...
```

### 2. Code Formatting

Ensure all your Dart files are formatted according to the standard style guidelines before committing. You can format the entire repository by running:
```bash
dart format .

# use "-o none" to list the files that would get changed (no changes will be made!)
dart format -o none .
# Output:
# Changed lib/core/assets.dart
# Changed lib/main.dart
# ...
```
*(Note: The CI verification workflow runs `dart format -o none --set-exit-if-changed .` on every Pull Request. Commits with unformatted code will fail validation).*

#### Disabling the Formatter

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

Ensure your code passes static analysis checks without any errors or warnings. You can analyze the repository locally by running:
```bash
flutter analyze
```
*(Note: The CI verification workflow runs `flutter analyze` on every Pull Request. Commits with warnings or errors will fail validation).*

#### Disabling Linter Warnings

In rare cases where a specific linter rule should be bypassed, use the `ignore` comment syntax:
*   **For a single line:**
    ```dart
    // ignore: unused_local_variable
    var temp = 'hello';
    ```
*   **For an entire file** (preferrably at the very top of the file):
    ```dart
    // ignore_for_file: unused_local_variable
    ```

### 4. Squash and Merge Pull Requests

When merging your Pull Request into `main`:
1. **Always use "Squash and Merge"** in the GitHub interface.
2. Ensure the **Verify Code Quality** check passes.
3. Ensure the **squashed commit message** starts with the appropriate [Conventional Commit prefix](#conventional-commit-message-rules) (e.g., `feat: add beans search`).
> This single squashed commit will trigger the CI release runner to update `pubspec.yaml`, write to `CHANGELOG.md`, and deploy the release tag.

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
