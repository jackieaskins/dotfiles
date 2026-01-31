---@type LazySpec
return {
  'brenoprata10/nvim-highlight-colors',
  opts = function()
    local custom_colors = {}

    for name, color in pairs(require('colors').get_colors()) do
      table.insert(custom_colors, { label = 'colors.' .. name, color = color })
      table.insert(custom_colors, { label = '%-%-ctp%-' .. name, color = color })
    end

    return {
      custom_colors = custom_colors,
      enable_named_colors = false,
      excluded_filetypes = { 'lazy' },
    }
  end,
}
