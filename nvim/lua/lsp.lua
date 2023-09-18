vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = vim.g.border_style,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = vim.g.border_style,
})

local should_enable_hints = false

local function enable_hints_for_buffer(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint(bufnr, should_enable_hints)
      return
    end
  end
end

require('utils').augroup('inlay_hints', {
  {
    'LspAttach',
    callback = function(args)
      enable_hints_for_buffer(args.buf)
    end,
  },
})

require('utils').map('n', '<leader>ih', function()
  should_enable_hints = not should_enable_hints

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    enable_hints_for_buffer(bufnr)
  end
end)
