local lspconfig = require('lspconfig')

---@class LspServer
---@field config? fun(): lspconfig.Config
---@field display? string
---@field skip_lspconfig? boolean

---@type table<string, LspServer>
local servers = {}

vim.g.markdown_fenced_languages = { 'ts=typescript' }
servers.denols = {
  config = function()
    return {
      root_dir = lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
    }
  end,
}

servers.emmet_language_server = { display = 'emmet-ls' }

servers.eslint = {
  config = function()
    return {
      root_dir = require('lspconfig').util.root_pattern(
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'eslint.config.js',
        './node_modules/eslint'
      ),
      on_attach = function(_, bufnr)
        require('utils').buffer_map(bufnr)('n', '<leader>ef', vim.cmd.EslintFixAll)
      end,
      handlers = {
        ['textDocument/diagnostic'] = function(err, result, ctx)
          if result and result.items then
            for _, item in ipairs(result.items) do
              item.severity = 4
            end
          end

          return vim.lsp.handlers['textDocument/diagnostic'](err, result, ctx)
        end,
      },
    }
  end,
}

servers.graphql = {
  config = function()
    return {
      filetypes = { 'graphql' },
    }
  end,
}

servers.html = {
  config = function()
    return {
      on_attach = function(client, bufnr)
        require('lsp.utils').setup_auto_close_tag(client, bufnr, 'html/autoInsert')
      end,
    }
  end,
}

servers.jdtls = { skip_lspconfig = true }

servers.jsonls = {
  config = function()
    return {
      settings = {
        json = {
          schemas = require('schemastore').json.schemas(), -- https://www.schemastore.org
          validate = { enable = true },
        },
      },
    }
  end,
}

servers.lua_ls = {
  config = function()
    return {
      settings = {
        Lua = {
          completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
          hint = { arrayIndex = 'Disable', enable = true },
          workspace = { checkThirdParty = false },
        },
      },
    }
  end,
}

servers.nixd = {
  config = function()
    local flake_path = vim.fn.expand('~/dotfiles/nix')
    local flake = '(builtins.getFlake "' .. flake_path .. '")'
    local hostname = vim.fn.system('hostname -s')

    return {
      settings = {
        nixd = {
          options = {
            home_manager = {
              expr = flake .. '.homeConfigurations.' .. vim.env.USER .. '.options',
            },
            nix_darwin = {
              expr = flake .. '.darwinConfigurations.' .. hostname .. '.options',
            },
          },
        },
      },
    }
  end,
}

servers.svelte = {
  config = function()
    return {
      init_options = {
        configuration = {
          svelte = {
            plugin = {
              svelte = { defaultScriptLanguage = 'ts' },
            },
          },
        },
      },
      on_attach = function(client, bufnr)
        require('lsp.utils').setup_auto_close_tag(client, bufnr, 'html/tag')

        require('utils').augroup('svelte_tsjschanges', {
          {
            { 'BufWritePost' },
            pattern = { '*.js', '*.ts' },
            callback = function(args)
              client:notify('$/onDidChangeTsOrJsFile', { uri = args.match })
            end,
          },
        })
      end,
    }
  end,
}

servers.tailwindcss = {
  display = 'tailwind',
  config = function()
    local capabilities = require('lsp.capabilities')()
    capabilities.textDocument.colorProvider = { dynamicRegistration = true }

    return {
      root_dir = lspconfig.util.root_pattern('tailwind.config.*', 'node_modules/tailwindcss'),
      capabilities = capabilities,
    }
  end,
}

servers['typescript-tools'] = { display = 'ts-tools', skip_lspconfig = true }

return servers
