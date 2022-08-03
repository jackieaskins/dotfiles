local colors = require('colors')
local vi_mode = require('feline.providers.vi_mode')

----------------------------------------------------------------------
--                             Helpers                              --
----------------------------------------------------------------------
local active_hl = { fg = colors.fg, bg = colors.active }
local inactive_hl = { fg = colors.light_gray, bg = colors.active }

local function mode_hl()
  return { fg = colors.bg, bg = vi_mode.get_mode_color(), style = 'bold' }
end

local function file_info_provider(fnamemodifier)
  return function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local filename = buf_name == '' and '[No Name]' or vim.fn.fnamemodify(buf_name, fnamemodifier)

    return table.concat({
      ' ',
      filename:gsub('%%', '%%%%'), -- escape status line characters
      vim.bo.readonly and ' ' or '',
      vim.bo.modified and ' ' or '',
    })
  end
end

local disabled_filetypes = {
  'NvimTree',
  'DiffviewFiles',
}

----------------------------------------------------------------------
--                  Active Status Line Components                   --
----------------------------------------------------------------------
local active_vi_mode = {
  provider = function()
    return ' ' .. vi_mode.get_vim_mode() .. ' '
  end,
  hl = mode_hl,
  right_sep = {
    str = '',
    hl = function()
      return {
        fg = vi_mode.get_mode_color(),
        bg = require('feline.providers.lsp').diagnostics_exist() and colors.float or colors.active,
      }
    end,
  },
  update = { 'ModeChanged' },
}

local active_spacer = {
  provider = function()
    return ' '
  end,
  hl = { bg = colors.float },
  right_sep = {
    str = '',
    hl = { fg = colors.float, bg = colors.active },
  },
  enabled = require('feline.providers.lsp').diagnostics_exist,
}

local active_file_info = { provider = file_info_provider(':t'), hl = active_hl }

local active_file_type = {
  provider = {
    name = 'file_type',
    opts = {
      filetype_icon = true,
      colored_icon = false,
      case = 'lowercase',
    },
  },
  hl = active_hl,
  priority = -1,
}

local active_lsp_client_names = {
  provider = function()
    local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local client_names = {}
    for _, client in ipairs(vim.tbl_values(buf_clients)) do
      client_names[client.name] = true
    end
    return '   ' .. table.concat(vim.tbl_keys(client_names), ' ')
  end,
  enabled = function()
    return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
  end,
  hl = function()
    return {
      fg = vi_mode.get_mode_color(),
      bg = colors.highlight,
    }
  end,
  left_sep = {
    str = ' ',
    hl = { fg = colors.highlight, bg = colors.active },
  },
  priority = -2,
}

local active_position = {
  provider = { name = 'position', opts = { format = ' {line}:{col} ' } },
  hl = mode_hl,
  left_sep = {
    str = ' ',
    hl = function()
      return {
        fg = vi_mode.get_mode_color(),
        bg = #vim.lsp.get_active_clients({ bufnr = 0 }) > 0 and colors.float or colors.active,
      }
    end,
  },
  priority = -1,
}

----------------------------------------------------------------------
--                              Setup                               --
----------------------------------------------------------------------
require('feline').setup({
  components = {
    active = {
      {
        active_vi_mode,
        { provider = 'diagnostic_errors', hl = { fg = colors.error, bg = colors.float } },
        { provider = 'diagnostic_warnings', hl = { fg = colors.warn, bg = colors.float } },
        { provider = 'diagnostic_hints', hl = { fg = colors.hint, bg = colors.float } },
        { provider = 'diagnostic_info', hl = { fg = colors.info, bg = colors.float } },
        active_spacer,
        active_file_info,
      },
      { active_file_type, active_lsp_client_names, active_position },
    },
    inactive = {
      { { provider = file_info_provider(':t'), hl = inactive_hl } },
      { { provider = 'position', hl = inactive_hl } },
    },
  },
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {},
  },
  disable = { filetypes = disabled_filetypes },
  vi_mode_colors = {
    NORMAL = colors.cyan,
    OP = colors.cyan,

    VISUAL = colors.yellow,
    LINES = colors.yellow,
    BLOCK = colors.yellow,
    SELECT = colors.yellow,

    INSERT = colors.green,

    REPLACE = colors.red,
    ['V-REPLACE'] = colors.red,

    ENTER = colors.purple,
    MORE = colors.purple,
    COMMAND = colors.purple,
    SHELL = colors.purple,
    TERM = colors.purple,

    NONE = colors.orange,
  },
})

require('feline').winbar.setup({
  components = {
    active = {
      {},
      { { provider = file_info_provider(':.'), hl = 'WinBar' } },
    },
    inactive = {
      {},
      { { provider = file_info_provider(':.'), hl = 'WinBarNC' } },
    },
  },
  disable = { filetypes = disabled_filetypes },
})
