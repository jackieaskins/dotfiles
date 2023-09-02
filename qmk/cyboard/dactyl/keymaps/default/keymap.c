/* Copyright 2023 Cyboard LLC (@Cyboard-DigitalTailor)
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#include QMK_KEYBOARD_H

/*
38 32 26 20 14 03 xx   xx 43 54 60 66 72 78
37 31 25 19 13 02 xx   xx 42 53 59 65 71 77
36 30 24 18 12 01 xx   xx 41 52 58 64 70 76
35 29 23 17 11 00 xx   xx 40 51 57 63 69 75
34 28 22 16 10 05 06   46 45 50 56 62 68 74
 */

#define LCTL_T_Z    LCTL_T(KC_Z)
#define RCTL_T_SLSH RCTL_T(KC_SLSH)
#define LGUI_T_QUOT LGUI_T(KC_QUOT)
#define LALT_T_LBRC LALT_T(KC_LBRC)
#define LT_1_GRV    LT(1, KC_GRV)
#define LT_1_RBRC   LT(1, KC_RBRC)
#define LT_2_SCLN   LT(2, KC_SCLN)

void set_layer_1_colors(uint8_t led_min, uint8_t led_max) {
    // Light up numpad
    for (uint8_t i = led_min; i < led_max; i++) {
        if ((i >= 50 && i <= 53) || (i >= 56 && i <= 59) || (i >= 62 && i <= 65)) {
            rgb_matrix_set_color(i, RGB_PURPLE);
        } else {
            rgb_matrix_set_color(i, RGB_OFF);
        }
    }
}

void set_layer_2_colors(uint8_t led_min, uint8_t led_max) {
    for (uint8_t i = led_min; i < led_max; i++) {
        switch(i) {
            // Volume controls
            case 56:
            case 62:
            case 68:
                rgb_matrix_set_color(i, RGB_BLUE);
                break;
            // Playback controls
            case 63:
            case 69:
            case 76:
                rgb_matrix_set_color(i, RGB_PURPLE);
                break;
            default:
                rgb_matrix_set_color(i, RGB_OFF);
                break;
        }
    }
}

bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
    switch(get_highest_layer(layer_state|default_layer_state)) {
        case 2:
            set_layer_2_colors(led_min, led_max);
            break;
        case 1:
            set_layer_1_colors(led_min, led_max);
            break;
        default:
            break;
    }

    return false;
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_singlearc_number_row(
        KC_EQL,    KC_1,     KC_2,    KC_3,    KC_4,   KC_5,                      KC_6,    KC_7,   KC_8,    KC_9,    KC_0,        KC_MINS,
        KC_TAB,    KC_Q,     KC_W,    KC_E,    KC_R,   KC_T,                      KC_Y,    KC_U,   KC_I,    KC_O,    KC_P,        KC_BSLS,
        KC_LCTL,   KC_A,     KC_S,    KC_D,    KC_F,   KC_G,                      KC_H,    KC_J,   KC_K,    KC_L,    LT_2_SCLN,   LGUI_T_QUOT,
        KC_LSFT,   LCTL_T_Z, KC_X,    KC_C,    KC_V,   KC_B,                      KC_N,    KC_M,   KC_COMM, KC_DOT,  RCTL_T_SLSH, KC_RSFT,
        LT_1_GRV,  KC_LGUI,  KC_LEFT, KC_RGHT, KC_SPC, KC_ESC, KC_MEH,   KC_HYPR, KC_BSPC, KC_ENT, KC_UP,   KC_DOWN, LALT_T_LBRC, LT_1_RBRC
    ),

    [1] = LAYOUT_singlearc_number_row(
        KC_ESC,  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,                       KC_F6,   KC_F7, KC_F8, KC_F9,   KC_F10,  KC_F11,
        _______, _______, _______, _______, _______, _______,                     _______, KC_P7, KC_P8, KC_P9,   _______, KC_F12,
        _______, _______, _______, _______, _______, _______,                     _______, KC_P4, KC_P5, KC_P6,   _______, _______,
        _______, _______, _______, _______, _______, _______,                     _______, KC_P1, KC_P2, KC_P3,   _______, _______,
        _______, _______, _______, _______, _______, _______, _______,   _______, _______, KC_P0, KC_P0, KC_PDOT, _______, _______
    ),

    [2] = LAYOUT_singlearc_number_row(
        RGB_TOG, RGB_MOD, _______, _______, _______, _______,                     _______, _______, _______, _______, QK_RBT,  QK_BOOT,
        _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,  _______,
        _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______,  KC_MPLY,
        _______, _______, _______, _______, _______, _______,                     _______, _______, _______, KC_MPRV, KC_MNXT,  _______,
        _______, _______, _______, _______, _______, _______, _______,   _______, _______, _______, KC_MUTE, KC_VOLD, KC_VOLU,  _______
    ),
};

// LAYOUT_singlearc_number_row(
//     _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______, _______,
//     _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______, _______,
//     _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______, _______,
//     _______, _______, _______, _______, _______, _______,                     _______, _______, _______, _______, _______, _______,
//     _______, _______, _______, _______, _______, _______, _______,   _______, _______, _______, _______, _______, _______, _______
// ),
