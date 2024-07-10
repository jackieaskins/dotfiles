local list_item = { add_padding = true, text = '', hl = 'Function' }

---@type table<string, any>
local headings = { shift_width = 2 }
for level, config in ipairs({
  { icon = '󰼏 ', sign = '󰉫', color = 'red' },
  { icon = '󰼐 ', sign = '󰉬', color = 'orange' },
  { icon = '󰼑 ', sign = '󰉭', color = 'yellow' },
  { icon = '󰼒 ', sign = '󰉮', color = 'green' },
  { icon = '󰼓 ', sign = '󰉯', color = 'blue' },
  { icon = '󰼔 ', sign = '󰉰', color = 'mauve' },
}) do
  headings['heading_' .. tostring(level)] = {
    style = 'icon',
    icon = config.icon,
    hl = 'markview_' .. config.color,
    sign = config.sign,
    sign_hl = 'markview_' .. config.color .. '_fg',
  }
end

return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  keys = { { '<leader>mv', '<cmd>Markview<CR>' } },
  dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
  opts = {
    checkboxes = {
      checked = { text = '󰱒' },
      unchecked = { text = '󰄱' },
    },
    code_blocks = {
      style = 'language',
      hl = 'dark',
      min_width = 60,
      language_direction = 'right',
      sign = true,
    },
    headings = headings,
    inline_codes = { hl = '@markup.raw.markdown_inline' },
    list_items = {
      shift_amount = 2,
      marker_plus = list_item,
      marker_minus = list_item,
      marker_star = list_item,
      marker_dot = { add_padding = true },
    },
  },
}
