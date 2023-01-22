return {
  config = function(config)
    config.init_options = {
      configuration = {
        svelte = {
          plugin = {
            svelte = {
              defaultScriptLanguage = 'ts',
            },
          },
        },
      },
    }
    return config
  end,
  install = { 'npm', 'svelte-language-server' },
}
