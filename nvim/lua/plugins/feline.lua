local function set_theme()
  require('feline').use_theme(require('colors').get_colors())
end

return {
  'freddiehaddad/feline.nvim',
  enabled = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  set_theme = set_theme,
  config = function()
    local file_modified_icon = ''
    local file_readonly_icon = ' '

    ----------------------------------------------------------------------
    --                              Colors                              --
    ----------------------------------------------------------------------
    -- Vi Mode Colors {{{
    local vi_mode_colors = {
      NORMAL = 'blue',
      OP = 'blue',

      VISUAL = 'teal',
      LINES = 'teal',
      BLOCK = 'teal',
      SELECT = 'teal',

      INSERT = 'green',

      REPLACE = 'maroon',
      ['V-REPLACE'] = 'maroon',

      ENTER = 'peach',
      MORE = 'peach',
      COMMAND = 'peach',
      SHELL = 'peach',
      TERM = 'peach',

      NONE = 'mauve',
    }
    -- }}}

    ----------------------------------------------------------------------
    --                      Left Active Components                      --
    ----------------------------------------------------------------------
    local active_left = {}

    -- Vi Mode {{{
    local function vi_mode_hl()
      return {
        fg = 'base',
        bg = require('feline.providers.vi_mode').get_mode_color(),
        style = 'bold',
      }
    end
    table.insert(active_left, {
      provider = { name = 'vi_mode', opts = { show_mode_name = true } },
      hl = vi_mode_hl,
      left_sep = { str = ' ', hl = vi_mode_hl },
      right_sep = { str = ' ', hl = vi_mode_hl },
    })
    -- }}}

    -- Lazy Package Updates {{{
    local function lazy_package_hl()
      return {
        fg = require('feline.providers.vi_mode').get_mode_color(),
        bg = 'surface0',
      }
    end
    table.insert(active_left, {
      provider = require('lazy.status').updates,
      enabled = require('lazy.status').has_updates,
      hl = lazy_package_hl,
      left_sep = { str = ' ', hl = lazy_package_hl },
      right_sep = { str = ' ', hl = lazy_package_hl },
    })
    -- }}}

    -- File Info {{{
    local function file_info_hl()
      return { fg = 'text', bg = 'base' }
    end
    table.insert(active_left, {
      provider = {
        name = 'file_info',
        opts = { file_modified_icon = file_modified_icon, file_readonly_icon = file_readonly_icon },
      },
      icon = '',
      hl = file_info_hl,
      left_sep = { str = ' ', hl = file_info_hl },
    })
    -- }}}

    ----------------------------------------------------------------------
    --                     Right Active Components                      --
    ----------------------------------------------------------------------
    local active_right = {}

    -- File Type {{{
    local function file_type_hl()
      return { fg = 'text', bg = 'base' }
    end
    table.insert(active_right, {
      provider = {
        name = 'file_type',
        opts = { filetype_icon = true, case = 'lowercase', colored_icon = false },
      },
      hl = file_info_hl,
      right_sep = { str = ' ', hl = file_type_hl },
    })
    -- }}}

    -- Active LSP Clients, Linters, Formatters {{{
    local function active_nodes_hl()
      return {
        fg = require('feline.providers.vi_mode').get_mode_color(),
        bg = 'surface0',
      }
    end
    table.insert(active_right, {
      provider = function()
        local all_names = {}
        local filetype = vim.bo.filetype

        local client_names = {}
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(vim.tbl_values(buf_clients)) do
          table.insert(client_names, require('lsp.utils').get_server_display_name(client.name))
        end
        if #client_names > 0 then
          table.insert(all_names, table.concat(client_names, ' '))
        end

        local linter_names = {}
        for _, linter in ipairs(require('lint').linters_by_ft[filetype] or {}) do
          table.insert(linter_names, linter)
        end
        if #linter_names > 0 then
          table.insert(all_names, table.concat(linter_names, ' '))
        end

        local formatter = require('plugins.conform').get_formatter_for_filetype(filetype)
        if formatter then
          table.insert(all_names, formatter.name)
        end

        return table.concat(all_names, '|')
      end,
      hl = active_nodes_hl,
      icon = '  ',
      right_sep = { str = ' ', hl = active_nodes_hl },
    })
    -- }}}

    -- Position {{{
    local position_hl = function()
      return {
        fg = 'base',
        bg = require('feline.providers.vi_mode').get_mode_color(),
        style = 'bold',
      }
    end
    table.insert(active_right, {
      provider = 'position',
      left_sep = { str = ' ', hl = position_hl },
      right_sep = { str = '|', hl = position_hl },
      hl = position_hl,
    })
    table.insert(active_right, {
      provider = 'line_percentage',
      hl = position_hl,
      right_sep = { str = ' ', hl = position_hl },
    })
    -- }}}

    ----------------------------------------------------------------------
    --                        Winbar Components                         --
    ----------------------------------------------------------------------
    local function get_winbar_components(active)
      local bg = 'base'
      local function diagnostic_hl(fg)
        return function()
          return { fg = active and fg or 'overlay1', bg = bg }
        end
      end
      local function default_hl()
        return { bg = bg }
      end

      return {
        -- File Info {{{
        {
          {
            provider = {
              name = 'file_info',
              opts = {
                colored_icon = false,
                file_modified_icon = file_modified_icon,
                file_readonly_icon = file_readonly_icon,
                path_sep = ' ',
                type = 'relative',
              },
            },
            left_sep = { str = ' ', hl = default_hl },
            hl = function()
              return {
                fg = active and require('feline.providers.vi_mode').get_mode_color() or 'overlay1',
                bg = bg,
              }
            end,
          },
        },
        -- }}}
        -- Diagnostics {{{
        {
          {
            provider = 'diagnostic_errors',
            hl = diagnostic_hl('red'),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_warnings',
            hl = diagnostic_hl('yellow'),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_hints',
            hl = diagnostic_hl('teal'),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_info',
            hl = diagnostic_hl('sky'),
            update = { 'DiagnosticChanged' },
          },
          { provider = ' ', hl = default_hl },
        },
        -- }}}
      }
    end

    ----------------------------------------------------------------------
    --                              Setup                               --
    ----------------------------------------------------------------------
    require('feline').setup({
      components = { active = { active_left, active_right } },
      force_inactive = { filetypes = {}, buftypes = {}, bufnames = {} },
      vi_mode_colors = vi_mode_colors,
      -- highlight_reset_triggers = { 'SessionLoadPost' },
      theme = require('colors').get_colors(),
    })
    require('feline').winbar.setup({
      components = {
        active = get_winbar_components(true),
        inactive = get_winbar_components(false),
      },
      disable = { filetypes = { '^NvimTree$' } },
    })
  end,
}

-- vim:foldmethod=marker foldlevel=0
