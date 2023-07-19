return {
  install = { 'npm', 'vscode-langservers-extracted' },
  config = function(config)
    config.settings = {
      html = { autoClosingTags = true },
    }

    config.on_attach = function(client, bufnr)
      local bsk = require('utils').buffer_map(bufnr)

      local function auto_insert(key)
        return function()
          vim.schedule(function()
            client.request(
              'html/autoInsert',
              vim.tbl_extend('force', vim.lsp.util.make_position_params(), { kind = 'autoClose' }),
              function(_, result)
                if result then
                  require('luasnip').lsp_expand(result)
                end
              end,
              bufnr
            )
          end)

          return key
        end
      end

      bsk('i', '>', auto_insert('>'), { expr = true })
      bsk('i', '/', auto_insert('/'), { expr = true })
    end

    return config
  end,
}
