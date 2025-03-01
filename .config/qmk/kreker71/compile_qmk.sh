#!/bin/bash

# Exit on any error
set -e

# Define paths
VIAL_QMK_PATH=~/vial-qmk
TARGET_DIR=$VIAL_QMK_PATH/keyboards/crkbd/keymaps/kreker71
CURRENT_DIR=$(pwd)

# Check if vial-qmk directory exists
if [ ! -d "$VIAL_QMK_PATH" ]; then
    echo "Error: vial-qmk directory not found at $VIAL_QMK_PATH"
    echo "Please clone vial-qmk repository first:"
    echo "git clone https://github.com/vial-kb/vial-qmk.git ~/vial-qmk"
    exit 1
fi

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy configuration files
echo "Copying configuration files..."
cp "$CURRENT_DIR/keymap.c" "$TARGET_DIR/"
cp "$CURRENT_DIR/config.h" "$TARGET_DIR/"
cp "$CURRENT_DIR/rules.mk" "$TARGET_DIR/"
cp "$CURRENT_DIR/vial.json" "$TARGET_DIR/"

# Navigate to vial-qmk directory
cd "$VIAL_QMK_PATH"

# Make sure all submodules are initialized
echo "Initializing submodules..."
git submodule update --init --recursive

# Compile the firmware
echo "Compiling firmware..."
make crkbd:kreker71

echo "Done! Your firmware has been compiled."
echo "The compiled firmware should be available at:"
echo "$VIAL_QMK_PATH/.build/crkbd_rev1_kreker71.hex" 