# Build Options
SLEEP_LED_ENABLE = no       # Breathing sleep LED during USB suspend

RGB_MATRIX_SUPPORTED = yes  # RGB matrix is supported and enabled by default
RGBLIGHT_SUPPORTED = yes    # RGB underglow is supported, but not enabled by default
RGB_MATRIX_ENABLE = yes     # Enable keyboard RGB matrix (do not use together with RGBLIGHT_ENABLE)
RGB_MATRIX_DRIVER = WS2812  # RGB matrix driver support

SERIAL_DRIVER = vendor
WS2812_DRIVER = vendor

# https://github.com/qmk/qmk_firmware/issues/19593#issuecomment-1387476045
NO_USB_STARTUP_CHECK = yes
