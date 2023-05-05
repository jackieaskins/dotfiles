/* Copyright 2023 Cyboard LLC (@Cyboard-DigitalTailor)
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#pragma once

#include "quantum.h"

#define LAYOUT_singlearc_number_row( \
  r5c6, r5c5, r5c4, r5c3, r5c2, r5c1,                 r12c8, r12c9, r12c10, r12c11, r12c12, r12c13, \
  r4c6, r4c5, r4c4, r4c3, r4c2, r4c1,                 r11c8, r11c9, r11c10, r11c11, r11c12, r11c13, \
  r3c6, r3c5, r3c4, r3c3, r3c2, r3c1,                 r10c8, r10c9, r10c10, r10c11, r10c12, r10c13, \
  r2c6, r2c5, r2c4, r2c3, r2c2, r2c1,                 r9c8, r9c9, r9c10, r9c11, r9c12, r9c13, \
  r1c6, r1c5, r1c4, r1c3, r1c2, r1c1, r1c0,     r8c7, r8c8, r8c9, r8c10, r8c11, r8c12, r8c13 \
) \
{ \
    { KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO }, \
    { r1c0, r1c1, r1c2, r1c3, r1c4, r1c5, r1c6  }, \
    { KC_NO, r2c1, r2c2, r2c3, r2c4, r2c5, r2c6 }, \
    { KC_NO, r3c1, r3c2, r3c3, r3c4, r3c5, r3c6 }, \
    { KC_NO, r4c1, r4c2, r4c3, r4c4, r4c5, r4c6 }, \
    { KC_NO, r5c1, r5c2, r5c3, r5c4, r5c5, r5c6 }, \
    { KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO }, \
\
    { KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO }, \
    { r8c7, r8c8, r8c9, r8c10, r8c11, r8c12, r8c13 }, \
    { KC_NO, r9c8, r9c9, r9c10, r9c11, r9c12, r9c13 }, \
    { KC_NO, r10c8, r10c9, r10c10, r10c11, r10c12, r10c13 }, \
    { KC_NO, r11c8, r11c9, r11c10, r11c11, r11c12, r11c13 }, \
    { KC_NO, r12c8, r12c9, r12c10, r12c11, r12c12, r12c13 }, \
    { KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO, KC_NO } \
}
