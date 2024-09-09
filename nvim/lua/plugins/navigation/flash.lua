local function flash_map(configs)
  local mode, key, flash_fn = unpack(configs)

  return {
    key,
    function()
      require('flash')[flash_fn]()
    end,
    desc = 'Flash ' .. flash_fn,
    mode = mode,
  }
end

---@type LazySpec
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@module 'flash'
  ---@type Flash.Config
  opts = {
    search = { multi_window = false },
    jump = { nohlsearch = true },
    modes = {
      char = { enabled = false },
    },
  },
  keys = vim.tbl_map(flash_map, {
    { { 'n', 'x', 'o' }, '<leader><leader>', 'jump' },
    { { 'x', 'o' }, '<leader>.', 'treesitter' },
    { 'o', 'r', 'remote' },
    { { 'o', 'x' }, 'R', 'treesitter_search' },
    { { 'c' }, '<C-s>', 'toggle' },
  }),
}
