return {
  'MeanderingProgrammer/markdown.nvim',
  main = 'render-markdown',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' },
  keys = { { '<leader>mt', '<cmd>RenderMarkdown toggle<CR>' } },
  opts = {
    code = {
      left_pad = 2,
      right_pad = 2,
      border = 'thick',
      width = 'block',
    },
    heading = {
      signs = { '󰉫', '󰉬', '󰉭', '󰉮', '󰉯', '󰉰' },
    },
  },
}
