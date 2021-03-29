local M = {}

function M.configure(config)
  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require'lsp/attach'.custom_attach(client, bufnr)
  end
  return config
end

return M
