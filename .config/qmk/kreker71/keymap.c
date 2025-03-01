#include QMK_KEYBOARD_H

extern uint8_t is_master;

/*
 * Keymap Overview
 * --------------
 * This is a 36-key split keyboard layout optimized for programming and general typing.
 * It features 4 layers:
 * - Base (QWERTY)
 * - Lower (Numbers and Symbols)
 * - Raise (Navigation and Media)
 * - Function (F-keys and System)
 */

// Custom keycodes for layer switching
enum custom_keycodes {
    QWERTY = SAFE_RANGE,
    LOWER,
    RAISE,
    FUNC,
    BACKLIT
};

/* Layer Definitions
 * ----------------
 * _QWERTY - Base typing layer
 * _LOWER  - Numbers and primary symbols
 * _RAISE  - Navigation, media controls, and secondary symbols
 * _FUNC   - Function keys and keyboard controls
 */
#define _QWERTY 0
#define _LOWER  1
#define _RAISE  2
#define _FUNC   3

/* 
 * Modifier Key Definitions
 * -----------------------
 * OSM_  = One Shot Modifier (tap for temporary, hold for continuous)
 * LT_   = Layer Tap (tap for keycode, hold for layer)
 * GUI_T = GUI modifier when held, key when tapped
 */

// Base layer modifiers
#define OSM_LCTL OSM(MOD_LCTL)      // One-shot left Control
#define OSM_AGR  OSM(MOD_RALT)      // One-shot Alt Gr (right Alt)
#define OSL_FUN  OSL(_FUNC)         // One-shot Function layer
#define GUI_ENT  GUI_T(KC_ENT)      // GUI (Win/Cmd) when held, Enter when tapped
#define LOW_TAB  LT(_LOWER, KC_TAB) // Lower layer when held, Tab when tapped
#define RSE_BSP  LT(_RAISE, KC_BSPC)// Raise layer when held, Backspace when tapped
#define OSM_SFT  OSM(MOD_LSFT)      // One-shot Shift

// Raise layer special keys
#define CTL_ESC  LCTL_T(KC_ESC)     // Control when held, Escape when tapped

// Hyper key definitions
#define KC_HYPR HYPR(KC_NO)         // Hyper key (Ctrl+Alt+Shift+GUI)
#define HYPR_SPC HYPR_T(KC_SPC)     // Hyper when held, Space when tapped

