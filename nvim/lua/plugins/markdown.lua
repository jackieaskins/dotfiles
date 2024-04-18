return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = 'markdown',
  opts = {
    highlights = {
      heading = {
        backgrounds = {
          'markdownH1',
          'markdownH2',
          'markdownH3',
          'markdownH4',
          'markdownH5',
          'markdownH6',
        },
      },
    },
    render_modes = { 'n', 'c', 'v', 'V' },
  },
}
