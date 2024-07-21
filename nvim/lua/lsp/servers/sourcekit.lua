return {
  config = function(config)
    -- Remove compile_commands.json (use clangd instead)
    -- Maybe should remove c from filetype instead? TBD
    config.root_dir = require('lspconfig').util.root_pattern('buildServer.json', '*.xcodeproj', '*.xcworkspace')
    return config
  end,
}
