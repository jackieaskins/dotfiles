---@module 'gx'

---@class (exact) MyConfig
---@field is_personal_machine boolean
---@field additional_server_configs table<string, lspconfig.Config>
---@field supported_servers string[]
---@field border_style string
---@field custom_gx_handlers GxHandler[]
---@field completion_source 'blink' | 'cmp'

---@class MyConfig
MY_CONFIG = {
  is_personal_machine = false,
  additional_server_configs = {},
  supported_servers = {
    'clangd',
    'cssls',
    'denols',
    'emmet_language_server',
    'eslint',
    'gopls',
    'graphql',
    'html',
    'jsonls',
    'lua_ls',
    'nixd',
    'svelte',
    'tailwindcss',
    'taplo',
    'typescript-tools',
    'vimls',
    'yamlls',
  },
  border_style = 'double',
  custom_gx_handlers = {},
  completion_source = 'cmp',
}
