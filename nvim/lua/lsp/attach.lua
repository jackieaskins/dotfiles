return function(client, bufnr)
  local utils = require('utils')
  local augroup_buf, map = utils.augroup_buf, utils.map

  local function bsk(mode, lhs, rhs)
    map(mode, lhs, rhs, { buffer = bufnr })
  end
  local function bso(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  if client.supports_method('textDocument/codeAction') then
    augroup_buf('lightbulb', {
      {
        'CursorHold,CursorHoldI',
        '<buffer>',
        'lua require("nvim-lightbulb").update_lightbulb({ sign = { priority = 50 } })',
      },
    })
  end

  bso('omnifunc', 'v:lua.vim.lsp.omnifunc')

  bsk('n', 'gi', '<cmd>Telescope lsp_implementations<CR>')
  bsk('n', 'gd', '<cmd>Telescope lsp_definitions<CR>')
  bsk('n', 'gr', '<cmd>Telescope lsp_references<CR>')

  bsk('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  bsk('i', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  bsk('n', '<C-S>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bsk('n', 'g?', '<cmd>lua vim.diagnostic.open_float(0, { scope = "cursor" })<CR>')
  bsk('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  bsk('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>')

  bsk('n', '<leader>bf', '<cmd>lua vim.lsp.buf.formatting()<CR>')

  bsk('n', '<leader>ca', '<cmd>Telescope lsp_code_actions<CR>')
  bsk('x', '<leader>ca', '<cmd>Telescope lsp_range_code_actions<CR>')

  bsk('n', '<leader>sw', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
  bsk('n', '<leader>sd', '<cmd>Telescope lsp_document_symbols<CR>')
  bsk('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
  bsk('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
  bsk('n', '<leader>wl', '<cmd>lua Print(vim.lsp.buf.list_workspace_folders())<CR>')
end
