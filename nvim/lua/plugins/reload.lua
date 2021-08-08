local augroup = require('utils').augroup
local cmd = vim.cmd

return {
  reload_plugins = function()
    cmd('Reload')
    augroup('plugin_reload', { { 'User', 'PackerComplete', 'Reload' } })
    cmd('PackerSync')
  end,
}
