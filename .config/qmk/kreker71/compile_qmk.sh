#!/bin/bash

# Exit on any error
set -e

# Define paths
VIAL_QMK_PATH=~/vial-qmk
TARGET_DIR=$VIAL_QMK_PATH/keyboards/crkbd/keymaps/kreker71
CURRENT_DIR=$(pwd)
FIRMWARE_UF2="$VIAL_QMK_PATH/.build/crkbd_rev1_kreker71_promicro_rp2040.uf2"

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

# Check if firmware was actually built
if [ ! -f "$FIRMWARE_UF2" ]; then
    echo "Error: Firmware file not found at $FIRMWARE_UF2"
    echo "Compilation may have failed."
    exit 1
fi

# Create build directory if it doesn't exist
BUILD_DIR="$CURRENT_DIR/build"
mkdir -p "$BUILD_DIR"

# Copy compiled firmware to build directory
echo "Copying compiled firmware to build directory..."
if ! cp "$FIRMWARE_UF2" "$BUILD_DIR/"; then
    echo "Error: Failed to copy firmware file to $BUILD_DIR"
    exit 1
fi

echo "Done! Your firmware has been compiled and copied to the build directory."
echo "Firmware files:"
echo "- $(basename "$FIRMWARE_UF2") (in $BUILD_DIR)"

# Verify the copy was successful
if [ ! -f "$BUILD_DIR/$(basename "$FIRMWARE_UF2")" ]; then
    echo "Error: Firmware file not found in build directory after copy"
    exit 1
fi

