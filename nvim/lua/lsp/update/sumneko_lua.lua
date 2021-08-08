local fn = vim.fn

local install_path
if fn.has('mac') == 1 then
  install_path = 'compile/ninja/macos.ninja'
elseif fn.has('unix') == 1 then
  install_path = 'compile/ninja/linux.ninja'
elseif fn.has('win32') == 1 then
  install_path = 'compile/ninja/mingw.ninja'
else
  print('Unsupported system for sumneko')
end

-- TODO: This assumes ninja is already installed
return function()
  local language_server = 'lua-language-server'

  return {
    'rm -rf ' .. language_server,
    'git clone https://github.com/sumneko/' .. language_server,
    'cd ' .. language_server,
    'git submodule update --init --recursive',
    'cd 3rd/luamake',
    'ninja -f ' .. install_path,
    'cd ../..',
    './3rd/luamake/luamake rebuild',
  }
end
