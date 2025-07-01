---@module 'gx'

---@class (exact) MyConfig
---@field is_personal_machine boolean
---@field supported_servers string[]
---@field supported_formatters string[]
---@field supported_linters string[]
---@field border_style string
---@field experimental_ui boolean
---@field custom_gx_handlers GxHandler[]
---@field use_ultimate_autopair boolean
MY_CONFIG = {
  is_personal_machine = false,

  supported_servers = {},
  supported_formatters = {},
  supported_linters = {},

  border_style = 'bold',
  experimental_ui = false,

  custom_gx_handlers = {},

  use_ultimate_autopair = false,
}
