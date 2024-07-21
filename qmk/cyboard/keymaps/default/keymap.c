/* Copyright 2023 Cyboard LLC (@Cyboard-DigitalTailor)
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#include QMK_KEYBOARD_H

#define LCTL_T_Z LCTL_T(KC_Z)
#define RCTL_T_SLSH RCTL_T(KC_SLSH)
#define LGUI_T_QUOT LGUI_T(KC_QUOT)
#define LALT_T_LBRC LALT_T(KC_LBRC)
#define LT_1_GRV LT(1, KC_GRV)
#define LT_1_RBRC LT(1, KC_RBRC)
#define LT_2_SCLN LT(2, KC_SCLN)

// clang-format off
const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
//    ┌──────────┬──────────┬──────┬──────┬─────┬─────┐                 ┌──────┬─────┬────┬──────┬─────────────┬─────────────┐
//    │    =     │    1     │  2   │  3   │  4  │  5  │                 │  6   │  7  │ 8  │  9   │      0      │      -      │
//    ├──────────┼──────────┼──────┼──────┼─────┼─────┤                 ├──────┼─────┼────┼──────┼─────────────┼─────────────┤
//    │   tab    │    q     │  w   │  e   │  r  │  t  │                 │  y   │  u  │ i  │  o   │      p      │      \      │
//    ├──────────┼──────────┼──────┼──────┼─────┼─────┤                 ├──────┼─────┼────┼──────┼─────────────┼─────────────┤
//    │   lctl   │    a     │  s   │  d   │  f  │  g  │                 │  h   │  j  │ k  │  l   │  LT_2_SCLN  │ LGUI_T_QUOT │
//    ├──────────┼──────────┼──────┼──────┼─────┼─────┤                 ├──────┼─────┼────┼──────┼─────────────┼─────────────┤
//    │   lsft   │ LCTL_T_Z │  x   │  c   │  v  │  b  │                 │  n   │  m  │ ,  │  .   │ RCTL_T_SLSH │    rsft     │
//    ├──────────┼──────────┼──────┼──────┼─────┼─────┼─────┐   ┌───────┼──────┼─────┼────┼──────┼─────────────┼─────────────┤
//    │ LT_1_GRV │   lgui   │ left │ rght │ spc │ esc │ meh │   │ hyper │ bspc │ ent │ up │ down │ LALT_T_LBRC │  LT_1_RBRC  │
//    └──────────┴──────────┴──────┴──────┴─────┴─────┴─────┘   └───────┴──────┴─────┴────┴──────┴─────────────┴─────────────┘
[0] = LAYOUT_single_arc_num(
  KC_EQL   , KC_1     , KC_2    , KC_3    , KC_4   , KC_5   ,                        KC_6    , KC_7   , KC_8    , KC_9    , KC_0        , KC_MINUS   ,
  KC_TAB   , KC_Q     , KC_W    , KC_E    , KC_R   , KC_T   ,                        KC_Y    , KC_U   , KC_I    , KC_O    , KC_P        , KC_BSLS    ,
  KC_LCTL  , KC_A     , KC_S    , KC_D    , KC_F   , KC_G   ,                        KC_H    , KC_J   , KC_K    , KC_L    , LT_2_SCLN   , LGUI_T_QUOT,
  KC_LSFT  , LCTL_T_Z , KC_X    , KC_C    , KC_V   , KC_B   ,                        KC_N    , KC_M   , KC_COMM , KC_DOT  , RCTL_T_SLSH , KC_RSFT    ,
  LT_1_GRV , KC_LGUI  , KC_LEFT , KC_RGHT , KC_SPC , KC_ESC , KC_MEH ,     KC_HYPR , KC_BSPC , KC_ENT , KC_UP   , KC_DOWN , LALT_T_LBRC , LT_1_RBRC
),

//    ┌─────────┬─────┬─────┬─────┬─────┬─────┐               ┌─────┬──────┬──────┬──────┬─────┬─────────┐
//    │   esc   │ f1  │ f2  │ f3  │ f4  │ f5  │               │ f6  │  f7  │  f8  │  f9  │ f10 │   f11   │
//    ├─────────┼─────┼─────┼─────┼─────┼─────┤               ├─────┼──────┼──────┼──────┼─────┼─────────┤
//    │         │     │     │     │     │     │               │     │ kp_7 │ kp_8 │ kp_9 │     │   f12   │
//    ├─────────┼─────┼─────┼─────┼─────┼─────┤               ├─────┼──────┼──────┼──────┼─────┼─────────┤
//    │         │     │     │     │     │     │               │     │ kp_4 │ kp_5 │ kp_6 │     │         │
//    ├─────────┼─────┼─────┼─────┼─────┼─────┤               ├─────┼──────┼──────┼──────┼─────┼─────────┤
//    │ QK_BOOT │     │     │     │     │     │               │     │ kp_1 │ kp_2 │ kp_3 │     │ QK_BOOT │
//    ├─────────┼─────┼─────┼─────┼─────┼─────┼─────┐   ┌─────┼─────┼──────┼──────┼──────┼─────┼─────────┤
//    │         │     │     │     │     │     │     │   │     │     │ kp_0 │ kp_0 │ kp_. │     │         │
//    └─────────┴─────┴─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴──────┴──────┴──────┴─────┴─────────┘
[1] = LAYOUT_single_arc_num(
  KC_ESC  , KC_F1   , KC_F2   , KC_F3   , KC_F4   , KC_F5   ,                         KC_F6   , KC_F7 , KC_F8 , KC_F9   , KC_F10  , KC_F11 ,
  _______ , _______ , _______ , _______ , _______ , _______ ,                         _______ , KC_P7 , KC_P8 , KC_P9   , _______ , KC_F12 ,
  _______ , _______ , _______ , _______ , _______ , _______ ,                         _______ , KC_P4 , KC_P5 , KC_P6   , _______ , _______,
  QK_BOOT , _______ , _______ , _______ , _______ , _______ ,                         _______ , KC_P1 , KC_P2 , KC_P3   , _______ , QK_BOOT,
  _______ , _______ , _______ , _______ , _______ , _______ , _______ ,     _______ , _______ , KC_P0 , KC_P0 , KC_PDOT , _______ , _______
),

//    ┌─────────┬─────────┬─────┬─────┬─────┬─────┐               ┌─────┬─────┬──────┬──────┬────────┬─────────┐
//    │ RGB_TOG │ RGB_MOD │     │     │     │     │               │     │     │      │      │ QK_RBT │ QK_BOOT │
//    ├─────────┼─────────┼─────┼─────┼─────┼─────┤               ├─────┼─────┼──────┼──────┼────────┼─────────┤
//    │ RGB_VAI │         │     │     │     │     │               │     │     │      │      │        │         │
//    ├─────────┼─────────┼─────┼─────┼─────┼─────┤               ├─────┼─────┼──────┼──────┼────────┼─────────┤
//    │ RGB_VAD │         │     │     │     │     │               │     │     │      │      │        │  mply   │
//    ├─────────┼─────────┼─────┼─────┼─────┼─────┤               ├─────┼─────┼──────┼──────┼────────┼─────────┤
//    │         │         │     │     │     │     │               │     │     │      │ mprv │  mnxt  │         │
//    ├─────────┼─────────┼─────┼─────┼─────┼─────┼─────┐   ┌─────┼─────┼─────┼──────┼──────┼────────┼─────────┤
//    │         │         │     │     │     │     │     │   │     │     │     │ mute │ vold │  volu  │         │
//    └─────────┴─────────┴─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴──────┴──────┴────────┴─────────┘
[2] = LAYOUT_single_arc_num(
  RGB_TOG , RGB_MOD , _______ , _______ , _______ , _______ ,                         _______ , _______ , _______ , _______ , QK_RBT  , QK_BOOT,
  RGB_VAI , _______ , _______ , _______ , _______ , _______ ,                         _______ , _______ , _______ , _______ , _______ , _______,
  RGB_VAD , _______ , _______ , _______ , _______ , _______ ,                         _______ , _______ , _______ , _______ , _______ , KC_MPLY,
  _______ , _______ , _______ , _______ , _______ , _______ ,                         _______ , _______ , _______ , KC_MPRV , KC_MNXT , _______,
  _______ , _______ , _______ , _______ , _______ , _______ , _______ ,     _______ , _______ , _______ , KC_MUTE , KC_VOLD , KC_VOLU , _______
)
};
// clang-format on

/*
 * Cyboard RGB Matrix                           |  Cyboard USB-C RGB Matrix
 * 38 32 26 20 14 03 xx   xx 43 54 60 66 72 78  |  26 21 16 11 06 02 xx   xx 33 37 42 47 52 57
 * 37 31 25 19 13 02 xx   xx 42 53 59 65 71 77  |  27 22 17 12 07 03 xx   xx 34 38 43 48 53 58
 * 36 30 24 18 12 01 xx   xx 41 52 58 64 70 76  |  23 18 13 08 04 00 xx   xx 31 35 39 44 49 54
 * 35 29 23 17 11 00 xx   xx 40 51 57 63 69 75  |  24 19 14 09 05 01 xx   xx 32 36 40 45 50 55
 * 34 28 22 16 10 05 06   46 45 50 56 62 68 74  |  25 20 15 10 28 29 30   61 60 59 41 46 51 56
 */

