-- https://github.com/tpope/vim-projectionist

vim.g.projectionist_heuristics = {
  ['package.json'] = {
    ['*.ts'] = {
      alternate = '{}.test.ts',
      type = 'source',
    },
    ['*.test.ts'] = {
      alternate = '{}.ts',
      type = 'test',
    },
    ['*.js'] = {
      alternate = '{}.test.js',
      type = 'source',
    },
    ['*.test.js'] = {
      alternate = '{}.js',
      type = 'test',
    },
  },
}
