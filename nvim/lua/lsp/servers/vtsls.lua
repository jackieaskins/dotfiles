return {
  install = { 'npm', '@vtsls/language-server' },
  config = function(config)
    config.on_attach = function(_, bufnr)
      local vtsls = require('vtsls')
      local function bsk(mode, lhs, rhs, opts)
        require('utils').map(mode, lhs, rhs, vim.tbl_extend('keep', { buffer = bufnr }, opts or {}))
      end

      bsk('n', '<leader>oi', '<cmd>VtsExec organize_imports<CR>', { desc = 'Organize imports' })
      bsk('n', '<leader>iA', '<cmd>VtsExec add_missing_imports<CR>', { desc = 'Add missing imports' })
      bsk('n', '<leader>ia', function()
        vtsls.commands.add_missing_imports(bufnr, function()
          vtsls.commands.sort_imports(bufnr)
        end)
      end, { desc = 'Add and sort missing imports' })
    end

    local ih = require('lsp.utils').typescript_inlay_hint_settings
    local lang_settings = {
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = ih.includeInlayEnumMemberValueHints },
        functionLikeReturnTypes = { enabled = ih.includeInlayFunctionLikeReturnTypeHints },
        parameterNames = {
          enabled = ih.includeInlayParameterNameHints,
          suppressWhenArgumentMatchesName = not ih.includeInlayParameterNameHintsWhenArgumentMatchesName,
        },
        parameterTypes = { enabled = ih.includeInlayFunctionParameterTypeHints },
        propertyDeclarationTypes = { enabled = ih.includeInlayPropertyDeclarationTypeHints },
        variableTypes = {
          enabled = ih.includeInlayVariableTypeHints,
          suppressWhenTypeMatchesName = not ih.includeInlayVariableTypeHintsWhenTypeMatchesName,
        },
      },
      tsserver = {
        experimental = { enableProjectDiagnostics = true },
      },
    }

    local vtsls_settings = {
      format = { indentSize = 2 },
    }

    config.settings = {
      javascript = lang_settings,
      typescript = lang_settings,
      vtsls = { javascript = vtsls_settings, typescript = vtsls_settings },
    }

    return config
  end,
}
