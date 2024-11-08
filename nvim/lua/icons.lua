local M = {}

---Get the icon and color for a given filetype
---@param filetype string
---@return string, string
function M.get_filetype_icon(filetype)
  if MiniIcons then
    local ok, icon, color = pcall(MiniIcons.get, 'filetype', filetype)

    if ok then
      ---@diagnostic disable-next-line: return-type-mismatch
      return icon, color
    end
  end

  return '', 'MiniIconsGrey'
end

---Get a list of lspkind icons
---@return table<string, string>
function M.get_lspkind_icons()
  return {
    Class = '󰠱',
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '󰜢',
    File = '󰈙',
    Folder = '󰉋',
    Function = '󰊕',
    Interface = '',
    Keyword = '󰌋',
    Method = '󰆧',
    Module = '',
    Operator = '',
    Property = '',
    Reference = '󰈇',
    Snippet = '',
    Struct = '󰙅',
    Text = '󰉿',
    TypeParameter = '',
    Unit = '',
    Value = '󰎠',
    Variable = '󰀫',
  }
end

return M
