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
  },
}
