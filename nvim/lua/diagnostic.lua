local icons = require('diagnostic.icons')

vim.diagnostic.config({
  float = { source = true, border = vim.g.border_style },
  signs = {
    text = { icons[1], icons[2], icons[3], icons[4] },
    priority = require('sign_priorities').diagnostics,
  },
  severity_sort = true,
  update_in_insert = false,
  jump = { float = false },
  virtual_text = false,
})

local ns = vim.api.nvim_create_namespace('CurlineDiag')
local opts = { spacing = 1 }
require('utils').augroup('curline_diagnostic_vt', {
  {
    { 'CursorHold', 'DiagnosticChanged' },
    callback = function(args)
      local bufnr = args.buf

      pcall(vim.api.nvim_buf_clear_namespace, bufnr, ns, 0, -1)

      local lnum = vim.fn.line('.') - 1
      local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })

      -- This will eventually break when neovim stops exporting _get_virt_text_chunks
      local virt_text = vim.diagnostic._get_virt_text_chunks(diagnostics, opts)
      if virt_text then
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum, 0, {
          hl_mode = 'combine',
          virt_text = virt_text,
          virt_text_pos = 'eol',
        })
      end
    end,
  },
})
