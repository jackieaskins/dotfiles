return function(config)
  require('utils').augroup_buf('gopls_formatting', {
    {
      'BufWritePre',
      '<buffer>',
      'lua vim.lsp.buf.formatting_sync()',
    },
  })

  return config
end
