local M = {}

local function override_layouts()
  local layouts = require('snacks.picker.config.layouts')

  layouts.default.layout.backdrop = false
  layouts.vscode.layout.backdrop = 60
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
          return require('snacks.picker.source.proc').proc(
            ctx:opts({
              cmd = 'fd',
              args = { '--type', 'd', '--color', 'never', '-E', '.git', '--hidden' },
              transform = function(item)
                item.cwd = vim.fs.normalize(opts and opts.cwd or vim.uv.cwd() or '.')
                item.file = item.text
                item.dir = true
              end,
            }),
            ctx
          )
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

function M.get_init()
  local lsp_keymaps = {
    { 'grr', 'lsp_references', { include_declaration = false } },
    { 'grR', 'lsp_references', { include_declaration = false, auto_confirm = false } },
    { '<C-]>', 'lsp_definitions' },
    { '<C-M-]>', 'lsp_definitions', { auto_confirm = false } },
    { 'gri', 'lsp_implementations' },
    { 'grI', 'lsp_implementations', { auto_confirm = false } },
    { '<leader>sd', 'lsp_symbols' },
    { '<leader>sw', 'lsp_workspace_symbols' },
  }

  local utils = require('utils')

  utils.augroup('snacks_picker_lsp', {
    {
      'LspAttach',
      callback = function(args)
        local bsk = utils.buffer_map(args.buf)

        for _, map in ipairs(lsp_keymaps) do
          bsk('n', map[1], function()
            Snacks.picker.pick(map[2], map[3])
          end)
        end
      end,
    },
  })
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
    { '<leader>ut', 'undo' },
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
