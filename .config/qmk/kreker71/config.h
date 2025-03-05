/*
This file contains configuration settings for the Corne keyboard.
It defines various parameters that affect the keyboard's behavior,
keymap layers, RGB lighting, communication protocol, and more.

These settings can be adjusted based on personal preferences
or hardware-specific requirements.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma once

// Unique identifier for this keyboard, used by the Vial configurator.
#define VIAL_KEYBOARD_UID {0x3B, 0x6B, 0xA0, 0x29, 0x80, 0x56, 0xED, 0xD1}

// Defines the rows and columns for the unlock combo for accessing the Vial configuration.
#define VIAL_UNLOCK_COMBO_ROWS {0, 0}
#define VIAL_UNLOCK_COMBO_COLS {0, 1}

// Specifies the number of dynamic keymap layers that can be defined.
// This is useful for creating multiple layers for different key layouts.
#define DYNAMIC_KEYMAP_LAYER_COUNT 4

// Sets the tapping term (in milliseconds) for tap-hold keys.
// This determines how long a key can be held before it registers as a "hold" action.
#define TAPPING_TERM 200

#define TAPPING_FORCE_HOLD

// Sets the time window (in milliseconds) for triggering combo key actions.
// A low value ensures the keys must be pressed simultaneously to activate the combo.
#define COMBO_TERM 50

// Allows permissive hold behavior, meaning the hold action takes precedence
// if the key is released before the tapping term expires.
#define PERMISSIVE_HOLD

// Configures the behavior of one-shot modifiers like Shift.
// ONESHOT_TAP_TOGGLE defines how many taps are required to toggle the modifier.
// ONESHOT_TIMEOUT sets the duration (in milliseconds) after which the one-shot modifier deactivates.
#define ONESHOT_TAP_TOGGLE 3
#define ONESHOT_TIMEOUT 2000

// Defines the communication protocol for the keyboard halves.
// USE_SERIAL_PD2 sets up a serial communication link using pin PD2.
#define USE_SERIAL_PD2

// If the keyboard is a crkbd rev1 legacy model, ensure the correct protocol is defined.
#ifdef KEYBOARD_crkbd_rev1_legacy
#    undef USE_I2C
#    define USE_SERIAL
#endif

/* Hand configuration */
// Defines which half of the keyboard is the master. Uncomment the appropriate line.
#define MASTER_LEFT // The left half acts as the master.
// #define MASTER_RIGHT // Uncomment if the right half is the master.
// #define EE_HANDS // Uncomment if EEPROM is used to determine hand configuration.
