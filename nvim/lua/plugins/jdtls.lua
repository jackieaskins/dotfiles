local utils = require('utils')

return {
  'mfussenegger/nvim-jdtls',
  enabled = utils.is_lsp_server_supported('jdtls'),
  config = function()
    utils.augroup('jdtls', {
      {
        'FileType',
        pattern = 'java',
        callback = function()
          local jdtls_path = vim.fn.stdpath('data') .. '/lsp-servers/eclipse.jdt.ls'

          local config = vim.tbl_extend('force', require('lsp.base_config')(), {
            cmd = { jdtls_path .. '/bin/jdtls' },
            init_options = {
              bundles = {
                jdtls_path .. '/plugins/lombok.jar',
              },
            },
            root_dir = vim.fs.dirname(vim.fs.find({ '.gradlew', '.git', 'mvnw' }, { upward = true })[1]),
          })

          require('jdtls').start_or_attach(config)
        end,
      },
    })
  end,
}
