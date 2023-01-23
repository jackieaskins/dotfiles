local M = {
  'jose-elias-alvarez/typescript.nvim',
  dependencies = { 'neovim/nvim-lspconfig' },
  enabled = not vim.g.supported_servers or vim.tbl_contains(vim.g.supported_servers, 'tsserver'),
  config = function()
    if require('lsp.servers').tsserver == nil then
      return
    end

    local typescript = require('typescript')
    local preferences = { format = { indentSize = 2 } }

    local config = vim.tbl_extend('force', require('lsp.base_config')(), {
      on_attach = function(client, bufnr)
        require('lsp.attach')(client, bufnr)

        local function bsk(mode, lhs, rhs, opts)
          require('utils').map(mode, lhs, rhs, vim.tbl_extend('keep', { buffer = bufnr }, opts or {}))
        end

        -- TODO: Handle single import
        bsk('n', '<leader>oi', typescript.actions.organizeImports, { desc = 'Organize imports' })

        bsk('n', '<leader>ia', function()
          typescript.actions.addMissingImports({ sync = true })
          typescript.actions.organizeImports()
        end, { desc = 'Import all' })

        bsk('n', '<leader>rf', function()
          local filename = vim.fn.expand('%')

          vim.ui.input({ prompt = 'Rename file: ', default = filename }, function(new_name)
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
    })

    typescript.setup({ server = config })
  end,
}
return M
