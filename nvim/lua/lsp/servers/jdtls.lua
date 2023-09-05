---@type LspServer
return {
  install = function(servers_dir)
    local install_dir = servers_dir .. '/eclipse.jdt.ls'
    local zip_file = 'jdt-language-server-latest.tar.gz'

    return {
      'rm -rf ' .. install_dir,
      'mkdir ' .. install_dir,
      'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
      'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
      'rm ' .. zip_file,
      'cd ' .. install_dir .. '/plugins',
      'wget https://projectlombok.org/downloads/lombok.jar',
    }
  end,
  skip_lspconfig = true,
}
