---@type LazySpec
return {
  'kosayoda/nvim-lightbulb',
  opts = {
    autocmd = { enabled = true },
    sign = { enabled = false },
    virtual_text = { enabled = true, hl = 'LightBulbVirtText' },
  },
}
