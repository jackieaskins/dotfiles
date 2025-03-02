---@type LazySpec
return {
  'mfussenegger/nvim-jdtls',
  config = function()
    require('utils').augroup('jdtls', {
      {
        'FileType',
        pattern = 'java',
        callback = function()
          require('jdtls').start_or_attach({
            capabilities = require('lsp.capabilities')(),
            cmd = { 'jdtls' },
            root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          })
        end,
      },
    })
  end,
}
