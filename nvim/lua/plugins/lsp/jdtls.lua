---@type LazySpec
return {
  'mfussenegger/nvim-jdtls',
  enabled = require('lsp.utils').is_server_supported('jdtls'),
  config = function()
    require('utils').augroup('jdtls', {
      {
        'FileType',
        pattern = 'java',
        callback = function()
          require('jdtls').start_or_attach({
            capabilities = require('lsp.capabilities').get_capabilities(),
            cmd = { 'jdtls' },
            root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          })
        end,
      },
    })
  end,
}
