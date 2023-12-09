return {
  'freddiehaddad/feline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local colors = require('colors')
    local file_modified_icon = ''
    local file_readonly_icon = ' '
    local components = { active = { {}, {} } }

    ----------------------------------------------------------------------
    --                              Colors                              --
    ----------------------------------------------------------------------
    -- Vi Mode Colors {{{
    local vi_mode_colors = {
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
    }
    -- }}}

    ----------------------------------------------------------------------
    --                      Left Active Components                      --
    ----------------------------------------------------------------------
    -- Vi Mode {{{
    local function vi_mode_hl()
      return {
        fg = colors.base,
        bg = require('feline.providers.vi_mode').get_mode_color(),
      }
    end
    components.active[1][1] = {
      provider = { name = 'vi_mode' },
      icon = '',
      hl = vi_mode_hl,
      left_sep = { str = ' ', hl = vi_mode_hl },
      right_sep = { str = ' ', hl = vi_mode_hl },
    }
    -- }}}

    -- Git Diff {{{
    local function git_diff_hl(fg)
      return { fg = fg, bg = colors.surface0 }
    end
    components.active[1][2] = {
      provider = 'git_diff_added',
      hl = git_diff_hl(colors.green),
    }
    components.active[1][3] = {
      provider = 'git_diff_changed',
      hl = git_diff_hl(colors.yellow),
    }
    components.active[1][4] = {
      provider = 'git_diff_removed',
      hl = git_diff_hl(colors.red),
      right_sep = { str = ' ', hl = git_diff_hl(colors.red) },
    }
    -- }}}

    -- File Info {{{
    local file_info_hl = { fg = colors.text, bg = colors.base }
    components.active[1][5] = {
      provider = {
        name = 'file_info',
        opts = { file_modified_icon = file_modified_icon, file_readonly_icon = file_readonly_icon },
      },
      icon = '',
      hl = file_info_hl,
      left_sep = { str = ' ', hl = file_info_hl },
    }
    -- }}}

    ----------------------------------------------------------------------
    --                     Right Active Components                      --
    ----------------------------------------------------------------------
    -- File Type {{{
    local file_type_hl = { fg = colors.text, bg = colors.base }
    components.active[2][1] = {
      provider = {
        name = 'file_type',
        opts = { filetype_icon = true, case = 'lowercase', colored_icon = false },
      },
      hl = file_info_hl,
      right_sep = { str = ' ', hl = file_type_hl },
    }
    -- }}}

    -- LSP Clients {{{
    local lsp_clients_hl = function()
      return {
        fg = require('feline.providers.vi_mode').get_mode_color(),
        bg = colors.surface0,
      }
    end
    components.active[2][2] = {
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
    }
    -- }}}

    -- Position {{{
    local position_hl = function()
      return {
        fg = colors.base,
        bg = require('feline.providers.vi_mode').get_mode_color(),
      }
    end
    components.active[2][3] = {
      provider = 'position',
      left_sep = { str = ' ', hl = position_hl },
      right_sep = { str = ' ', hl = position_hl },
      hl = position_hl,
    }
    -- }}}

    ----------------------------------------------------------------------
    --                        Winbar Components                         --
    ----------------------------------------------------------------------
    local function get_winbar_components(active)
      local function diagnostic_hl(fg)
        return { fg = active and fg or colors.overlay1, bg = colors.base }
      end

      return {
        -- File Info {{{
        {
          {
            provider = {
              name = 'file_info',
              opts = {
                colored_icon = active,
                file_modified_icon = file_modified_icon,
                file_readonly_icon = file_readonly_icon,
                path_sep = ' ',
                type = 'relative',
              },
            },
            left_sep = { str = ' ', hl = { bg = colors.base } },
            hl = { fg = active and colors.text or colors.overlay1, bg = colors.base },
          },
        },
        -- }}}
        -- Diagnostics {{{
        {
          { provider = 'diagnostic_errors', hl = diagnostic_hl(colors.red) },
          { provider = 'diagnostic_warnings', hl = diagnostic_hl(colors.yellow) },
          { provider = 'diagnostic_hints', hl = diagnostic_hl(colors.teal) },
          { provider = 'diagnostic_info', hl = diagnostic_hl(colors.sky) },
          { provider = ' ', hl = { bg = colors.base } },
        },
        -- }}}
      }
    end

    ----------------------------------------------------------------------
    --                              Setup                               --
    ----------------------------------------------------------------------
    require('feline').setup({
      components = components,
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
