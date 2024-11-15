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
  opts = {
    mappings = { go_in = '', go_out = '' },
    windows = { preview = true },
  },
  init = function()
    local utils = require('utils')

    local function handle_modification(method_suffix, params)
      local clients = vim.lsp.get_clients()

      for _, client in ipairs(clients) do
        local will_rename_method = 'workspace/will' .. method_suffix
        if client.supports_method(will_rename_method) then
          local resp = client.request_sync(will_rename_method, params, 1000, 0)
          if resp and resp.result then
            vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
          end
        end

        local did_rename_method = 'workspace/did' .. method_suffix
        if client.supports_method(did_rename_method) then
          client.notify(did_rename_method)
        end
      end
    end

    utils.augroup('mini_files', {
      {
        'User',
        pattern = 'MiniFilesWindowOpen',
        callback = function(args)
          local win_id = args.data.win_id

          local config = vim.api.nvim_win_get_config(win_id)
          config.border = MY_CONFIG.border_style

          vim.api.nvim_win_set_config(win_id, config)
        end,
      },
      {
        'User',
        pattern = 'MiniFilesActionDelete',
        callback = function(args)
          local bufnr = vim.fn.bufnr(args.data.from)

          if bufnr ~= -1 then
            vim.api.nvim_buf_delete(bufnr, {})
          end
        end,
      },
      {
        'User',
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id

          local function map_split(lhs, direction)
            local rhs = function()
              local new_target_window
              local curr_target_window = MiniFiles.get_explorer_state().target_window
              if curr_target_window ~= nil then
                vim.api.nvim_win_call(curr_target_window, function()
                  vim.cmd('belowright ' .. direction .. ' split')
                  new_target_window = vim.api.nvim_get_current_win()
                end)

                MiniFiles.set_target_window(new_target_window)
                MiniFiles.go_in({ close_on_file = true })
              end
            end

            local desc = 'Open in ' .. direction .. ' split'
            utils.map('n', lhs, rhs, { buffer = buf_id, desc = desc })
          end

          map_split('<C-s>', 'horizontal')
          map_split('<C-v>', 'vertical')
        end,
      },
      {
        'User',
        pattern = { 'MiniFilesActionCreate', 'MiniFilesActionDelete' },
        callback = function(args)
          local params = {
            files = {
              uri = vim.uri_from_fname(args.data.from or args.data.to),
            },
          }

          local method_suffix = args.event == 'MiniFilesActionCreate' and 'CreateFiles' or 'DeleteFiles'

          handle_modification(method_suffix, params)
        end,
      },
      {
        'User',
        pattern = { 'MiniFilesActionRename', 'MiniFilesActionMove' },
        callback = function(args)
          local params = {
            files = {
              {
                oldUri = vim.uri_from_fname(args.data.from),
                newUri = vim.uri_from_fname(args.data.to),
              },
            },
          }

          handle_modification('RenameFiles', params)
        end,
      },
    })
  end,
}
