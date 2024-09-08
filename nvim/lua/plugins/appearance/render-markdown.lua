---@type LazySpec
return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  keys = {
    { '<leader>mt', '<cmd>RenderMarkdown toggle<CR>' },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    code = { border = 'thick', width = 'full' },
    heading = {
      signs = { '󰉫', '󰉬', '󰉭', '󰉮', '󰉯', '󰉰' },
    },
    pipe_table = { alignment_indicator = '┅' },
    quote = { repeat_linebreak = true },
    win_options = {
      showbreak = { default = '', rendered = '  ' },
      breakindent = { default = false, rendered = true },
      breakindentopt = { default = '', rendered = '' },
    },
  },
}
