---@type LspServer
return {
  install = function(servers_dir)
    local install_dir = servers_dir .. '/ghostty'
    local zip_file = 'ghostty-ls_aarch64_macos.tar.gz'

    return {
      'rm -rf ' .. install_dir,
      'mkdir ' .. install_dir,
      'wget https://github.com/MKindberg/ghostty-ls/releases/latest/download/' .. zip_file,
      'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
      'rm ' .. zip_file,
    }
  end,
}
