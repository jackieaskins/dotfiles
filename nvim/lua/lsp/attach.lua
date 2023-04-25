local lightbulb_namespace = vim.api.nvim_create_namespace('lightbulb')

return function(client, bufnr)
  local function bsk(mode, lhs, rhs, opts)
    local options = { buffer = bufnr }
    if opts then
      options = vim.tbl_extend('force', options, opts)
    end

    require('utils').map(mode, lhs, rhs, options)
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  bsk('n', 'gpi', '<cmd>Telescope lsp_implementations jump_type=never<CR>')
  bsk('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  bsk('n', 'gpd', '<cmd>Telescope lsp_definitions jump_type=never<CR>')
  bsk('n', 'gr', '<cmd>Telescope lsp_references include_declaration=false<CR>')
  bsk('n', 'gpr', '<cmd>Telescope lsp_references include_declaration=false jump_type=never<CR>')

  bsk('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
  bsk({ 'i', 'n' }, '<C-S>', vim.lsp.buf.signature_help, { desc = 'vim.lsp.buf.signature_help' })

  bsk('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'vim.lsp.buf.rename' })
  bsk('n', '<leader>bf', function()
    vim.lsp.buf.format({ async = true })
  end, { desc = 'vim.lsp.buf.format' })

  bsk('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.code_action' })
  bsk('x', '<leader>ca', vim.lsp.buf.code_action, { desc = 'vim.lsp.buf.range_code_action' })

  bsk('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
  bsk('n', '<leader>sd', '<cmd>Telescope lsp_document_symbols symbols=constant,function,method<CR>')
  bsk('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'vim.lsp.buf.add_workspace_folder' })
  bsk('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'vim.lsp.buf.remove_workspace_folder' })
  bsk('n', '<leader>wl', '<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>')

  if client.supports_method('textDocument/codeAction') then
    require('utils').augroup('lightbulb', {
      {
        { 'CursorHold', 'CursorHoldI' },
        callback = function()
          local params = vim.lsp.util.make_range_params()
          params.context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, nil, nil, nil) }

          vim.lsp.buf_request_all(bufnr, 'textDocument/codeAction', params, function(response)
            vim.api.nvim_buf_clear_namespace(bufnr, lightbulb_namespace, 0, -1) -- 0, -1 clears entire buffer

            local has_code_actions = #vim.tbl_filter(function(resp)
              return resp.result and #resp.result > 0
            end, response) > 0

            if has_code_actions then
              vim.api.nvim_buf_set_extmark(bufnr, lightbulb_namespace, params.range.start.line, -1, {
                virt_text = { { '💡' } },
                hl_mode = 'combine',
              })
            end
          end)
        end,
        buffer = bufnr,
      },
    })
  end
end
