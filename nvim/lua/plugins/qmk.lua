return {
  'codethread/qmk.nvim',
  opts = {
    name = 'LAYOUT_single_arc_num',
    layout = {
      'x x x x x x _ _ _ x x x x x x',
      'x x x x x x _ _ _ x x x x x x',
      'x x x x x x _ _ _ x x x x x x',
      'x x x x x x _ _ _ x x x x x x',
      'x x x x x x x _ x x x x x x x',
    },
    comment_preview = {
      keymap_overrides = {
        KC_MEH = 'meh',
        KC_HYPR = 'hyper',
      },
    },
  },
}
