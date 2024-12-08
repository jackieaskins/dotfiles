-- Inspired by https://www.reddit.com/r/neovim/comments/1cfd5w1/minifiles_git_status_integration/

-- TODO: Change highlighting based on status
-- TODO: Show signs for dirs
-- TODO: Caching?
-- TODO: Use symbols
-- TODO: Refactor

local NS = vim.api.nvim_create_namespace('mini_files_git')

---Get the directory of the specified buffer
---@param buf_id number
---@return string | nil
local function get_buf_dir(buf_id)
  local first_entry = MiniFiles.get_fs_entry(buf_id, 1)
  if not first_entry then
    return
  end

  local dir = vim.fn.fnamemodify(first_entry.path, ':h')
  return vim.fn.isdirectory(dir) and dir or nil
end

local M = {}

---Add git info to the buffer
---@param args AutoCmdCallbackArgs
function M.add_git_info(args)
  local buf_id = args.data.buf_id

  local buf_dir = get_buf_dir(buf_id)
  local git_dir = buf_dir and vim.fs.root(buf_dir, '.git')
  if not git_dir then
    return
  end

  vim.system({ 'git', 'status', '-z', '--ignored', '--no-renames', '.' }, { text = true, cwd = buf_dir }, function(out)
    if out.code == 0 then
      local items = vim.split(out.stdout, ' ', { trimempty = true })
      local file_statuses = {}

      for _, item in ipairs(items) do
        local status, file = item:match('^(%s*%S+%s*)%s(.+)$')
        file_statuses[string.format('%s/%s', git_dir, file)] = status
      end

      vim.schedule(function()
        local num_lines = vim.api.nvim_buf_line_count(buf_id)
        for line = 1, num_lines do
          local entry = MiniFiles.get_fs_entry(buf_id, line)
          if entry then
            local path = entry.path .. (entry.fs_type == 'directory' and '/' or '')
            local status = file_statuses[path]
            if status then
              vim.api.nvim_buf_set_extmark(buf_id, NS, line - 1, -1, {
                virt_text = {
                  { status, 'GitSignsChange' },
                },
                virt_text_pos = 'right_align',
              })
            end
          end
        end
      end)
    end
  end)
end

return M
