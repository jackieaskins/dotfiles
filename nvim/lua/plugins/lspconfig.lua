local servers = require('lsp.servers')
local map = require('utils').map
local typescript = require('typescript')

require('lspconfig.ui.windows').default_options.border = vim.g.border_style

if require('utils').file_exists('~/dotfiles/nvim/lua/custom/lspconfig.lua') then
  require('custom.lspconfig')
end

require('neodev').setup({
  library = {
    plugins = { 'catppuccin', 'nvim-treesitter', 'plenary.nvim' },
  },
})

for server_name, server in pairs(servers) do
  if server_name ~= 'tsserver' then
    local base_config = require('lsp.base_config')()
    local config = server.config and server.config(base_config) or base_config
    require('lspconfig')[server_name].setup(config)
  end
end

if servers.tsserver ~= nil then
  local preferences = { format = { indentSize = 2 } }
  typescript.setup({
    server = {
      on_attach = function(client, bufnr)
        require('lsp.attach')(client, bufnr)

        local function bsk(mode, lhs, rhs, opts)
          map(mode, lhs, rhs, vim.tbl_extend('keep', { buffer = bufnr }, opts or {}))
        end

        -- TODO: Handle single import
        bsk('n', '<leader>oi', typescript.actions.organizeImports, { desc = 'Organize imports' })
        bsk('n', '<leader>ia', function()
          typescript.actions.addMissingImports({ sync = true })
          typescript.actions.organizeImports()
        end, { desc = 'Import all' })
        bsk('n', '<leader>rf', function()
          local filename = vim.fn.expand('%')

          vim.ui.input({ prompt = 'Rename file:', default = filename }, function(new_name)
            if not new_name or #new_name < 1 or filename == new_name then
              return
            end

            typescript.renameFile(filename, new_name)
          end)
        end, { desc = 'Rename file' })
      end,
      settings = {
        javascript = preferences,
        typescript = preferences,
        completions = { completeFunctionCalls = true },
        diagnostics = {
          ignoredCodes = {
            80001, -- File is a CommonJS module; it may be converted to an ES module.
          },
        },
      },
    },
  })
end
