# Widgetbook Workspace

This is the isolation sandbox and component catalog for the **Soco** Flutter application. Here, we build, test, and refine our design system widgets in isolation without running the main app.

## Getting Started

### Prerequisites
* Ensure you have set up the parent project first (refer to [README.md](../README.md)).
* Make sure you have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.

### Setup Instructions
1. Navigate to the `widgetbook` workspace directory:
   ```bash
   cd widgetbook
   ```
2. Download dependencies:
   ```bash
   flutter pub get
   ```

## Running the Catalog

We recommend running the Widgetbook app on **Chrome (Web)** or **Desktop** (Linux/macOS/Windows) for a side-by-side catalog layout with resizable canvases.

```bash
# Run on Chrome
flutter run -d chrome

# Run on Linux Desktop
flutter run -d linux

# Run on macOS Desktop
flutter run -d macos

# Run on Windows Desktop
flutter run -d windows
```

## Catalog Directory Generation

Widgetbook uses code generation via `build_runner` to scan annotations (`@UseCase` and `@App`) and build the sidebar tree structure.

**Whenever you add, remove, or rename a component preview, run this command in the `widgetbook/` directory:**
```bash
dart run build_runner build -d
```
*(This updates the generated `lib/main.directories.g.dart` file).*

## Writing Use Cases

Use Cases are isolated previews of your widgets. They live inside this workspace (typically under `widgetbook/lib/`) in files named `*.usecase.dart`.

### Exposing Knobs

Interactive properties (knobs) allow users to adjust inputs dynamically in the Widgetbook sidebar:
* **Booleans:** `context.knobs.boolean(label: 'Dark Mode', initialValue: false)`
* **Text:** `context.knobs.string(label: 'Bean Name', initialValue: 'Ethiopia')`
* **Dropdown Selection:** `context.knobs.object.dropdown(label: 'Roast', options: RoastLevel.values)`
* **Numbers (Sliders):** `context.knobs.double.slider(label: 'Rating', initialValue: 4.5, min: 0.0, max: 5.0)`

## Asset & Font Synchronization

* **Custom Fonts/Icons:** The custom icon font `Soco Icons` is registered as a local asset (`assets/fonts/SocoIcons.otf`) inside this sub-project. 
* **Updating Icons:** When you add or modify icons in the main project, use the main project's generation script (`./scripts/generate_icons.sh` or `.\scripts\generate_icons.ps1`). This script automatically compiles the font and copies it over to `widgetbook/assets/fonts/` for you.

> [!WARNING]
> Do not modify or replace `widgetbook/assets/fonts/SocoIcons.otf` manually. This file is a build output target and will be completely overwritten whenever the `./scripts/generate_icons` script is run. Always manage icons from the root project.
