local fn = vim.fn
local colors = require('colors')
local highlight = require('utils').highlight

local function get_file_icon_component(filename)
  local icon = require('icons').get_file_icon(filename)
  return icon and icon .. ' ' or ''
end

local function get_bufnr(tabnr)
  local winnr = fn.tabpagewinnr(tabnr)
  local buflist = fn.tabpagebuflist(tabnr)
  return buflist[winnr]
end

function GetTabLine()
  highlight('TabLine', { guifg = colors.blue, guibg = colors.active })
  highlight('TabLineSel', { guifg = colors.active, guibg = colors.blue })

  local num_tabs = fn.tabpagenr('$')
  local current_tabnr = fn.tabpagenr()
  local tabline_components = {}

  local filenames = {}

  for tabnr = 1, num_tabs do
    local bufnr = get_bufnr(tabnr)
    local bufname = fn.fnamemodify(fn.bufname(bufnr), ':t')

    if bufname ~= '' then
      local count = filenames[bufname] or 0
      filenames[bufname] = count + 1
    end
  end

  for tabnr = 1, num_tabs do
    local bufnr = get_bufnr(tabnr)

    local filetype = fn.getbufvar(bufnr, '&filetype')
    local bufname = fn.bufname(bufnr)
    local filename = fn.fnamemodify(bufname, ':t')

    local function get_bufname()
      if filetype == 'NvimTree' then
        return '[Tree]'
      end
      if filetype == 'TelescopePrompt' then
        return '[Telescope]'
      end
      if bufname == '' then
        return '[No Name]'
      end

      if filenames[filename] == 1 then
        return filename
      end

      return fn.pathshorten(fn.fnamemodify(bufname, ':~:.'))
    end

    local modified = fn.getbufvar(bufnr, '&mod') == 1 and filetype ~= 'TelescopePrompt' and ' ' or ''
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
    }

    table.insert(tabline_components, table.concat(components))
  end

  table.insert(tabline_components, '%#TabLineFill#')

  return table.concat(tabline_components)
end

return '%!luaeval("GetTabLine()")'
