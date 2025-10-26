#!/bin/bash

# Define the custom layout name and description
LAYOUT_NAME="uz"
DESCRIPTION="Uzbek"
SYMBOLS_FILE="uz"
PATCH_FILE="evdev_patch.patch"

# Define the paths
SYMBOLS_DIR="/usr/share/X11/xkb/symbols/"
RULES_FILE="/usr/share/X11/xkb/rules/evdev.xml"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

# Check for patch file existence
if [ ! -f "$PATCH_FILE" ]; then
    echo "✘ Error: Patch file '$PATCH_FILE' not found in the current directory. Aborting."
    exit 1
fi

# Step 1: Copy the symbols file

echo "Copying $SYMBOLS_FILE to $SYMBOLS_DIR..."
cp "$SYMBOLS_FILE" "$SYMBOLS_DIR"
if [ $? -eq 0 ]; then
  echo "✔ Successfully copied $SYMBOLS_FILE."
else
  echo "✘ Failed to copy $SYMBOLS_FILE. Aborting."
  exit 1
fi

# ----------------------------------------------------------------------
# Step 2: Apply the patch to evdev.xml using 'patch'
# The patch utility will handle the XML insertion using context matching.
# ----------------------------------------------------------------------
echo "Applying patch to $RULES_FILE using '$PATCH_FILE'..."

# The -p0 option is crucial if the patch file assumes it is being applied
# from the current directory (which is usually the case for a simple patch).
patch "$RULES_FILE" < "$PATCH_FILE"
PATCH_EXIT_CODE=$?

if [ $PATCH_EXIT_CODE -eq 0 ]; then
  echo "✔ Successfully applied patch to $RULES_FILE."
elif [ $PATCH_EXIT_CODE -eq 1 ]; then
  echo "⚠ Warning: Patch applied with minor errors or fuzz. Please review $RULES_FILE and any .rej files."
  echo "This usually happens if the entry already exists or the file has minor changes."
elif [ $PATCH_EXIT_CODE -eq 2 ]; then
  echo "✘ Fatal Error: Patch failed completely. The file may be too different from the one the patch was created against. Aborting."
  exit 1
fi

# Step 3: Reconfigure XKB data to apply changes
echo "Reconfiguring XKB data..."
# This command is common on Debian/Ubuntu systems to rebuild XKB caches.
dpkg-reconfigure xkb-data

echo "Installation complete. You may need to log out and log back in for changes to take full effect."

# Optional: Set the layout for the current session
echo "Setting keyboard layout for the current session..."
setxkbmap -layout "$LAYOUT_NAME"
echo "Layout is now set to Uzbek."