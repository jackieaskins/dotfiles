---@module 'gx'

---@class MyConfig
---@field is_personal_machine boolean
---@field additional_server_configs table<string, lspconfig.Config>
---@field border_style string
---@field custom_gx_handlers GxHandler[]

---@class (exact) MyConfig
MY_CONFIG = {
  is_personal_machine = false,
  additional_server_configs = {},
  border_style = 'double',
  custom_gx_handlers = {},
}
