return function(config)
  config.on_attach = function(client, bufnr)
    require('lsp/attach')(client, bufnr)

    if client.resolved_capabilities.document_formatting then
      vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end
  end
end
