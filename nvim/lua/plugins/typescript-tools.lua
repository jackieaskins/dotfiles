local lsp_utils = require('lsp.utils')

return {
  'pmizio/typescript-tools.nvim',
  enabled = lsp_utils.is_server_supported('typescript-tools'),
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    require('typescript-tools').setup({
      settings = {
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        },
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = require('typescript-tools.api').filter_diagnostics({
          80001, -- File is a CommonJS module; it may be converted to an ES module.
        }),
      },
      on_attach = function(_, bufnr)
        local bsk = require('utils').buffer_map(bufnr)

        bsk('n', '<leader>oi', '<cmd>TSToolsOrganizeImports<CR>')
        bsk('n', '<leader>ia', '<cmd>TSToolsAddMissingImports<CR>')
      end,
    })
  end,
}
