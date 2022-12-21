return {
  'kosayoda/nvim-lightbulb',
  config = function()
    require('nvim-lightbulb').setup({
      sign = { enabled = false },
      autocmd = { enabled = true },
      virtual_text = { enabled = true, hl_mode = 'combine' },
    })
  end,
}
