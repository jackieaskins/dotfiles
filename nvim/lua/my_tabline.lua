local fn = vim.fn
local colors = require 'my_colors'
local modes = require 'my_statusline/modes'
local highlight = require'my_utils'.highlight

local function get_file_icon_component(filename)
  local icon = require'my_icons'.get_file_icon(filename, false)
  return icon and icon .. ' ' or ''
end

function GetTabLine()
  highlight('TabLineSel', {guifg = modes.get_color(), guibg = colors.default_bg})
  highlight('TabLine', {guifg = colors.default_fg, guibg = colors.gray1})

  local current_tabnr = fn.tabpagenr()
  local tabline_components = {}

  local filenames = {}

  for tabnr = 1, fn.tabpagenr('$') do
    local winnr = fn.tabpagewinnr(tabnr)
    local buflist = fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local bufname = fn.fnamemodify(fn.bufname(bufnr), ':t')

    if bufname ~= '' then
      local count = filenames[bufname] or 0
      filenames[bufname] = count + 1
    end
  end

  for tabnr = 1, fn.tabpagenr('$') do
    local winnr = fn.tabpagewinnr(tabnr)
    local buflist = fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]

    local filetype = fn.getbufvar(bufnr, '&filetype')
    local bufname = fn.bufname(bufnr)
    local filename = fn.fnamemodify(bufname, ':t')

    local function get_bufname()
      if filetype == 'fzf' then return '[FZF]' end
      if filetype == 'startify' then return '[Startify]' end
      if bufname == '' then return '[No Name]' end

      if filenames[filename] == 1 then return filename end

      return fn.pathshorten(fn.fnamemodify(bufname, ':~:.'))
    end

    local modified = fn.getbufvar(bufnr, '&mod') == 1 and ' ' or ''
    local readonly = fn.getbufvar(bufnr, '&readonly') == 1 and ' ' or ''

    local function set_current_tab(current, other)
      return tabnr == current_tabnr and current or other
    end

    local components = {
      set_current_tab('%#TabLineSel#', '%#TabLine#'),
      ' ',
      tabnr,
      ' ',
      get_file_icon_component(filename),
      get_bufname(),
      modified,
      readonly,
      ' ',
      '%#TabLine#',
    }

    table.insert(tabline_components, table.concat(components))
  end

  return table.concat(tabline_components)
end

return '%!luaeval("GetTabLine()")'
