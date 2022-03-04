local config = require('onenord.config').options
local colors = vim.tbl_deep_extend('force', require('colors'), config.custom_colors)
local overwrite = require('shipwright.transform.overwrite')

local function get_onenord_highlights()
  local theme = require('onenord.theme')

  local base_highlights = theme.highlights(colors, config)
  return vim.tbl_deep_extend('force', base_highlights, config.custom_highlights)
end

local function to_vimscript(groups)
  local vimscript = {}

  local sorted_group_names = vim.tbl_keys(groups)
  table.sort(sorted_group_names)

  for _, group_name in pairs(sorted_group_names) do
    local hls = groups[group_name]

    local style = hls.style or 'NONE'
    table.insert(
      vimscript,
      table.concat({
        'highlight',
        group_name,
        string.format('guifg=%s', hls.fg or 'NONE'),
        string.format('guibg=%s', hls.bg or 'NONE'),
        string.format('guisp=%s', hls.sp or ''),
        string.format('gui=%s', style),
        string.format('cterm=%s', style),
        string.format('term=%s', style),
      }, ' ')
    )

    if hls.link then
      table.insert(vimscript, 'highlight! link ' .. group_name .. ' ' .. hls.link)
    end
  end

  return vimscript
end

local function prepend_file_header(highlights)
  local lines = {
    '',
    '"--------------------------------------------------------------------"',
    '"                        onenord colorscheme                         "',
    '"              Extracted from onenord.nvim by rmehri01               "',
    '"              https://github.com/rmehri01/onenord.nvim              "',
    '"--------------------------------------------------------------------"',
    '',
    'highlight clear',
    '',
    "if exists('syntax_on')",
    '  syntax reset',
    'endif',
    '',
    'set background=dark',
    "let g:colors_name = 'onenord'",
  }

  return vim.list_extend(lines, highlights)
end

local function add_ansi_colors(lines)
  local ansi_colors = {
    colors.float,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.purple,
    colors.cyan,
    colors.fg,
    colors.selection,
    colors.red,
    colors.green,
    colors.yellow,
    colors.blue,
    colors.light_purple,
    colors.light_green,
    colors.fg_light,
  }

  local ansi_color_lines = {
    '',
    'let g:terminal_ansi_colors = [',
  }

  for _, color in ipairs(ansi_colors) do
    table.insert(ansi_color_lines, string.format("      \\ '%s',", color))
  end

  table.insert(ansi_color_lines, '      \\ ]')
  table.insert(ansi_color_lines, '')

  return vim.list_extend(ansi_color_lines, lines)
end
return {
  get_onenord_highlights(),
  to_vimscript,
  add_ansi_colors,
  prepend_file_header,
  { overwrite, vim.fn.expand('~/dotfiles/vim/colors/onenord.vim') },
}
