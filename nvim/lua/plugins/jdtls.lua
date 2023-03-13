return {
  'mfussenegger/nvim-jdtls',
  enabled = not vim.g.supported_servers or vim.tbl_contains(vim.g.supported_servers, 'jdtls'),
  config = function()
    require('utils').augroup('jdtls', {
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
