return function(config)
  config.on_attach = function(client, bufnr)
    require('lsp/attach')(client, bufnr)

    if client.resolved_capabilities.document_formatting then
      vim.cmd('autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()')
    end
  end
end
