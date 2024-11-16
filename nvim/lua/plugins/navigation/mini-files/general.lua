local M = {}

---Set the window border for the mini.files window
---@param args AutoCmdCallbackArgs
function M.set_window_border(args)
  local win_id = args.data.win_id

  local config = vim.api.nvim_win_get_config(win_id)
  config.border = MY_CONFIG.border_style

  vim.api.nvim_win_set_config(win_id, config)
end

---Delete the buffer if it exists
---@param args AutoCmdCallbackArgs
function M.delete_buffer(args)
  local bufnr = vim.fn.bufnr(args.data.from)

  if bufnr ~= -1 then
    Snacks.bufdelete(bufnr)
  end
end

---Map commands to open files in splits
---@param args AutoCmdCallbackArgs
function M.map_splits(args)
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
    require('utils').map('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  map_split('<C-s>', 'horizontal')
  map_split('<C-v>', 'vertical')
end

return M
