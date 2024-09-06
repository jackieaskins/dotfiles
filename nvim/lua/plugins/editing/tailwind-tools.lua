---@type LazySpec
return {
  'luckasRanarison/tailwind-tools.nvim',
  build = ':UpdateRemotePlugins',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  ft = {
    'css',
    'hmtl',
    'javascript',
    'javascriptreact',
    'svelte',
    'typescriptreact',
    'tsx',
  },
  ---@module 'tailwind-tools'
  ---@type TailwindTools.Option
  opts = {
    -- disabling because nvim-highlight-colors does lsp highlighting that I can't turn off
    document_color = { enabled = false },
    server = { override = false },
  },
}
