---@type LazySpec
return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    options = {
      show_all_diags_on_cursorline = true,
      show_source = { enabled = true },
    },
    preset = 'powerline',
  },
}
