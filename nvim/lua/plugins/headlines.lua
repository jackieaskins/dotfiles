return {
  'lukas-reineke/headlines.nvim',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = 'markdown',
  opts = {
    markdown = {
      headline_highlights = {
        'Headline1',
        'Headline2',
        'Headline3',
        'Headline4',
        'Headline5',
        'Headline6',
      },
    },
  },
}
