---@class (exact) AdditionalServer
---@field lspconfig lspconfig.Config
---@field server LspServer

---@module 'gx'

---@class (exact) MyConfig
---@field is_personal_machine boolean
---@field additional_servers table<string, AdditionalServer>
---@field supported_servers string[]
---@field supported_debuggers string[]
---@field supported_formatters string[]
---@field supported_linters string[]
---@field border_style string
---@field custom_gx_handlers GxHandler[]

---@class MyConfig
MY_CONFIG = {
  is_personal_machine = false,
  additional_servers = {},
  supported_servers = {},
  supported_debuggers = {},
  supported_formatters = {},
  supported_linters = {},
  border_style = 'rounded',
  custom_gx_handlers = {},
}
