local cmd = vim.cmd

return {
  reload_plugins = function()
    cmd('Reload')
    cmd('PackerSync')
  end,
}
