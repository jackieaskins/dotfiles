---@type LazySpec
return {
  'PriceHiller/nvim-treesitter-endwise',
  branch = 'fix/iter-matches',
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      endwise = { enable = true },
    })
  end,
}
