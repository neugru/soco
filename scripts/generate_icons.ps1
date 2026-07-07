$ErrorActionPreference = "Stop"

# Step 1: Run generator quietly
$process = Start-Process dart -ArgumentList "run", "icon_font_generator:generator" -NoNewWindow -Wait -PassThru
if ($process.ExitCode -ne 0) {
    Write-Error "Error running icon_font_generator"
    exit $process.ExitCode
}

# Step 2: Prepend lint ignore
$iconsFile = "lib/ui/core/styles/soco_icons.dart"
if (Test-Path $iconsFile) {
    $content = Get-Content $iconsFile -Raw
    $lintIgnore = "// ignore_for_file: unintended_html_in_doc_comment`r`n"
    if (-not $content.StartsWith("// ignore_for_file: unintended_html_in_doc_comment")) {
        Set-Content $iconsFile -Value ($lintIgnore + $content)
    }
}

# Step 3: Copy output font to widgetbook workspace assets
$sourceFont = "assets/fonts/SocoIcons.otf"
$targetDir = "widgetbook/assets/fonts"
$targetFont = "widgetbook/assets/fonts/SocoIcons.otf"

if (Test-Path $sourceFont) {
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
    }
    Copy-Item -Path $sourceFont -Destination $targetFont -Force
} else {
    Write-Error "Error: Source font assets/fonts/SocoIcons.otf not found."
    exit 1
}

Write-Output "Custom icons regenerated and synced successfully."
