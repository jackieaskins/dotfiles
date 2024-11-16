---@type LazySpec
return {
  'echasnovski/mini.files',
  keys = function()
    local function toggle(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end

    return {
      {
        '<C-n>',
        function()
          toggle(nil, false)
        end,
        desc = 'Toggle MiniFiles explorer at root',
      },
      {
        '<leader>n',
        function()
          toggle(vim.api.nvim_buf_get_name(0), false)
        end,
        desc = 'Toggle MiniFiles explorer at current file',
      },
      {
        '<leader>N',
        function()
          toggle(MiniFiles.get_latest_path())
        end,
        desc = 'Toggle MiniFiles explorer at last state',
      },
    }
  end,
  config = function()
    require('mini.files').setup({
      mappings = { go_in = '', go_out = '' },
      windows = { preview = true, width_preview = 50 },
    })

    local utils = require('utils')

    local general = require('plugins.navigation.mini-files.general')
    utils.augroup('mini_files_general', {
      { 'User', pattern = 'MiniFilesWindowOpen', callback = general.set_window_border },
      { 'User', pattern = 'MiniFilesActionDelete', callback = general.delete_buffer },
      { 'User', pattern = 'MiniFilesBufferCreate', callback = general.map_splits },
    })

    local lsp = require('plugins.navigation.mini-files.lsp')
    utils.augroup('mini_files_lsp', {
      {
        'User',
        pattern = { 'MiniFilesActionCreate', 'MiniFilesActionDelete' },
        callback = lsp.create_or_delete,
      },
      {
        'User',
        pattern = { 'MiniFilesActionRename', 'MiniFilesActionMove' },
        callback = lsp.rename_or_move,
      },
    })
  end,
}
