---@type LazySpec
return {
  'pmizio/typescript-tools.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = function()
    return {
      settings = {
        complete_function_calls = false,
        include_completions_with_insert_text = true,
        -- Disable jsx_close_tag in favor of my own handling, default handling breaks emmet completion
        jsx_close_tag = { enable = false },
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
        tsserver_plugins = {
          '@styled/typescript-styled-plugin',
          'typescript-svelte-plugin',
        },
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = require('typescript-tools.api').filter_diagnostics({
          80001, -- File is a CommonJS module; it may be converted to an ES module.
        }),
      },
      on_attach = function(client, bufnr)
        local bsk = require('utils').buffer_map(bufnr)
        local winid = vim.fn.bufwinid(bufnr)

        bsk('n', '<leader>oi', '<cmd>TSToolsOrganizeImports<CR>')
        bsk('n', '<leader>ia', '<cmd>TSToolsAddMissingImports<CR>')
        bsk('n', '<leader>ri', '<cmd>TSToolsRemoveUnusedImports<CR>')

        if
          vim.tbl_contains({
            'javascript',
            'javascriptreact',
            'typescriptreact',
          }, vim.bo.filetype)
        then
          bsk('i', '>', function()
            vim.schedule(function()
              require('typescript-tools.api').jsx_close_tag(
                bufnr,
                vim.lsp.util.make_position_params(winid, client.offset_encoding),
                function() end,
                nil
              )
            end)

            return '>'
          end, { expr = true })
        end
      end,
      root_dir = require('lspconfig.util').root_pattern('package.json'),
      single_file_support = false,
    }
  end,
}
