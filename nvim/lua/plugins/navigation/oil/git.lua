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

---@param items string[]
---@return FileStatuses
local function get_file_statuses(items)
  local file_statuses = {}

  for _, item in ipairs(items) do
    local index_status, working_tree_status, file = item:match('^(.)(.)%s(.+)$')
    local statuses = { index = index_status, working_tree = working_tree_status }

    local is_dir = file:match('.+/.*') ~= nil

    if file == './' then
      file_statuses['..'] = statuses
    elseif is_dir then
      local dir = vim.split(file, '/', { plain = true })[1]
      local is_git_ignored = index_status == '!' and working_tree_status == '!'

      if is_git_ignored then
        if dir .. '/' == file then
          file_statuses[dir] = statuses
        end
      else
        local curr_statuses = file_statuses[dir]

        if curr_statuses then
          file_statuses[dir] = {
            index = curr_statuses.index == index_status and curr_statuses.index or 'M',
            working_tree = curr_statuses.working_tree == working_tree_status and curr_statuses.index or 'M',
          }
        else
          file_statuses[dir] = statuses
        end
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
  local file_statuses = vim.b[buf].file_statuses

  if not file_statuses then
    return
  end

  vim.api.nvim_buf_clear_namespace(buf, oil_gitsigns_ns, 0, -1)

  for line_num = 1, vim.api.nvim_buf_line_count(buf) do
    local entry = require('oil').get_entry_on_line(buf, line_num)
    local statuses = entry and file_statuses[entry.name]

    if statuses then
      vim.api.nvim_buf_set_extmark(buf, oil_gitsigns_ns, line_num - 1, 0, {
        sign_text = statuses.working_tree,
        priority = 1,
        sign_hl_group = hl_groups[statuses.working_tree],
      })

      vim.api.nvim_buf_set_extmark(buf, oil_gitsigns_ns, line_num - 1, 0, {
        sign_text = statuses.index,
        priority = 2,
        sign_hl_group = hl_groups[statuses.index],
      })

      -- Highlight line when file is git ignored
      if statuses.working_tree == '!' and statuses.index == '!' then
        vim.api.nvim_buf_set_extmark(buf, oil_gitsigns_ns, line_num - 1, 0, {
          line_hl_group = 'OilHidden',
        })
      end
    end
  end
end

---Load git info and add git signs to oil buffer
---@param buf number
function M.load_git_signs(buf)
  vim.system({ 'git', '-c', 'status.relativePaths=true', 'status', '--short', '--ignored', '.' }, {
    cwd = require('oil').get_current_dir(buf),
    text = true,
  }, function(out)
    if out.code ~= 0 then
      return
    end

    vim.schedule(function()
      local items = vim.split(out.stdout, '\n', { trimempty = true })
      vim.b[buf].file_statuses = get_file_statuses(items)

      M.set_signs(buf)
    end)
  end)
end

return M