/* 
 * Keymap Matrices
 * --------------
 * Each layer is defined as a matrix of keycodes.
 * The layout is split into left and right halves, separated by the middle gap.
 */

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    /* Base QWERTY Layer
     * ,-------------------------------------------.                    .-------------------------------------------.
     * |  Tab   |   Q  |   W  |   E  |   R  |   T  |                    |   Y  |   U  |   I  |   O  |   P  | Del    |
     * |--------+------+------+------+------+------|                    |------+------+------+------+------+--------|
     * |Alt/⌥   |   A  |   S  |   D  |   F  |   G  |                    |   H  |   J  |   K  |   L  |  '   | AltGr  |
     * |--------+------+------+------+------+------|                    |------+------+------+------+------+--------|
     * | Shift  |   Z  |   X  |   C  |   V  |   B  |                    |   N  |   M  |   ,  |   .  |   /  |  Fn    |
     * `--------+------+------+------+------+------+-----'       `------+------+------+------+------+------+--------'
     *                              | Ctrl |Gui/⌘ |Lower/Tab|    |Raise/Bsp| Hyper/Space| Shift|
     *                              `--------------------'       `--------------------'
     */
    [_QWERTY] = LAYOUT( \
        KC_TAB,         KC_Q,    KC_W,    KC_E,    KC_R,    KC_T,                     KC_Y,    KC_U,    KC_I,    KC_O,    KC_P,    KC_DEL,  \
        OSM(MOD_LALT),  KC_A,    KC_S,    KC_D,    KC_F,    KC_G,                     KC_H,    KC_J,    KC_K,    KC_L,    KC_QUOT, OSM_AGR, \
        OSM(MOD_LSFT),  KC_Z,    KC_X,    KC_C,    KC_V,    KC_B,                     KC_N,    KC_M,    KC_COMM, KC_DOT,  KC_SLSH, OSL_FUN, \
                                          OSM_LCTL, GUI_ENT, LOW_TAB,     RSE_BSP, HYPR_SPC, OSM_SFT                                        \
    ),

    /* Lower Layer: Numbers and Symbols
     * ,------------------------------------------.                     ,-------------------------------------------.
     * |       |   !  |   @  |   #  |   $  |   %  |                     |   ^  |   &  |   *  |   (  |   )  |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       |   1  |   2  |   3  |   4  |   5  |                     |   6  |   7  |   8  |   9  |   0  |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       |      |   ~  |   `  |   [  |   {  |                     |   }  |   ]  |   ,  |   .  |   /  |        |
     * |-------+------+------+------+------+------+------'       `------+------+------+------+------+------+--------'
     *                              |      |      |Lower |       |      |      |   :  |
     *                              `--------------------'       `--------------------'
     */
    [_LOWER] = LAYOUT( \
        _______, KC_EXLM, KC_AT,   KC_HASH, KC_DLR,  KC_PERC,                   KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN, _______, \
        _______, KC_1,    KC_2,    KC_3,    KC_4,    KC_5,                      KC_6,    KC_7,    KC_8,    KC_9,    KC_0,    _______, \
        _______, XXXXXXX, KC_TILD, KC_GRV,  KC_LBRC, KC_LCBR,                   KC_RCBR, KC_RBRC, KC_COMM, KC_DOT,  KC_SLSH, _______, \
                                            KC_TRNS,  KC_TRNS, LOWER,   KC_TRNS, KC_TRNS, KC_COLON                                    \
    ),

    /* Raise Layer: Navigation and Media Controls
     * ,------------------------------------------.                     ,-------------------------------------------.
     * |       |Del   |      |   _  |   +  | PgUp |                     |      |   \  |   |  |      |      |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       |Home  |End   |   -  |   =  | PgDn |                     |Left  |Down  |Up    |Right |Menu  |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       |  <   |  >   |Copy  |Paste |  ;   |                     |Play  |Prev  |Next  |Vol-  |Vol+  |        |
     * |-------+------+------+------+------+------+------'       `------+------+------+------+------+------+--------'
     *                              |Ctl/Esc|     |      |       |Raise |KC_HYPR|      |
     *                              `--------------------'       `--------------------'
     */

    [_RAISE] = LAYOUT( \
        _______, KC_DEL,  XXXXXXX, KC_UNDS, KC_PLUS, KC_PGUP,                   XXXXXXX, KC_BSLS, KC_PIPE, XXXXXXX, XXXXXXX, _______, \
        _______, KC_HOME, KC_END,  KC_MINS, KC_EQL,  KC_PGDN,                   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_APP,  _______, \
        _______, KC_LT,   KC_GT,   KC_COPY, KC_PSTE, KC_SCLN,                   KC_MPLY, KC_MPRV, KC_MNXT, KC_VOLD, KC_VOLU, _______, \
                                            CTL_ESC, KC_TRNS, XXXXXXX,  RAISE,   KC_HYPR, KC_TRNS                                     \
    ),

    /* Function Layer: F-keys and System Controls
     * ,------------------------------------------.                     ,-------------------------------------------.
     * |       |  F1  |  F2  |  F3  |  F4  |  F5  |                     |  F6  |  F7  |  F8  |  F9  | F10  |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       |  F11 |  F12 |      ||      |                     |      |      |      |      |      |        |
     * |-------+------+------+------+------+------|                     |------+------+------+------+------+--------|
     * |       | Caps |      |      |      |      |                     |      |      |      |      |Reset |        |
     * |-------+------+------+------+------+------+------'       `------+------+------+------+------+------+--------'
     *                              |      |      |      |       |Raise |      |      |
     *                              `--------------------'       `--------------------'
     */
    [_FUNC] = LAYOUT( \
        _______, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                     KC_F6,   KC_F7,   KC_F8,   KC_F9,   KC_F10,  _______, \
        _______, KC_F11,  KC_F12,  XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, _______, \
        _______, KC_CAPS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                   XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, QK_BOOT, XXXXXXX, \
                                            XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, FUNC,    XXXXXXX                                     \
    )
};

