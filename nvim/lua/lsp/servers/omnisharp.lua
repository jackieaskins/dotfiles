---@type LspServer
return {
  config = function(config)
    config.settings = {
      FormattingOptions = {
        OrganizeImports = true,
      },
    }
    config.cmd = {
      'dotnet',
      vim.fn.stdpath('data') .. '/lsp-servers/omnisharp-roslyn/OmniSharp.dll',
    }
    config.on_attach = function(client)
      client.server_capabilities.semanticTokensProvider = nil
    end
    return config
  end,
  install = function(servers_dir)
    local install_dir = servers_dir .. '/omnisharp-roslyn'

    -- TODO: Grab based on system
    local zip_file = 'omnisharp-osx-arm64-net6.0.zip'

    local download_base_path = 'https://github.com/OmniSharp/omnisharp-roslyn/releases/download/'
    local releases_path = 'https://api.github.com/repos/OmniSharp/omnisharp-roslyn/releases/latest'

    return {
      'brew install dotnet',
      'rm -rf ' .. install_dir,
      'mkdir ' .. install_dir,
      'omnisharp_version=$(wget -qO- "' .. releases_path .. [[" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')]],
      'wget ' .. download_base_path .. '$omnisharp_version/' .. zip_file,
      'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
      'rm ' .. zip_file,
    }
  end,
}
