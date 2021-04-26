local api = vim.api

local paths = {prettier = './node_modules/.bin/prettier', google = './google-java-format.jar'}

local prettier = {
  function()
    return {exe = paths.prettier, args = {'--stdin-filepath', api.nvim_buf_get_name(0)}, stdin = true}
  end
}
local google = {
  function()
    return {exe = 'java', args = {'-jar', paths.google, api.nvim_buf_get_name(0)}, stdin = true}
  end
}

require'formatter'.setup({
  logging = true,
  filetype = {
    java = google,
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier
  }
})

require'my_utils'.augroup('auto_format', {
  {'BufWritePost', '*.java,*.js,*.jsx,*.ts,*.tsx', 'lua require"my_plugins/formatter".format_on_save()'}
})

local M = {}

function M.format_on_save()
  local function file_exists(filepath)
    return vim.fn.glob(filepath) ~= ''
  end

  if #vim.tbl_filter(file_exists, paths) > 0 then
    vim.cmd 'FormatWrite'
  end
end

return M
