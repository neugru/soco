#!/bin/bash
set -e

# Navigate to the project root (one level up from the script's location)
cd "$(dirname "$0")/.."

# Run icon_font_generator
dart run icon_font_generator:generator

# Prepend lint ignore
if [ -f lib/ui/core/styles/icons.dart ]; then
  printf "%s\n%s\n" "// ignore_for_file: unintended_html_in_doc_comment" "$(cat lib/ui/core/styles/icons.dart)" > lib/ui/core/styles/icons.dart ||
    echo "Warning: Failed to prepend lint ignore to lib/ui/core/styles/icons.dart" >&2
else
  echo "Warning: lib/ui/core/styles/icons.dart not found. Could not prepend lint ignore." >&2
fi

# Sync font to widgetbook
if [ -f assets/fonts/SocoIcons.otf ]; then
  mkdir -p widgetbook/assets/fonts
  cp assets/fonts/SocoIcons.otf widgetbook/assets/fonts/SocoIcons.otf
else
  echo "Error: Source font assets/fonts/SocoIcons.otf not found." >&2
  exit 1
fi

echo "Custom icons regenerated and synced successfully."
