return {
  'mfussenegger/nvim-jdtls',
  enabled = require('lsp.utils').is_server_supported('jdtls'),
  config = function()
    require('utils').augroup('jdtls', {
      {
        'FileType',
        pattern = 'java',
        callback = function()
          local jdtls_path = vim.fn.stdpath('data') .. '/lsp-servers/eclipse.jdt.ls'

          require('jdtls').start_or_attach({
            capabilities = require('lsp.capabilities')(),
            cmd = { jdtls_path .. '/bin/jdtls' },
            init_options = {
              bundles = {
                jdtls_path .. '/plugins/lombok.jar',
              },
            },
            root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          })
        end,
      },
    })
  end,
}
