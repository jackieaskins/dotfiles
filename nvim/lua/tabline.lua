local augroup = require('utils').augroup
local colors = require('colors')
local vi_mode = require('feline.providers.vi_mode')
local highlight = require('utils').highlight

local function get_file_icon_component(filename)
  local icon = require('icons').get_file_icon(filename)
  return icon and icon .. ' ' or ''
end

local function get_bufnr(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  return buflist[winnr]
end

augroup('tabline', {
  { 'ModeChanged', command = 'redrawtabline' },
})

local function get_tabline()
  local mode_color = vi_mode.get_mode_color()

  highlight('TabLineSel', { fg = colors.base, bg = mode_color })
  highlight('tabLineSelSep', { fg = mode_color, bg = colors.base })

  local num_tabs = vim.fn.tabpagenr('$')
  local current_tabnr = vim.fn.tabpagenr()
  local tabline_components = {}

  local filenames = {}

  for tabnr = 1, num_tabs do
    local bufnr = get_bufnr(tabnr)
    local bufname = vim.fn.fnamemodify(vim.fn.bufname(bufnr), ':t')

    if bufname ~= '' then
      local count = filenames[bufname] or 0
      filenames[bufname] = count + 1
    end
  end

  for tabnr = 1, num_tabs do
    local bufnr = get_bufnr(tabnr)

    local filetype = vim.fn.getbufvar(bufnr, '&filetype')
    local bufname = vim.fn.bufname(bufnr)
    local filename = vim.fn.fnamemodify(bufname, ':t')

    local function get_bufname()
      if filetype == 'neo-tree' then
        return 'Tree'
      end
      if filetype == 'TelescopePrompt' then
        return ' Telescope'
      end
      if filetype == 'checkhealth' then
        return 'checkhealth'
      end

      if bufname == '' then
        return '-'
      end

      if filenames[filename] == 1 then
        return filename
      end

      return vim.fn.pathshorten(vim.fn.fnamemodify(bufname, ':~:.'))
    end

    local modified = vim.fn.getbufvar(bufnr, '&mod') == 1 and filetype ~= 'TelescopePrompt' and ' ' or ''
    local readonly = vim.fn.getbufvar(bufnr, '&readonly') == 1 and ' ' or ''

    local function set_current_tab(current, other)
      return tabnr == current_tabnr and current or other
    end

    local components = {
      set_current_tab('%#TabLineSelSep#', '%#TabLineSep#'),
      tabnr == 1 and '' or '',
      set_current_tab('%#TabLineSel#', '%#TabLine#'),
      ' ',
      tabnr,
      ' ',
      get_file_icon_component(filename),
      get_bufname(),
      modified,
      readonly,
      ' ',
      set_current_tab('%#TabLineSelSep#', '%#TabLineSep#'),
      '',
    }

    table.insert(tabline_components, table.concat(components))
  end

  table.insert(tabline_components, '%#TabLineFill#')

  return table.concat(tabline_components)
end

return { get_tabline = get_tabline }
