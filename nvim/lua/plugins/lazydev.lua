return {
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      enabled = function(client)
        if vim.g.lazydev_enabled ~= nil then
          return vim.g.lazydev_enabled
        end

        return client.root_dir ~= vim.fn.expand('~/dotfiles/hammerspoon')
      end,
      library = {
        vim.env.LAZY .. '/luvit-meta/library',
        vim.env.LAZY .. '/catppuccin',
        vim.env.LAZY .. '/nvim-lspconfig',
      },
    },
  },
}
