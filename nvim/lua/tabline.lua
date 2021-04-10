local fn = vim.fn
local colors = require'colors'
local modes = require'statusline/modes'

function GetTabLine()
  vim.cmd('highlight TabLineSel guifg=' .. modes.get_color() .. ' guibg=' .. colors.gray1)

  local current_tabnr = fn.tabpagenr()
  local tabline_components = {}

  local filenames = {}

  for tabnr=1,fn.tabpagenr('$') do
    local winnr = fn.tabpagewinnr(tabnr)
    local buflist = fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]
    local bufname = fn.fnamemodify(fn.bufname(bufnr), ':t')

    if bufname ~= '' then
      local count = filenames[bufname] or 0
      filenames[bufname] = count + 1
    end
  end

  for tabnr=1,fn.tabpagenr('$') do
    local winnr = fn.tabpagewinnr(tabnr)
    local buflist = fn.tabpagebuflist(tabnr)
    local bufnr = buflist[winnr]

    local function get_bufname()
      local filetype = fn.getbufvar(bufnr, '&filetype')
      local bufname = fn.bufname(bufnr)
      local filename = fn.fnamemodify(bufname, ':t')

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
      set_current_tab('▊ ', ' '),
      set_current_tab('', tabnr .. ' '),
      get_bufname(),
      modified,
      readonly,
      ' ',
      '%#TabLine#'
    }

    table.insert(tabline_components, table.concat(components))
  end

  return table.concat(tabline_components)
end

return '%!luaeval("GetTabLine()")'
