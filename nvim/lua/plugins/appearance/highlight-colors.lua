return {
  'brenoprata10/nvim-highlight-colors',
  opts = function()
    return {
      custom_colors = require('utils').map_table_to_list(function(color, name)
        return { label = 'colors.' .. name, color = color }
      end, require('colors').get_colors()),
      enable_named_colors = false,
      excluded_filetypes = { 'lazy' },
    }
  end,
}
