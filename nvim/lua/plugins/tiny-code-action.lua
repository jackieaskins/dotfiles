---@type LazySpec
return {
  'rachartier/tiny-code-action.nvim',
  keys = {
    {
      'gra',
      function()
        require('tiny-code-action').code_action({})
      end,
    },
  },
  dependencies = { 'nvim-lua/plenary.nvim', 'folke/snacks.nvim' },
  init = function()
    -- For some reason this plugin defaults to `DiagnosticWarning` instead of `DiagnosticWarn`
    vim.api.nvim_set_hl(0, 'DiagnosticWarning', { link = 'DiagnosticWarn' })
  end,
  config = function()
    require('tiny-code-action').setup({
      backend = 'delta',
      backend_opts = {
        delta = {
          args = {}, -- Clearing args so line number highlights are correct
        },
      },
      picker = 'snacks',
    })
  end,
}
