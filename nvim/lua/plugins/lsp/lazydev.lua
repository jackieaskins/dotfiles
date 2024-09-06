---@type LazySpec
return {
  { 'Bilal2453/luvit-meta', lazy = true },
  ---@module 'lazydev'
  ---@type lazydev.Config
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      enabled = function(root_dir)
        if vim.g.lazydev_enabled ~= nil then
          return vim.g.lazydev_enabled
        end

        return not vim.tbl_contains(
          vim.tbl_map(function(path)
            return vim.fn.expand(path)
          end, {
            '~/dotfiles/hammerspoon',
            '~/dotfiles/wezterm',
          }),
          root_dir
        )
      end,
      library = {
        'lazy.nvim',
        'luvit-meta/library/uv.lua',
        'catppuccin',
        'nvim-lspconfig',
        'mini.icons',
      },
    },
  },
}
