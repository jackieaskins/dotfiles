-- Desired behaviors:
-- 1. Do not show gitsigns on a new entry that has been added but not yet saved
-- 2. Display gitignored files as such
-- 3. Recursively handle files inside of a gitignored directory
-- 4. Recursively handle git status on directories, using 'M' when children differ

local oil_gitsigns_ns = vim.api.nvim_create_namespace('oil-gitsigns')

local git_signs_change = 'GitSignsChange'
local hl_groups = {
  A = 'GitSignsAdd',
  D = 'GitSignsDelete',
  R = git_signs_change,
  C = git_signs_change,
  T = git_signs_change,
  U = git_signs_change,
  M = git_signs_change,
  ['!'] = 'NonText',
  ['?'] = 'GitSignsUntracked',
}

---@alias FileStatuses table<string, { index: string, working_tree: string }>

---@class (private) vim.var_accessor
---@field oil_git { file_statuses: FileStatuses, files: string[] }
---@field oil_file_statuses? FileStatuses

---@param items string[]
---@return FileStatuses
local function get_file_statuses(items)
  local file_statuses = {}

  for _, item in ipairs(items) do
    local index_status, working_tree_status, file = item:match('^(.)(.)%s(.+)$')
    local statuses = { index = index_status, working_tree = working_tree_status }

    local is_dir = file:match('.+/.*') ~= nil

    if is_dir then
      local dir = vim.split(file, '/', { plain = true })[1]
      local curr_statuses = file_statuses[dir]

      if curr_statuses then
        if curr_statuses.index ~= index_status then
          file_statuses[dir].index = 'M'
        end

        if curr_statuses.working_tree ~= working_tree_status then
          file_statuses[dir].working_tree = 'M'
        end
      else
        file_statuses[dir] = statuses
      end
    else
      file_statuses[file] = statuses
    end
  end

  return file_statuses
end

local M = {}

---Set git sign extmarks
---@param buf number
function M.set_signs(buf)
  local oil_git = vim.b[buf].oil_git

  if not oil_git then
    return
  end

  local file_statuses = oil_git.file_statuses
  local git_files = oil_git.files

  vim.api.nvim_buf_clear_namespace(buf, oil_gitsigns_ns, 0, -1)

  for line_num = 1, vim.api.nvim_buf_line_count(buf) do
    local entry = require('oil').get_entry_on_line(buf, line_num)

    ---@param signs string[]
    local function set_signs(signs)
      for index, sign in ipairs(signs) do
        vim.api.nvim_buf_set_extmark(buf, oil_gitsigns_ns, line_num - 1, 0, {
          sign_text = sign,
          priority = index,
          sign_hl_group = hl_groups[sign],
        })
      end
    end

    -- entry.id will only be set for changes that have been committed
    if entry and entry.id and entry.name ~= '..' then
      local statuses = file_statuses[entry.name]

      if statuses then
        set_signs({ statuses.working_tree, statuses.index })
      elseif not vim.tbl_contains(git_files, entry.name) then
        set_signs({ '!', '!' })
      end
    end
  end
end

---Load git info and add git signs to oil buffer
---@param buf number
function M.load_git_signs(buf)
  local run_opts = {
    cwd = require('oil').get_current_dir(buf),
    text = true,
  }

  ---@param cmd string
  local function run(cmd, cb)
    vim.system(vim.split(cmd, ' '), run_opts, function(out)
      if out.code ~= 0 then
        return
      end

      cb(vim.split(out.stdout, '\n', { trimempty = true }))
    end)
  end

  run('git -c status.relativePaths=true status --short .', function(status_output)
    run('git ls-tree HEAD --name-only .', function(file_output)
      vim.schedule(function()
        vim.b[buf].oil_git = {
          file_statuses = get_file_statuses(status_output),
          files = file_output,
        }

        M.set_signs(buf)
      end)
    end)
  end)
end

return M
