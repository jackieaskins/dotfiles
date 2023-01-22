return {
  config = function(config)
    config.cmd = { 'dotnet', vim.fn.stdpath('data') .. '/lsp-servers/omnisharp-roslyn/OmniSharp.dll' }
    config.on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      require('lsp.attach')(client, bufnr)
    end
    return config
  end,
  install = function()
    return {}
  end,
}
