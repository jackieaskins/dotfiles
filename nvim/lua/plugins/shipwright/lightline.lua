local config = require('onenord.config').options
local colors = vim.tbl_deep_extend('force', require('colors'), config.custom_colors)
local overwrite = require('shipwright.transform.overwrite')

local function prepend_file_header(highlights)
  local lines = {
    '',
    '"--------------------------------------------------------------------"',
    '"                   onenord lightline colorscheme                    "',
    '"              Extracted from onenord.nvim by rmehri01               "',
    '"              https://github.com/rmehri01/onenord.nvim              "',
    '"--------------------------------------------------------------------"',
    '',
    "let s:p = {'normal': {}, 'insert': {}, 'command': {}, 'visual': {}, 'replace': {}, 'inactive': {}, 'tabline': {}}",
    '',
  }

  return vim.list_extend(lines, highlights)
end

local function to_lightline(lualine)
  local highlights = {}
  for group, sections in pairs(lualine) do
    local left = {}

    table.insert(left, string.format("[ '%s', '%s' ]", sections.a.fg, sections.a.bg))
    table.insert(left, string.format("[ '%s', '%s' ]", sections.b.fg, sections.b.bg))
    if sections.c then
      table.insert(left, string.format("[ '%s', '%s' ]", sections.c.fg, sections.c.bg))
    end
    left = table.concat(left, ', ')

    table.insert(highlights, string.format('let s:p.%s.left = [ %s ]', group, left))
    table.insert(
      highlights,
      string.format("let s:p.%s.middle = [ [ '%s', '%s' ] ]", group, colors.light_gray, colors.active)
    )
    table.insert(highlights, string.format('let s:p.%s.right = [ %s ]', group, left))
    table.insert(highlights, '')

    if group == 'normal' then
      table.insert(
        highlights,
        string.format("let s:p.tabline.left = [ [ '%s', '%s' ] ]", colors.fg_light, colors.selection)
      )
      table.insert(highlights, string.format('let s:p.tabline.right = [ %s ]', left))
      table.insert(highlights, string.format('let s:p.tabline.tabsel = [ %s ]', left))
      table.insert(highlights, '')
    end
  end

  table.insert(highlights, 'let g:lightline#colorscheme#onenord#palette = lightline#colorscheme#fill(s:p)')

  return highlights
end

return {
  require('lualine.themes.onenord'),
  to_lightline,
  prepend_file_header,
  { overwrite, vim.fn.expand('~/dotfiles/vim/autoload/lightline/colorscheme/onenord.vim') },
}
