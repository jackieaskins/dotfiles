return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  main = 'render-markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  keys = { { '<leader>mt', '<cmd>RenderMarkdown toggle<CR>' } },
  opts = {
    code = { border = 'thick' },
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
