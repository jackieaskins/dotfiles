local fn = vim.fn

local max_items = 10
local ignore_list = {
  'runtime/doc/.*\\.txt$',
  'bundle/.*/doc/.*\\.txt$',
  'plugged/.*/doc/.*\\.txt$',
  '/.git/',
  'fugitiveblame$',
  fn.escape(fn.fnamemodify(fn.resolve('$VIMRUNTIME'), ':p'), '\\') .. 'doc/.*\\.txt$',
}

local function is_valid(filename, cwd)
  if fn.filereadable(filename) == 0 or not vim.startswith(filename, cwd) then
    return false
  end

  for _, reg in ipairs(ignore_list) do
    if vim.regex(reg):match_str(filename) then
      return false
    end
  end

  return true
end

return function()
  local oldfiles = vim.api.nvim_get_vvar('oldfiles')
  local cwd = fn.fnamemodify(fn.getcwd(), ':p')

  local lines = {
    'MRU in ' .. cwd,
    '',
  }

  local index = 0
  for _, oldfile in ipairs(oldfiles) do
    local absolute_path = fn.fnamemodify(oldfile, ':p')

    if is_valid(absolute_path, cwd) then
      local filename = fn.substitute(oldfile, cwd, '', '')
      table.insert(lines, '[' .. index .. '] ' .. filename)
      vim.api.nvim_buf_set_keymap(0, 'n', tostring(index), '<cmd>edit ' .. filename .. '<CR>', { noremap = true })
      index = index + 1
    end

    if index >= max_items then
      break
    end
  end

  return {
    align = 'left',
    lines = lines,
  }
end
