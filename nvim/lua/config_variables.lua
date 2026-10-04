---@module 'gx'

---@class (exact) MyConfig
---@field is_personal_machine boolean
---@field border_style string
---@field custom_gx_handlers GxHandler[]
MY_CONFIG = {
  is_personal_machine = false,
  border_style = vim.env.BORDER_STYLE,
  custom_gx_handlers = {},
}
