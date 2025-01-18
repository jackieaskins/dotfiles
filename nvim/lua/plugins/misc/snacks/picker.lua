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
  vscode[1].border = border
end

---@return snacks.picker.Config
function M.get_config()
  override_layouts()

  return {
    enabled = MY_CONFIG.picker == 'snacks',
    ui_select = true,
    win = {
      input = {
        keys = {
          ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
        },
      },
    },
  }
end

function M.get_keys()
  local keys = {
    -- Buffers and Files
    { '<leader><leader>', 'smart' },
    { '<leader>bu', 'buffers' },
    { '<C-p>', 'files', { follow = true, hidden = true } },
    { '<leader>of', 'recent', { filter = { cwd = true } } },

    -- Search
    { '<leader>fw', 'grep_word' },
    { '<leader>/', 'grep' },

    -- Git
    { '<leader>gs', 'git_status' },
    { '<leader>gl', 'git_log' },
    { '<leader>gL', 'git_log_file' },

    -- LSP
    { 'gr', 'lsp_references', { include_declaration = false } },
    { 'gpr', 'lsp_references', { include_declaration = false, auto_confirm = false } },
    { 'gd', 'lsp_definitions' },
    { 'gpd', 'lsp_definitions', { auto_confirm = false } },
    { 'gD', 'lsp_declarations' },
    { 'gpD', 'lsp_declarations', { auto_confirm = false } },
    { 'gi', 'lsp_implementations' },
    { 'gpi', 'lsp_implementations', { auto_confirm = false } },
    { '<leader>sd', 'lsp_symbols' },
    -- { '<leader>sw', 'lsp_workspace_symbols' },

    -- Diagnostics
    { '<leader>wd', 'diagnostics' },

    -- Misc
    { '<leader>.', 'resume' },
    { '<leader>:', 'commands' },
    { '<leader>ht', 'help' },
    { '<leader>hi', 'highlights' },
    { '<leader>au', 'autocmds' },
    { '<leader>km', 'keymaps' },
  }

  return vim.tbl_map(function(map)
    return {
      map[1],
      function()
        Snacks.picker[map[2]](map[3])
      end,
      desc = 'Picker ' .. map[1],
    }
  end, keys)
end

return M
