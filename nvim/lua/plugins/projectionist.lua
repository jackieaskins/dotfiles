return {
  'tpope/vim-projectionist',
  config = function()
    vim.g.projectionist_heuristics = {
      ['package.json'] = {
        ['*.ts'] = {
          alternate = { '{}.test.ts', '{}.spec.ts', '{}.test.tsx', '{}.spec.tsx' },
          type = 'source',
        },
        ['*.spec.ts'] = {
          alternate = '{}.ts',
          type = 'test',
        },
        ['*.test.ts'] = {
          alternate = '{}.ts',
          type = 'test',
        },

        ['*.tsx'] = {
          alternate = { '{}.test.tsx', '{}.spec.tsx' },
          type = 'source',
        },
        ['*.spec.tsx'] = {
          alternate = { '{}.tsx', '{}.ts' },
          type = 'test',
        },
        ['*.test.tsx'] = {
          alternate = { '{}.tsx', '{}.ts' },
          type = 'test',
        },
      },
    }
  end,
}
