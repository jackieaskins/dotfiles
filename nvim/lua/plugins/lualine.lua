-- https://github.com/nvim-lualine/lualine.nvim

local colors = require('colors')
local diagnostic_icons = require('diagnostic.icons')

local custom_onenord = require('lualine.themes.onenord')
custom_onenord.normal.a.gui = colors.none
custom_onenord.insert.a.gui = colors.none
custom_onenord.command.a.gui = colors.none
custom_onenord.visual.a.gui = colors.none
custom_onenord.replace.a.gui = colors.none
custom_onenord.inactive.a.gui = colors.none
custom_onenord.inactive.a.bg = colors.float
custom_onenord.inactive.b.bg = colors.float

local function lsp_clients()
  local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
  if #buf_clients == 0 then
    return ''
  end

  local client_names = {}
  for _, client in ipairs(vim.tbl_values(buf_clients)) do
    client_names[client.name] = true
  end
  return '  ' .. table.concat(vim.tbl_keys(client_names), ' ')
end

local filename_symbols = { modified = ' ', readonly = ' ' }

local statusline_filename = { 'filename', symbols = filename_symbols, separator = '' }
local winbar_filename = { 'filename', symbols = filename_symbols, path = 1 }
local location = '%l:%c'

require('lualine').setup({
  options = {
    disabled_filetypes = {
      statusline = { 'NvimTree' },
      winbar = { 'NvimTree' },
    },
    theme = custom_onenord,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'diagnostics',
        symbols = {
          hint = diagnostic_icons.Hint,
          info = diagnostic_icons.Info,
          warn = diagnostic_icons.Warn,
          error = diagnostic_icons.Error,
        },
        update_in_insert = true,
      },
    },
    lualine_c = {
      statusline_filename,
      { color = { fg = colors.light_gray }, padding = 0 },
    },

    lualine_x = {
      { 'filetype', colored = false },
    },
    lualine_y = { lsp_clients },
    lualine_z = { location },
  },
  winbar = { lualine_x = { winbar_filename } },
  inactive_winbar = {
    lualine_x = { winbar_filename },
  },
  inactive_sections = {
    lualine_c = { statusline_filename },
    lualine_x = { location },
  },
})

return { lualine_onenord = custom_onenord }
