return function(config)
  config.root_dir = require('lspconfig').util.root_pattern('./node_modules/eslint')
end
