local fn = vim.fn

local M = {}

function M.get_file_icon(path, default)
  if default == nil then
    default = true
  end

  local filename = fn.fnamemodify(path, ':t')
  local extension = fn.fnamemodify(path, ':e')

  if filename == '' then
    return ''
  end

  if filename == 'vimrc' then
    filename = '.vimrc'
  end
  if filename == 'zshrc' then
    filename = '.zshrc'
  end

  return require('nvim-web-devicons').get_icon(filename, extension, { default = default }) or ''
end

return M
