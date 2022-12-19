local servers = {
  cssls = { install = { 'npm', 'vscode-langservers-extracted' } },
  eslint = {
    -- config {{{
    config = function(config)
      local function publish_diagnostics_handler(err, result, ctx, conf)
        for _, diagnostic in ipairs(result.diagnostics) do
          diagnostic.severity = 4
        end

        return vim.lsp.handlers['textDocument/publishDiagnostics'](err, result, ctx, conf)
      end

      config.root_dir = require('lspconfig').util.root_pattern('./node_modules/eslint')
      config.on_attach = function(client, bufnr)
        require('lsp.attach')(client, bufnr)

        require('utils').map('n', '<leader>ef', vim.cmd.EslintFixAll)
      end
      config.handlers = {
        ['textDocument/publishDiagnostics'] = publish_diagnostics_handler,
      }

      return config
    end,
    -- }}}
    install = { 'npm', 'vscode-langservers-extracted' },
  },
  gdscript = { install = { 'brew', 'godot' } },
  gopls = { install = { 'go', 'golang.org/x/tools/gopls@latest' } },
  graphql = {
    -- config {{{
    config = function(config)
      config.filetypes = { 'graphql' }
      return config
    end,
    -- }}}
    install = { 'npm', 'graphql-language-service-cli' },
  },
  html = { install = { 'npm', 'vscode-langservers-extracted' } },
  jdtls = {
    -- config {{{
    config = function(config)
      config.cmd = { 'run_jdtls.sh' }
      config.init_options = {
        extendedClientCapabilities = {
          advancedExtractRefactoringSupport = true,
          advancedOrganizeImportsSupport = true,
          classFileContentsSupport = true,
          generateToStringPromptSupport = true,
          generateConstructorsPromptSupport = true,
          generateDelegateMethodsPromptSupport = true,
          hashCodeEqualsPromptSupport = true,
          inferSelectionSupport = { 'extractMethod', 'extractVariable' },
          moveRefactoringSupport = true,
          overrideMethodsPromptSupport = true,
        },
      }

      return config
    end,
    -- }}}
    -- install {{{
    install = function(servers_dir)
      local install_dir = servers_dir .. '/eclipse.jdt.ls'
      local zip_file = 'jdt-language-server-latest.tar.gz'

      return {
        'rm -rf ' .. install_dir,
        'mkdir ' .. install_dir,
        'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
        'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
        'rm ' .. zip_file,
        'cd ' .. install_dir,
        'wget https://projectlombok.org/downloads/lombok.jar',
      }
    end,
    -- }}}
  },
  jsonls = {
    -- config {{{
    config = function(config)
      config.settings = {
        json = {
          -- https://www.schemastore.org
          schemas = {
            {
              fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
              url = 'https://json.schemastore.org/babelrc.json',
            },
            {
              fileMatch = { '.eslintrc', '.eslintrc.json' },
              url = 'https://json.schemastore.org/eslintrc.json',
            },
            {
              fileMatch = { 'package.json' },
              url = 'https://json.schemastore.org/package.json',
            },
            {
              fileMatch = { 'jsconfig*.json' },
              url = 'https://json.schemastore.org/jsconfig.json',
            },
            {
              fileMatch = { 'tsconfig*.json' },
              url = 'https://json.schemastore.org/tsconfig.json',
            },
          },
        },
      }

      return config
    end,
    -- }}}
    install = { 'npm', 'vscode-langservers-extracted' },
  },
  pyright = { install = { 'npm', 'pyright' } },
  solargraph = { install = { 'gem', 'solargraph' } },
  sumneko_lua = {
    -- config {{{
    config = function(config)
      config.settings = {
        Lua = {
          completion = { keywordSnippet = 'Replace', callSnippet = 'Replace' },
          diagnostics = {
            globals = { 'hs', 'packer_plugins', 'vim' },
          },
          workspace = {
            checkThirdParty = false,
            library = {
              '/Applications/Hammerspoon.app/Contents/Resources/extensions/hs',
              '~/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
            },
          },
        },
      }

      return config
    end,
    -- }}}
    install = { 'brew', 'lua-language-server' },
  },
  svelte = {
    -- config {{{
    config = function(config)
      config.init_options = {
        configuration = {
          svelte = {
            plugin = {
              svelte = {
                defaultScriptLanguage = 'ts',
              },
            },
          },
        },
      }
      return config
    end,
    -- }}}
    install = { 'npm', 'svelte-language-server' },
  },
  tailwindcss = {
    -- config {{{
    config = function(config)
      config.on_attach = function(...)
        require('lsp.attach')(...)

        require('packer').loader('tailiscope.nvim')
        require('telescope').load_extension('tailiscope')
        require('utils').map('n', '<leader>tw', '<cmd>Telescope tailiscope<CR>')
      end
      config.root_dir = require('lspconfig').util.root_pattern(
        'tailwind.config.js',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.ts',
        'node_modules/tailwindcss'
      )

      return config
    end,
    -- }}}
    install = { 'npm', '@tailwindcss/language-server' },
  },
  tsserver = { install = { 'npm', 'typescript typescript-language-server' } },
  vimls = { install = { 'npm', 'vim-language-server' } },
  yamlls = { install = { 'npm', 'yaml-language-server' } },
}

local all_servers = vim.tbl_extend('force', servers, vim.g.additional_server_commands or {})

local supported_servers = {}
if vim.g.supported_servers then
  for _, server_name in ipairs(vim.g.supported_servers) do
    if all_servers[server_name] then
      supported_servers[server_name] = all_servers[server_name]
    end
  end
else
  supported_servers = all_servers
end

return supported_servers

-- vim:foldmethod=marker foldlevel=0
