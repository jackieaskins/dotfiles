local icons = require('diagnostic.icons')
local sign_hls = require('diagnostic.sign_hls')
local utils = require('utils')

-- Inspired by https://github.com/ivanjermakov/troublesum.nvim
local vt_ns = vim.api.nvim_create_namespace('my_diagnostic_vt')
local cached_diagnostics_by_buf = {}

local function clear_buf(bufnr)
  pcall(vim.api.nvim_buf_clear_namespace, bufnr, vt_ns, 0, -1)
end

local function set_buf(bufnr, diagnostics)
  local virt_text = {}
  for idx, count in ipairs(diagnostics) do
    if count > 0 then
      table.insert(virt_text, { icons[idx] .. count .. ' ', sign_hls[idx] })
    end
  end

  pcall(
    vim.api.nvim_buf_set_extmark,
    bufnr,
    vt_ns,
    vim.fn.line('w0', vim.fn.bufwinid(bufnr)) - 1,
    0,
    { virt_text = virt_text, virt_text_pos = 'right_align' }
  )
end

utils.augroup('diagnostic_vt', {
  {
    'DiagnosticChanged',
    callback = utils.debounce(function()
      local diagnostics_by_buf = {}
      for _, diagnostic in ipairs(vim.diagnostic.get(nil)) do
        local bufnr, severity = tostring(diagnostic.bufnr), diagnostic.severity

        local buf_diagnostics = diagnostics_by_buf[bufnr] or { 0, 0, 0, 0 }
        local num_at_severity = buf_diagnostics[severity]
        ---@diagnostic disable-next-line: need-check-nil
        buf_diagnostics[severity] = num_at_severity + 1
        diagnostics_by_buf[bufnr] = buf_diagnostics
      end

      for bufstr, _ in pairs(cached_diagnostics_by_buf) do
        clear_buf(tonumber(bufstr))
      end

      for bufstr, diagnostics in pairs(diagnostics_by_buf) do
        set_buf(tonumber(bufstr), diagnostics)
      end

      cached_diagnostics_by_buf = diagnostics_by_buf
    end, 250),
  },
  {
    { 'WinScrolled', 'WinResized' },
    callback = utils.debounce(function()
      for bufstr, diagnostics in pairs(cached_diagnostics_by_buf) do
        local bufnr = tonumber(bufstr)
        clear_buf(bufnr)
        set_buf(bufnr, diagnostics)
      end
    end, 250),
  },
})
