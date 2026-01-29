---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':silent! TSUpdate',
  init = function()
    -- Use bash parser for ZSH files
    vim.treesitter.language.register('bash', 'zsh')
  end,
  config = function()
    local ok, treesitter = pcall(require, 'nvim-treesitter')

    if ok then
      -- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
      treesitter.install({
        'bash',
        'comment',
        'commonlisp',
        'css',
        'csv',
        'diff',
        'ecma',
        'editorconfig',
        'embedded_template',
        'git_config',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'graphql',
        'html',
        'html_tags',
        'java',
        'javadoc',
        'javascript',
        'jq',
        'jsdoc',
        'json',
        'json5',
        'jsx',
        'lua',
        'luadoc',
        'luap',
        'make',
        'markdown',
        'markdown_inline',
        'nix',
        'perl',
        'python',
        'query',
        'regex',
        'requirements',
        'ruby',
        'scss',
        'sql',
        'ssh_config',
        'styled',
        'superhtml',
        'svelte',
        'swift',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      })
    end
  end,
}