bool rgb_matrix_indicators_advanced_user(uint8_t led_min, uint8_t led_max) {
    uint8_t layer = get_highest_layer(layer_state | default_layer_state);

    if (layer > 0) {
        for (uint8_t row = 0; row < MATRIX_ROWS; ++row) {
            for (uint8_t col = 0; col < MATRIX_COLS; ++col) {
                uint8_t led_index = g_led_config.matrix_co[row][col];

                if (led_index >= led_min && led_index < led_max) {
                    uint16_t keycode = keymap_key_to_keycode(layer, (keypos_t){.col = col, .row = row});

                    if ((keycode >= KC_PSLS && keycode <= KC_PDOT) || (keycode >= KC_MNXT && keycode <= KC_EJCT)) {
                        // Make numpad & media keys purple
                        rgb_matrix_set_color(led_index, RGB_PURPLE);
                    } else if (keycode == QK_BOOT) {
                        // Make bootloader keys red
                        rgb_matrix_set_color(led_index, RGB_RED);
                    } else if (keycode > KC_TRNS) {
                        // Make any other key on the layer blue
                        rgb_matrix_set_color(led_index, RGB_BLUE);
                    } else {
                        rgb_matrix_set_color(led_index, RGB_OFF);
                    }
                }
            }
        }
    }

    return false;
}
