return function(config)
  require('utils').augroup('gopls_formatting', {
    {
      'BufWritePre',
      { buffer = 0, callback = vim.lsp.buf.formatting_sync },
    },
  })

  return config
end
