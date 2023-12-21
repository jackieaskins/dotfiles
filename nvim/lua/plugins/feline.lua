return {
  'freddiehaddad/feline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local file_modified_icon = ''
    local file_readonly_icon = ' '

    ----------------------------------------------------------------------
    --                              Colors                              --
    ----------------------------------------------------------------------
    local colors = require('colors')

    -- Vi Mode Colors {{{
    local vi_mode_colors = {
      NORMAL = colors.blue,
      OP = colors.blue,

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
    }
    -- }}}

    ----------------------------------------------------------------------
    --                      Left Active Components                      --
    ----------------------------------------------------------------------
    local active_left = {}

    -- Vi Mode {{{
    local function vi_mode_hl()
      return {
        fg = colors.base,
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
        bg = colors.surface0,
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
    local file_info_hl = { fg = colors.text, bg = colors.base }
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
    local file_type_hl = { fg = colors.text, bg = colors.base }
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
    local active_nodes_hl = function()
      return {
        fg = require('feline.providers.vi_mode').get_mode_color(),
        bg = colors.surface0,
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
        fg = colors.base,
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
      local bg = colors.base
      local function diagnostic_hl(fg)
        return { fg = active and fg or colors.overlay1, bg = bg }
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
            left_sep = { str = ' ', hl = { bg = bg } },
            hl = function()
              return {
                fg = active and require('feline.providers.vi_mode').get_mode_color() or colors.overlay1,
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
            hl = diagnostic_hl(colors.red),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_warnings',
            hl = diagnostic_hl(colors.yellow),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_hints',
            hl = diagnostic_hl(colors.teal),
            update = { 'DiagnosticChanged' },
          },
          {
            provider = 'diagnostic_info',
            hl = diagnostic_hl(colors.sky),
            update = { 'DiagnosticChanged' },
          },
          { provider = ' ', hl = { bg = bg } },
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
