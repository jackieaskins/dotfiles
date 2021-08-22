local cmd, fn = vim.cmd, vim.fn
local utils = require('utils')

local M = {}

local cursor_lines = {}
local current_line = -1
local left_pad = 2
local cursor_column = 4

function M.show(on_vimenter)
  if on_vimenter == 1 then
    -- Don't open dashboard if opened with file or buffer has text
    if fn.argc() ~= 0 or fn.line2byte('$') ~= -1 then
      return
    end

    -- Handle vim -y, vim -M.
    if vim.o.insertmode or not vim.o.modifiable then
      return
    end
  end

  if fn.line2byte('$') ~= -1 then
    cmd('noautocmd enew')
  end

  vim.b.qs_local_disable = 1
  local settings = table.concat({
    'bufhidden=wipe',
    'colorcolumn=',
    'foldcolumn=0',
    'matchpairs=',
    'modifiable',
    'nobuflisted',
    'nocursorcolumn',
    'nocursorline',
    'nolist',
    'nonumber',
    'noreadonly',
    'norelativenumber',
    'nospell',
    'noswapfile',
    'signcolumn=no',
    'synmaxcol&',
    'filetype=my_dashboard',
  }, ' ')
  cmd('setlocal ' .. settings)

  local spacer = { lines = { '' }, align = 'left' }
  local sections = {
    require('dashboard.header')(),
    require('dashboard.version')(),
    spacer,
    spacer,
    require('dashboard.mru')(),
    spacer,
    require('dashboard.quit')(),
  }

  local width = fn.winwidth(0)
  local longest_line_length = math.max(unpack(vim.tbl_map(function(section)
    return math.max(unpack(vim.tbl_map(function(line)
      return fn.strwidth(line)
    end, section.lines)))
  end, sections)))
  left_pad = math.max((width - longest_line_length) / 2, 2)
  cursor_column = math.floor(left_pad) + 2

  local function align_left(line)
    return string.rep(' ', left_pad) .. line
  end

  local function align_center(line)
    return string.rep(' ', math.max((width - fn.strwidth(line)) / 2, 2)) .. line
  end

  local dashboard = {}
  for _, section in ipairs(sections) do
    local align = section.align

    for _, line in ipairs(section.lines) do
      table.insert(dashboard, align == 'left' and align_left(line) or align_center(line))
    end
  end

  local height = fn.winheight('%') - 1

  -- Pad top of buffer to center dashboard
  if #dashboard < height then
    local prerows = (height - #dashboard) / 2
    local counter = 0
    while counter < prerows do
      table.insert(dashboard, 1, '')
      counter = counter + 1
    end
  end

  -- Pad bottom of centered dashboard
  while #dashboard < height do
    table.insert(dashboard, '')
  end

  for _, line in ipairs(dashboard) do
    local valid_line = vim.regex('\\[.*\\] .*'):match_str(line) ~= nil
    table.insert(cursor_lines, valid_line)
  end
  fn.append('$', dashboard)

  utils.augroup_buf('dashboard_buf', {
    { 'CursorMoved', '<buffer>', 'lua require("dashboard").set_cursor()' },
    { 'VimResized', '<buffer>', 'lua require("dashboard").show()' },
  })

  vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', '<cmd>call feedkeys(expand("<cword>"))<CR>', { noremap = true })

  cmd('setlocal nomodified nomodifiable')
end

function M.set_cursor()
  local new_line = fn.line('.') - 1
  local new_col = fn.col('.')
  local height = fn.winheight('%') - 1

  if not cursor_lines[new_line] then
    local previous_line = -1
    local next_line = -1

    local pointer = new_line - 1
    while pointer > 0 and previous_line == -1 do
      if cursor_lines[pointer] then
        previous_line = pointer
      end
      pointer = pointer - 1
    end
    pointer = new_line + 1
    while pointer <= height and next_line == -1 do
      if cursor_lines[pointer] then
        next_line = pointer
      end
      pointer = pointer + 1
    end

    if current_line == -1 then
      new_line = previous_line == -1 and next_line or previous_line
    elseif new_line > current_line or new_col > cursor_column then
      new_line = next_line == -1 and current_line or next_line
    elseif new_line < current_line or new_col < cursor_column then
      new_line = previous_line == -1 and current_line or previous_line
    else
      new_line = current_line
    end
  end

  local first_valid = -1
  local last_valid = -1
  for index, is_valid in ipairs(cursor_lines) do
    local line = index
    if is_valid then
      if first_valid == -1 then
        first_valid = line
      end
      last_valid = line
    end
  end

  if new_line < first_valid then
    current_line = first_valid
  elseif new_line > last_valid then
    current_line = last_valid
  else
    current_line = new_line
  end

  fn.cursor({ current_line + 1, cursor_column })
end

return M
