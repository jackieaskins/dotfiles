return function(config)
  config.handlers = {
    ['eslint/noLibrary'] = function()
      vim.notify('Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  }

  return config
end
