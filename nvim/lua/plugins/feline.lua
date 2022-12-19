local colors = require('colors')
local vi_mode = require('feline.providers.vi_mode')

----------------------------------------------------------------------
--                        Statusline Colors                         --
----------------------------------------------------------------------
local function component_colors()
  local mode_color = vi_mode.get_mode_color()

  return {
    a = { fg = colors.base, bg = mode_color },
    b = { fg = mode_color, bg = colors.surface0 },
    c = { fg = colors.text, bg = colors.base },
  }
end

local function seperator_colors()
  local cmp = component_colors()

  return {
    a = {
      b = { fg = cmp.a.bg, bg = cmp.b.bg },
      c = { fg = cmp.a.bg, bg = cmp.c.bg },
    },
    b = {
      c = { fg = cmp.b.bg, bg = cmp.c.bg },
    },
  }
end

----------------------------------------------------------------------
--                             Helpers                              --
----------------------------------------------------------------------
local function diagnostics_exist()
  return require('feline.providers.lsp').diagnostics_exist()
end

local function has_lsp_client()
  return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
end

local function file_info_provider(fnamemodifier)
  return function()
    if vim.bo.filetype == 'TelescopePrompt' then
      return ' [Telescope]'
    end

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

local function diagnostic_provider(provider, color)
  return {
    provider = 'diagnostic_' .. provider,
    hl = function()
      return { fg = color, bg = component_colors().b.bg }
    end,
  }
end

local disabled_filetypes = {
  '^neo.tree$',
  '^DiffviewFiles$',
}

----------------------------------------------------------------------
--                  Active Status Line Components                   --
----------------------------------------------------------------------
local active_vi_mode = {
  provider = function()
    return ' ' .. vi_mode.get_vim_mode() .. ' '
  end,
  hl = function()
    return component_colors().a
  end,
  right_sep = {
    str = 'slant_right',
    hl = function()
      local sep = seperator_colors()
      return diagnostics_exist() and sep.a.b or sep.a.c
    end,
  },
  update = { 'ModeChanged' },
}

local active_spacer = {
  provider = function()
    return ' '
  end,
  hl = function()
    return component_colors().b
  end,
  right_sep = {
    str = 'slant_right',
    hl = function()
      return seperator_colors().b.c
    end,
  },
  enabled = diagnostics_exist,
}

local active_file_info = {
  provider = file_info_provider(':t'),
  hl = function()
    return component_colors().c
  end,
}

local active_file_type = {
  provider = {
    name = 'file_type',
    opts = {
      filetype_icon = true,
      colored_icon = false,
      case = 'lowercase',
    },
  },
  hl = function()
    return component_colors().c
  end,
  right_sep = {
    str = ' ',
    hl = function()
      return component_colors().c
    end,
  },
}

local active_lsp_client_names = {
  enabled = has_lsp_client,
  provider = function()
    local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local client_names = {}
    for _, client in ipairs(vim.tbl_values(buf_clients)) do
      client_names[client.name] = true
    end
    return '   ' .. table.concat(vim.tbl_keys(client_names), ' ') .. ' '
  end,
  hl = function()
    return component_colors().b
  end,
  left_sep = {
    str = 'slant_left',
    hl = function()
      return seperator_colors().b.c
    end,
  },
}

local active_position = {
  provider = { name = 'position', opts = { format = ' {line}:{col} ' } },
  hl = function()
    return component_colors().a
  end,
  left_sep = {
    str = 'slant_left',
    hl = function()
      local sep = seperator_colors()
      return has_lsp_client() and sep.a.b or sep.a.c
    end,
  },
}

----------------------------------------------------------------------
--                        Winbar Components                         --
----------------------------------------------------------------------
local function winbar_file_info_provider(hl)
  return {
    provider = file_info_provider(':.'),
    hl = hl,
    right_sep = { str = ' ', hl = hl },
  }
end

----------------------------------------------------------------------
--                              Setup                               --
----------------------------------------------------------------------
require('feline').setup({
  components = {
    active = {
      {
        active_vi_mode,
        diagnostic_provider('errors', colors.red),
        diagnostic_provider('warnings', colors.yellow),
        diagnostic_provider('hints', colors.teal),
        diagnostic_provider('info', colors.sky),
        active_spacer,
        active_file_info,
      },
      { active_file_type, active_lsp_client_names, active_position },
    },
  },
  force_inactive = {
    filetypes = {},
    buftypes = {},
    bufnames = {},
  },
  vi_mode_colors = {
    NORMAL = colors.flamingo,
    OP = colors.flamingo,

    VISUAL = colors.teal,
    LINES = colors.teal,
    BLOCK = colors.teal,
    SELECT = colors.teal,

    INSERT = colors.green,

    REPLACE = colors.maroon,
    ['V-REPLACE'] = colors.maroon,

    ENTER = colors.peach,
    MORE = colors.peach,
    COMMAND = colors.peach,
    SHELL = colors.peach,
    TERM = colors.peach,

    NONE = colors.mauve,
  },
})

require('feline').winbar.setup({
  components = {
    active = {
      {},
      {
        winbar_file_info_provider(function()
          local cmp_colors = component_colors()
          return { fg = cmp_colors.a.bg, bg = 'NONE' }
        end),
      },
    },
    inactive = {
      {},
      { winbar_file_info_provider('WinBarNC') },
    },
  },
  disable = { filetypes = disabled_filetypes },
})
