local nvim_lsp = require'nvim_lsp'
local completion = require'completion'
local diagnostic = require'diagnostic'

local custom_attach = function(client)
 completion.on_attach(client)
 diagnostic.on_attach(client)
end

require'nvim_lsp'.tsserver.setup {}

require'nvim_lsp'.tsserver.setup{
  on_attach=custom_attach
}
