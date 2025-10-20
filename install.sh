#!/bin/bash

# Define the custom layout name and description
LAYOUT_NAME="uz"
VARIANT_NAME="latin"
DESCRIPTION="Uzbek (Latin)"
SYMBOLS_FILE="uz"
SYMBOLS_FILE_EN="en"

# Define the paths
SYMBOLS_DIR="/usr/share/X11/xkb/symbols/"
RULES_FILE="/usr/share/X11/xkb/rules/evdev.xml"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo."
  exit 1
fi

# Step 1: Copy the symbols file
echo "Copying $SYMBOLS_FILE_EN to $SYMBOLS_DIR..."
cp "$SYMBOLS_FILE_EN" "$SYMBOLS_DIR"
if [ $? -eq 0 ]; then
  echo "✔ Successfully copied $SYMBOLS_FILE_EN."
else
  echo "✘ Failed to copy $SYMBOLS_FILE_EN. Aborting."
  exit 1
fi

echo "Copying $SYMBOLS_FILE to $SYMBOLS_DIR..."
cp "$SYMBOLS_FILE" "$SYMBOLS_DIR"
if [ $? -eq 0 ]; then
  echo "✔ Successfully copied $SYMBOLS_FILE."
else
  echo "✘ Failed to copy $SYMBOLS_FILE. Aborting."
  exit 1
fi

# Step 2: Check and update the evdev.xml file
echo "Checking for existing entry in $RULES_FILE..."

# This check looks for a line containing the layout name.
# It's a simple text check and may not catch all edge cases.
if grep -q "<name>$LAYOUT_NAME</name>" "$RULES_FILE"; then
  echo "Entry for '$LAYOUT_NAME' already exists. Checking for variant '$VARIANT_NAME'..."

  if grep -q "<name>$VARIANT_NAME</name>" "$RULES_FILE"; then
    echo "✔ Variant '$VARIANT_NAME' already exists. No changes made to $RULES_FILE."
  else
    # Insert the new variant entry
    echo "Inserting new variant entry for '$VARIANT_NAME'..."
    sed -i "/<name>$LAYOUT_NAME<\/name>/{:a;n;/variantList/!ba;n;i\
        <variant>\
          <configItem>\
            <name>$VARIANT_NAME</name>\
            <description>$DESCRIPTION</description>\
          </configItem>\
        </variant>}" "$RULES_FILE"
    echo "✔ Successfully added '$VARIANT_NAME' variant."
  fi
else
  # Insert the full layout entry
  echo "Entry for '$LAYOUT_NAME' not found. Inserting new layout..."
  sed -i "/<\/layoutList>/i\
    <layout>\
      <configItem>\
        <name>$LAYOUT_NAME</name>\
        <description>$DESCRIPTION</description>\
      </configItem>\
      <variantList>\
        <variant>\
          <configItem>\
            <name>$VARIANT_NAME</name>\
            <description>$DESCRIPTION</description>\
          </configItem>\
        </variant>\
      </variantList>\
    </layout>" "$RULES_FILE"
  echo "✔ Successfully added new layout and variant."
fi

# Step 3: Reconfigure XKB data to apply changes
echo "Reconfiguring XKB data..."
dpkg-reconfigure xkb-data
echo "Installation complete. You may need to log out and log back in for changes to take full effect."

# Optional: Set the layout for the current session
echo "Setting keyboard layout for the current session..."
setxkbmap -layout "$LAYOUT_NAME" -variant "$VARIANT_NAME"
echo "Layout is now set to $DESCRIPTION."