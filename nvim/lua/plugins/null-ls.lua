local null_ls = require('null-ls')

null_ls.config({
  sources = {
    null_ls.builtins.formatting.stylua.with({
      condition = function(utils)
        return utils.root_has_file('stylua.toml') and vim.fn.executable('stylua') == 1
      end,
    }),
    null_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.root_has_file('node_modules/prettier')
      end,
    }),
    null_ls.builtins.diagnostics.eslint.with({
      command = 'eslint_d',
      condition = function(utils)
        return utils.root_has_file('node_modules/eslint')
      end,
    }),
  },
})
