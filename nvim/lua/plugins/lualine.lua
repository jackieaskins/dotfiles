-- https://github.com/nvim-lualine/lualine.nvim

local colors = require('colors')
local lsp_icons = require('lsp.icons')

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
  local buf_clients = vim.lsp.buf_get_clients(vim.fn.bufnr('%'))
  if #buf_clients == 0 then
    return ''
  end

  local client_names = {}
  for _, client in ipairs(vim.tbl_values(buf_clients)) do
    client_names[client.name] = true
  end
  return '  ' .. table.concat(vim.tbl_keys(client_names), ' ')
end

local function gps_location()
  if vim.bo.filetype == '' then
    return ''
  end

  local success, gps = pcall(require, 'nvim-gps')
  if success and gps.is_available() then
    local location = gps.get_location()
    return location == '' and '' or '> ' .. location
  else
    return ''
  end
end

local filename = { 'filename', symbols = { modified = ' ', readonly = ' ' }, separator = '' }
local location = '%l:%c'

require('lualine').setup({
  options = {
    disabled_filetypes = { 'NvimTree' },
    theme = custom_onenord,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'diagnostics',
        symbols = { hint = lsp_icons.Hint, info = lsp_icons.Info, warn = lsp_icons.Warn, error = lsp_icons.Error },
        update_in_insert = true,
      },
    },
    lualine_c = {
      filename,
      { gps_location, color = { fg = colors.light_gray }, padding = 0 },
    },

    lualine_x = {
      { 'filetype', colored = false },
    },
    lualine_y = { lsp_clients },
    lualine_z = { location },
  },
  inactive_sections = {
    lualine_c = { filename },
    lualine_x = { location },
  },
})

return { lualine_onenord = custom_onenord }
