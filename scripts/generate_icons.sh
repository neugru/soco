#!/bin/bash
set -e

# Run icon_font_generator quietly
dart run icon_font_generator:generator > /dev/null

# Prepend lint ignore
if [ -f lib/ui/core/styles/soco_icons.dart ]; then
  if ! grep -q "// ignore_for_file: unintended_html_in_doc_comment" lib/ui/core/styles/soco_icons.dart; then
    temp_file=$(mktemp)
    echo "// ignore_for_file: unintended_html_in_doc_comment" > "$temp_file"
    cat lib/ui/core/styles/soco_icons.dart >> "$temp_file"
    mv "$temp_file" lib/ui/core/styles/soco_icons.dart
  fi
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
