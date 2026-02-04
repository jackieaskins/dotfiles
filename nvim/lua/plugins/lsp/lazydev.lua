---@type LazySpec
return {
  'folke/lazydev.nvim',
  ft = 'lua',
  config = function()
    require('lazydev').setup({
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
        'catppuccin',
        'nvim-lspconfig',
        'mini.icons',
        'mini.files',
        'snacks.nvim',
      },
    })
  end,
}
