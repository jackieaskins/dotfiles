---@type boolean
vim.g.is_personal_machine = false

---@class AdditionalServer
---@field lspconfig lspconfig.Config
---@field server LspServer

---@type table<string, AdditionalServer>
vim.g.additional_servers = {}
---@type string[]
vim.g.supported_servers = {}

---@type string[]
vim.g.supported_debuggers = {}
---@type string[]
vim.g.supported_formatters = {}
---@type string[]
vim.g.supported_linters = {}

---@type GxMatcher[]
vim.g.custom_matchers = {}

---@type string[]
vim.g.border_style = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' }

---@type 'quicktest' | 'neotest'
vim.g.test_plugin = 'neotest'
