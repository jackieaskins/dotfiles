#!/usr/bin/env bash

#--------------------------------------------------------------------#
#                              General                               #
#--------------------------------------------------------------------#
ICON_SIZE=24
SPACER_SIZE=10

#--------------------------------------------------------------------#
#                               Colors                               #
#--------------------------------------------------------------------#
FG=0xFFC8D0E0
FG_LIGHT=0xFFE5E9F0
BG=0xFF2E3440
GRAY=0xFF646A76
LIGHT_GRAY=0xFF6C7A96
CYAN=0xFF88C0D0
BLUE=0xFF81A1C1
DARK_BLUE=0xFF5E81AC
GREEN=0xFFA3BE8C
LIGHT_GREEN=0xFF8FBCBB
DARK_RED=0xFFBF616A
RED=0xFFD57780
LIGHT_RED=0xFFDE878F
PINK=0xFFE85B7A
DARK_PINK=0xFFE44675
ORANGE=0xFFD08F70
YELLOW=0xFFEBCB8B
PURPLE=0xFFB988B0
LIGHT_PURPLE=0xFFB48EAD

#--------------------------------------------------------------------#
#                               Export                               #
#--------------------------------------------------------------------#
cat << EOF
{
  "ICON_SIZE": "$ICON_SIZE",
  "SPACER_SIZE": "$SPACER_SIZE",

  "COLORS": {
    "FG": "$FG",
    "FG_LIGHT": "$FG_LIGHT",
    "BG": "$BG",
    "GRAY": "$GRAY",
    "LIGHT_GRAY": "$LIGHT_GRAY",
    "CYAN": "$CYAN",
    "BLUE": "$BLUE",
    "DARK_BLUE": "$DARK_BLUE",
    "GREEN": "$GREEN",
    "LIGHT_GREEN": "$LIGHT_GREEN",
    "DARK_RED": "$DARK_RED",
    "RED": "$RED",
    "LIGHT_RED": "$LIGHT_RED",
    "PINK": "$PINK",
    "DARK_PINK": "$DARK_PINK",
    "ORANGE": "$ORANGE",
    "YELLOW": "$YELLOW",
    "PURPLE": "$PURPLE",
    "LIGHT_PURPLE": "$LIGHT_PURPLE"
  }
}
EOF
