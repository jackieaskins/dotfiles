local augroup = require('utils').augroup
local highlight = require('utils').highlight

local function get_bufnr(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  return buflist[winnr]
end

augroup('tabline', {
  { 'ModeChanged', command = 'redrawtabline' },
})

local function get_tabline()
  local colors = require('colors').get_colors()
  highlight('TabLineSel', { fg = colors.base, bg = require('modes').get_color() })

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
      if bufname == '' then
        return '[No Name]'
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
      set_current_tab('%#TabLineSel#', '%#TabLine#'),
      ' ',
      tabnr,
      ' ',
      require('icons').get_filetype_icon(filetype) .. ' ',
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

return { get_tabline = get_tabline }
