local cmd = vim.cmd

local pluginsPath = vim.fn.stdpath('config') .. '/lua/plugins.lua'

return {
  reload_plugins = function()
    cmd('luafile ' .. pluginsPath)
    cmd('PackerSync')
  end,
}
