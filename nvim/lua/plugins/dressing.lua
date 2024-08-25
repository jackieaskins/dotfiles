return {
  'stevearc/dressing.nvim',
  opts = {
    input = {
      border = vim.g.border_style,
      override = function(conf)
        -- Make input bigger when in a small window, added for nvim-tree renames
        if vim.api.nvim_win_get_width(0) <= 40 then
          conf.width = 50
        end

        return conf
      end,
    },
  },
}
