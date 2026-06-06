local utils = require('utils')

---@type vim.lsp.Config
return {
  -- Fix for tsgo issue described in https://github.com/neovim/neovim/issues/37204
  handlers = {
    ['client/registerCapability'] = function(err, result, ctx)
      -- Filter out watchers with bundled:// glob patterns
      for _, reg in ipairs(result.registrations or {}) do
        if reg.method == 'workspace/didChangeWatchedFiles' and reg.registerOptions then
          local watchers = reg.registerOptions.watchers or {}

          reg.registerOptions.watchers = vim.tbl_filter(function(w)
            local glob_pat = w.globPattern

            if glob_pat and type(glob_pat) == 'string' then
              return not glob_pat:match('^bundled:///')
            end

            return true
          end, watchers)
        end
      end

      -- Call default handler with filtered registrations
      return vim.lsp.handlers['client/registerCapability'](err, result, ctx)
    end,
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
