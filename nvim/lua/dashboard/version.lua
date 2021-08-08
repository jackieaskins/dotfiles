return function()
  local version = vim.version()

  return {
    align = 'center',
    lines = {
      table.concat({
        'Version: ',
        version.major,
        '.',
        version.minor,
        '.',
        version.patch,
        version.api_prerelease and '-dev' or '',
      }, ''),
    },
  }
end
