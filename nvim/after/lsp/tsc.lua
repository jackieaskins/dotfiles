local utils = require('utils')

---@type vim.lsp.Config
return {
  capabilities = {
    experimental = { hoverVerbosityLevel = true },
    settings = { ['js/ts'] = { maximumHoverLength = 5000 } },
  },
  on_attach = function(client, bufnr)
    local bsk = utils.buffer_map(bufnr)

    bsk('n', '<leader>oi', function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { 'source.organizeImports' },
          diagnostics = {},
        },
      })
    end)

    if
      vim.tbl_contains({
        'javascript',
        'javascriptreact',
        'typescriptreact',
      }, vim.bo[bufnr].filetype)
    then
      require('lsp.utils').setup_vs_code_auto_insert(client, bufnr, '>')
    end
  end,
}
