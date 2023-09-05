---@type LspServer
return {
  display = 'emmet-ls',
  install = { 'npm', '@olrtg/emmet-language-server' },
  config = function(config)
    -- Removing svelte since svelte-language-server has its own emmet integration
    config.filetypes = {
      'astro',
      'css',
      'eruby',
      'html',
      'htmldjango',
      'javascriptreact',
      'less',
      'pug',
      'sass',
      'scss',
      'typescriptreact',
      'vue',
    }

    return config
  end,
}
