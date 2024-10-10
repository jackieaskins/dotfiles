---@diagnostic disable: missing-fields

---@type LazySpec
return {
  'saghen/blink.cmp',
  version = 'v0.*',
  enabled = MY_CONFIG.completion_source == 'blink',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    accept = { auto_brackets = { enabled = true } },
    highlight = { use_nvim_cmp_as_default = true },
    keymap = {
      accept = '<C-y>',
      select_next = '<C-n>',
      select_prev = '<C-p>',

      snippet_forward = '<C-j>',
      snippet_backward = '<C-k>',
    },
    nerd_font_variant = 'normal',
    sources = {
      providers = {
        {
          { 'blink.cmp.sources.lsp' },
          { 'blink.cmp.sources.path' },
          {
            'blink.cmp.sources.snippets',
            score_offset = -3,
            opts = {
              search_paths = { vim.fn.expand('~/dotfiles/vim-common') },
            },
          },
        },
        {
          { 'blink.cmp.sources.buffer' },
        },
      },
    },
    trigger = { signature_help = { enabled = true } },
  },
}
