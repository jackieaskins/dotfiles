---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = 'VeryLazy',
  init = function()
    -- Use bash parser for ZSH files
    vim.treesitter.language.register('bash', 'zsh')
  end,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      auto_install = true,
      ensure_installed = {
        'bash',
        'comment',
        'git_rebase',
        'gitcommit',
        'markdown_inline',
        'regex',
      },
      highlight = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          node_decremental = '<BS>',
        },
      },
      indent = { enable = true },
    })
  end,
}
