---@type boolean
vim.g.is_personal_machine = false

---@class (exact) AdditionalServer
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

---@type string[]
vim.g.border_style = { '╔', '═', '╗', '║', '╝', '═', '╚', '║' }
