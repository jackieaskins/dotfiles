local lightbulb_ns = vim.api.nvim_create_namespace('lightbulb')

local function set_lightbulb_extmark(bufnr, line, character)
  vim.b[bufnr].lightbulb_extmark = vim.api.nvim_buf_set_extmark(bufnr, lightbulb_ns, line, character, {
    id = vim.b[bufnr].lightbulb_extmark,
    virt_text_pos = 'eol',
    virt_text = { { '💡' } },
    hl_mode = 'combine',
  })
end

local M = {}

function M.clear(bufnr)
  vim.api.nvim_buf_clear_namespace(bufnr, lightbulb_ns, 0, -1)
end

function M.update(bufnr)
  if vim.b[bufnr].lightbulb_cancel then
    vim.b[bufnr].lightbulb_cancel()
  end

  local winid = vim.fn.bufwinid(bufnr)
  local first_client = vim.lsp.get_clients({ bufnr = bufnr })[1]
  local params = vim.tbl_extend(
    'force',
    vim.lsp.util.make_range_params(winid, first_client.offset_encoding),
    { diagnostics = vim.diagnostic.get(bufnr), triggerKind = 1 }
  )

  vim.b[bufnr].lightbulb_cancel = vim.lsp.buf_request_all(
    bufnr,
    vim.lsp.protocol.Methods.textDocument_codeAction,
    params,
    function(results)
      for _, result in pairs(results) do
        if result.result and #result.result > 0 then
          set_lightbulb_extmark(bufnr, params.range.start.line, -1)
          return
        end
      end

      M.clear(bufnr)
    end
  )
end

return M
