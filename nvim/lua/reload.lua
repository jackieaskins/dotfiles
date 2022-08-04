local pluginsPath = vim.fn.stdpath('config') .. '/lua/plugins.lua'

return {
  reload_plugins = function()
    vim.cmd.luafile(pluginsPath)
    vim.cmd.PackerSync()
  end,
}
