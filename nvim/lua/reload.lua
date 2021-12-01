local cmd = vim.cmd

return {
  reload_plugins = function()
    cmd('luafile %')
    cmd('PackerSync')
  end,
}
