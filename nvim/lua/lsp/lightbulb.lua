local lightbulb_ns = vim.api.nvim_create_namespace('lightbulb')

local function set_lightbulb_extmark(bufnr, line, character)
  vim.b.lightbulb_extmark = vim.api.nvim_buf_set_extmark(bufnr, lightbulb_ns, line, character, {
    id = vim.b.lightbulb_extmark,
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
  if vim.b.lightbulb_cancel then
    vim.b.lightbulb_cancel()
  end

  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.diagnostic.get(0), triggerKind = 1 }

  local range_start = params.range.start

  vim.b.lightbulb_cancel = vim.lsp.buf_request_all(
    bufnr,
    vim.lsp.protocol.Methods.textDocument_codeAction,
    params,
    function(results)
      for _, result in pairs(results) do
        if result.result and #result.result > 0 then
          set_lightbulb_extmark(bufnr, range_start.line, range_start.character)
          return
        end
      end

      M.clear(bufnr)
    end
  )
end

return M
