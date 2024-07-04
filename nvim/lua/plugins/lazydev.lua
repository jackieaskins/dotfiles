return {
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      enabled = function(root_dir)
        if vim.g.lazydev_enabled ~= nil then
          return vim.g.lazydev_enabled
        end

        return root_dir ~= vim.fn.expand('~/dotfiles/hammerspoon')
      end,
      library = {
        'luvit-meta/library/uv.lua',
        'catppuccin',
        'nvim-lspconfig',
        'mini.icons',
      },
    },
  },
}
