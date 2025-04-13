---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  config = function()
    local lspconfig = require('lspconfig')

    -- eslint doesn't support the new format yet
    lspconfig.eslint.setup({
      root_dir = lspconfig.util.root_pattern(
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
    })

    for server_name, server in pairs(require('lsp.utils').get_supported_servers()) do
      if not server.skip_lspconfig then
        vim.lsp.enable(server_name)
      end
    end
  end,
}
