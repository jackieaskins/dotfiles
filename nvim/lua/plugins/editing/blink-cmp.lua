---@type LazySpec
return {
  'saghen/blink.cmp',
  build = 'nix run .#build-plugin',
  enabled = MY_CONFIG.completion_source == 'blink',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    accept = { auto_brackets = { enabled = true } },
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      accept = '<C-y>',
      snippet_forward = '<C-j>',
      snippet_backward = '<C-k>',
    },
    nerd_font_variant = 'normal',
    windows = {
      autocomplete = { border = MY_CONFIG.border_style },
      documentation = { border = MY_CONFIG.border_style },
      signature_help = { border = MY_CONFIG.border_style },
    },
  },
}
