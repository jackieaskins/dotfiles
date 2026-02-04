---@type LazySpec
return {
  'kosayoda/nvim-lightbulb',
  config = function()
    require('nvim-lightbulb').setup({
      autocmd = { enabled = true },
      sign = { enabled = false },
      virtual_text = { enabled = true, hl = 'LightBulbVirtText' },
    })
  end,
}
