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

    -- Git Diff {{{
    local function git_diff_hl(fg)
      return { fg = fg, bg = colors.surface0 }
    end
    table.insert(active_left, {
      provider = 'git_diff_added',
      hl = git_diff_hl(colors.green),
    })
    table.insert(active_left, {
      provider = 'git_diff_changed',
      hl = git_diff_hl(colors.yellow),
    })
    table.insert(active_left, {
      provider = 'git_diff_removed',
      hl = git_diff_hl(colors.red),
    })
    table.insert(active_left, {
      provider = ' ',
      hl = git_diff_hl(nil),
      enabled = function()
        local status = vim.b.gitsigns_status
        return status and status ~= ''
      end,
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

    -- LSP Clients {{{
    local lsp_clients_hl = function()
      return {
        fg = require('feline.providers.vi_mode').get_mode_color(),
        bg = colors.surface0,
      }
    end
    table.insert(active_right, {
      provider = function()
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        local client_names = {}
        for _, client in ipairs(vim.tbl_values(buf_clients)) do
          client_names[require('lsp.utils').get_server_display_name(client.name)] = true
        end
        return table.concat(vim.tbl_keys(client_names), ' ')
      end,
      hl = lsp_clients_hl,
      icon = '  ',
      right_sep = { str = ' ', hl = lsp_clients_hl },
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
          { provider = 'diagnostic_errors', hl = diagnostic_hl(colors.red) },
          { provider = 'diagnostic_warnings', hl = diagnostic_hl(colors.yellow) },
          { provider = 'diagnostic_hints', hl = diagnostic_hl(colors.teal) },
          { provider = 'diagnostic_info', hl = diagnostic_hl(colors.sky) },
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
