#!/usr/bin/env bash
# Build the KDE wallpaper kpackage zip with the embedded display module.
# Overwrites the canonical QML files with their *Embed.qml variants so the
# zip references the bundled WaywallenDisplayEmbed module instead of the
# system-installed Waywallen.Display one, then runs cmake configure + the
# `package` target. The resulting zip lands in ${BUILD_DIR}/waywallen-kde-*.zip.

set -euo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT=$(cd -- "$SCRIPT_DIR/.." && pwd)
BUILD_DIR=${BUILD_DIR:-build}

cd "$REPO_ROOT"

ui=extensions/kde/package/contents/ui
cp "$ui/ImportTestEmbed.qml"      "$ui/ImportTest.qml"
cp "$ui/WaywallenSurfaceEmbed.qml" "$ui/WaywallenSurface.qml"
rm "$ui/ImportTestEmbed.qml" "$ui/WaywallenSurfaceEmbed.qml"

cmake -S . -B "$BUILD_DIR" -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DWAYWALLEN_DISPLAY_PLUGIN_QML=ON \
    -DWAYWALLEN_DISPLAY_QML_URI=Waywallen.DisplayEmbed

cmake --build "$BUILD_DIR" --target package
