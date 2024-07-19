local list_item = { add_padding = true, text = '', hl = 'Function' }

---@type table<string, any>
local headings = { shift_width = 2 }
for level, config in ipairs({
  { icon = '󰼏 ', sign = '󰉫' },
  { icon = '󰼐 ', sign = '󰉬' },
  { icon = '󰼑 ', sign = '󰉭' },
  { icon = '󰼒 ', sign = '󰉮' },
  { icon = '󰼓 ', sign = '󰉯' },
  { icon = '󰼔 ', sign = '󰉰' },
}) do
  local level_str = tostring(level)

  headings['heading_' .. level_str] = {
    style = 'icon',
    icon = config.icon,
    hl = 'MarkviewCol' .. level_str,
    sign = config.sign,
    sign_hl = 'MarkviewCol' .. level_str .. 'Fg',
  }
end

return {
  'OXY2DEV/markview.nvim',
  ft = 'markdown',
  keys = { { '<leader>mv', '<cmd>Markview<CR>' } },
  dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
  opts = {
    checkboxes = {
      checked = { text = '󰄵', hl = 'markviewCol4Fg' },
      unchecked = { text = '󰄱', hl = 'markviewCol1Fg' },
      pending = { text = '󰴲', hl = 'MarkviewCol3Fg' },
    },
    code_blocks = {
      style = 'language',
      hl = '@markup.raw.block.markdown',
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
