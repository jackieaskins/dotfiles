local M = {}

local function override_layouts()
  local border = MY_CONFIG.border_style

  local layouts = require('snacks.picker.config.layouts')

  local default = layouts.default.layout
  default.backdrop = false
  default[1].border = border -- Results & Input
  default[2].border = border -- Preview

  local telescope = layouts.telescope.layout
  telescope[1][1].border = border -- Results
  telescope[1][2].border = border -- Input
  telescope[2].border = border -- Preview

  local dropdown = layouts.dropdown.layout
  dropdown[1].border = border -- Preview
  dropdown[2].border = border -- Results & Input

  local vertical = layouts.vertical.layout
  vertical.border = border

  local select = layouts.select.layout
  select.border = border

  local vscode = layouts.vscode.layout
  vscode.backdrop = 60
  vscode[1].border = border -- Input
end

function M.get_config()
  override_layouts()

  ---@type snacks.picker.Config
  return {
    enabled = true,
    matcher = { frecency = true, history_bonus = true },
    sources = {
      directories = {
        finder = function(opts, ctx)
          return require('snacks.picker.source.proc').proc({
            opts,
            {
              cmd = 'fd',
              args = { '--type', 'd', '--color', 'never', '-E', '.git', '--hidden' },
              transform = function(item)
                item.cwd = vim.fs.normalize(opts and opts.cwd or vim.uv.cwd() or '.')
                item.file = item.text
                item.dir = true
              end,
            },
          }, ctx)
        end,
      },
      git_status = {
        win = {
          input = {
            keys = {
              ['<Tab>'] = { 'select_and_next', mode = { 'n', 'i' } },
              ['<C-Space>'] = { 'git_stage', mode = { 'n', 'i' } },
            },
          },
        },
      },
    },
    previewers = {
      git = { native = true },
      diff = {
        native = true,
        cmd = { 'delta' },
      },
    },
    ui_select = true,
    ---@diagnostic disable-next-line: missing-fields
    icons = { diagnostics = require('diagnostic.icons') },
    win = {
      input = {
        keys = {
          ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          ['<C-t>'] = { 'edit_tab', mode = { 'n', 'i' } },
          ['<C-u>'] = false,
        },
      },
      list = {
        wo = { foldcolumn = '0' },
      },
    },
  }
end

function M.get_keys()
  local keys = {
    -- Buffers and Files
    { '<leader>bu', 'buffers' },
    { '<C-p>', 'files', { follow = true, hidden = true } },
    { '<leader>of', 'recent', { filter = { cwd = true } } },
    { '<leader>fd', 'directories' },

    -- Search
    { '<leader>fw', 'grep_word', nil, { 'n', 'x' } },
    { '<leader>/', 'grep' },

    -- Git
    { '<leader>gs', 'git_status' },
    { '<leader>gl', 'git_log' },
    { '<leader>gL', 'git_log_file' },

    -- LSP
    { 'grr', 'lsp_references', { include_declaration = false } },
    { 'grR', 'lsp_references', { include_declaration = false, auto_confirm = false } },
    { 'gri', 'lsp_implementations' },
    { 'grI', 'lsp_implementations', { auto_confirm = false } },
    { '<leader>sd', 'lsp_symbols' },
    { '<leader>sw', 'lsp_workspace_symbols' },

    -- Diagnostics
    { '<leader>wd', 'diagnostics' },

    -- Misc
    { '<leader>.', 'resume' },
    { '<leader>:', 'commands' },
    { '<leader>ht', 'help' },
    { '<leader>hl', 'highlights' },
    { '<leader>au', 'autocmds' },
    { '<leader>km', 'keymaps' },
    { '<leader>z=', 'spelling' },
  }

  return vim.tbl_map(function(map)
    local keymap, picker, args, mode = unpack(map)

    return {
      keymap,
      function()
        Snacks.picker.pick(picker, args)
      end,
      desc = 'Picker ' .. picker,
      mode = mode,
    }
  end, keys)
end

return M
