---@type LazySpec
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module 'indent-blankline'
  ---@type ibl.config
  opts = {
    indent = { tab_char = '╎' },
    scope = {
      show_start = false,
      show_end = false,
    },
  },
}
