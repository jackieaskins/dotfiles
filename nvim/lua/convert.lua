local M = {}

local convert_items = {
  {
    text = 'Toggle arrow function braces',
    cb = require('convert.toggle_arrow_function_braces'),
  },
  {
    text = 'Toggle string interpolation',
    cb = require('convert.toggle_string_interpolation'),
  },
}

function M.show_convert_select()
  vim.ui.select(convert_items, {
    prompt = 'Convert',
    format_item = function(item)
      return item.text
    end,
  }, function(item)
    if item then
      item.cb()
    end
  end)
end

return M
