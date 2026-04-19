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
---@field oil_git { file_statuses: FileStatuses }

local M = {}

---Set git sign extmarks
---@param buf number
function M.set_signs(buf)
  local oil_git = vim.b[buf].oil_git

  if not oil_git then
    return
  end

  local file_statuses = oil_git.file_statuses

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
      local statuses = file_statuses[entry.name] or file_statuses['*']

      if statuses then
        set_signs({ statuses.working_tree, statuses.index })
      end
    end
  end
end

local function get_dir_statuses(dir, new_statuses, all_file_statuses)
  local curr_statuses = all_file_statuses[dir]

  if not curr_statuses then
    return new_statuses
  end

  local function get_new_status(type)
    local curr, new = curr_statuses[type], new_statuses[type]

    if new == '!' or new == curr then
      return curr
    end

    if curr == ' ' then
      return new
    end

    return 'M'
  end

  return {
    index = get_new_status('index'),
    working_tree = get_new_status('working_tree'),
  }
end

---Load git info and add git signs to oil buffer
---@param buf number
function M.load_git_signs(buf)
  local run_opts = {
    cwd = require('oil').get_current_dir(buf),
    text = true,
  }

  ---@param cmd string
  ---@param cb fun(output_lines: string[])
  local function run(cmd, cb)
    vim.system(vim.split(cmd, ' '), run_opts, function(out)
      if out.code ~= 0 then
        return
      end

      cb(vim.split(out.stdout, '\n', { trimempty = true }))
    end)
  end

  run('git -c status.relativePaths=true status --short --ignored=matching .', function(status_output)
    run('git ls-tree HEAD --name-only .', function(file_output)
      vim.schedule(function()
        ---@type FileStatuses
        local all_file_statuses = {}

        for _, file in ipairs(file_output) do
          local is_dir = file:match('.+/.*') ~= nil
          local dir = vim.split(file, '/', { plain = true })[1]
          local key = is_dir and dir or file

          all_file_statuses[key] = { index = ' ', working_tree = ' ' }
        end

        for _, status in ipairs(status_output) do
          ---@type string, string, string
          local index_status, working_tree_status, file = status:match('^(.)(.)%s(.+)$')
          file = file:match('.+ -> (.+)') or file -- Parse out renamed files

          local statuses = { index = index_status, working_tree = working_tree_status }

          local is_dir = file:match('.+/.*') ~= nil

          -- Handle files in gitignored directories or parent directories
          if file == './' or file:match('(%.%./)$') then
            all_file_statuses['*'] = statuses
          elseif is_dir then
            local dir = vim.split(file, '/', { plain = true })[1]

            all_file_statuses[dir] = get_dir_statuses(dir, statuses, all_file_statuses)
          else
            all_file_statuses[file] = statuses
          end
        end

        vim.b[buf].oil_git = { file_statuses = all_file_statuses }

        M.set_signs(buf)
      end)
    end)
  end)
end

return M
