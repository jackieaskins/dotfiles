-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local cmd = vim.cmd
local fn = vim.fn

local eslintls = require'my_lsp/servers/eslintls'
local jdtls = require'my_lsp/servers/jdtls'
local jsonls = require'my_lsp/servers/jsonls'
local sumneko_lua = require'my_lsp/servers/sumneko_lua'
local tsserver = require'my_lsp/servers/tsserver'

local M = {}

local all_servers = {
  eslintls = {
    update = eslintls.update,
  },
  jdtls = {
    configure = jdtls.configure,
    update = jdtls.update,
  },
  jsonls = {
    configure = jsonls.configure,
    update = {'npm', 'vscode-json-languageserver'},
  },
  pyright = {
    update = {'npm', 'pyright'},
  },
  solargraph = {
    update = {'gem', 'solargraph'},
  },
  sumneko_lua = {
    configure = sumneko_lua.configure,
    update = sumneko_lua.update,
  },
  vimls = {
    update = {'npm', 'vim-language-server'},
  },
  tsserver = {
    configure = tsserver.configure,
    update = {'npm', 'typescript typescript-language-server'},
  },
}

function M.setup_servers()
  local lspconfig = require'lspconfig'

  for server, server_info in pairs(all_servers) do
    local base_config = {
      capabilities = require'my_lsp/capabilities',
      on_attach = require'my_lsp/attach'.custom_attach
    }

    local config_func = server_info['configure']
    local config = config_func and config_func(base_config) or base_config

    lspconfig[server].setup(config)
  end
end

local function update_servers(server_list)
  local servers_dir = fn.stdpath('data') .. '/lsp-servers'
  local script_lines = {}

  local function echo(text)
    table.insert(script_lines, string.format('echo "%s"', text))
  end

  local generic_installs = {
    npm = {cmd = 'npm install -g', servers = {}, packages = {}},
    gem = {cmd = 'gem install --user-install', servers = {}, packages = {}}
  }

  for _, server in ipairs(server_list) do
    local server_info = all_servers[server] or {}
    local update = server_info['update']

    if not update then
      print('No update function for ' .. server)
    elseif type(update) == 'function' then
      echo('Installing ' .. server)
      for _, line in ipairs(update(servers_dir)) do
        table.insert(script_lines, line)
      end
      echo ''
    elseif generic_installs[update[1]] ~= nil then
      local install = generic_installs[update[1]]

      table.insert(install.servers, server)
      table.insert(install.packages, update[2])
    else
      print('Invalid update function for ' .. server)
    end
  end

  for _, info in pairs(generic_installs) do
    if not vim.tbl_isempty(info.packages) then
      echo(string.format('echo "Installing packages for %s"', table.concat(info.servers, ', ')))
      table.insert(script_lines, string.format('%s %s', info.cmd, table.concat(info.packages, ' ')))
      echo ''
    end
  end

  local script = table.concat(script_lines, '\n')

  os.execute('mkdir -p ' .. servers_dir)
  cmd 'new | startinsert'
  fn.termopen({'sh', '-c', script}, {cwd = servers_dir})
end

function M.update_servers(server_names)
  update_servers(vim.split(server_names, ' '))
end

function M.update_all_servers()
  update_servers(vim.tbl_keys(all_servers))
end

cmd "command! LspUpdateAll lua require'my_lsp/servers'.update_all_servers()"
cmd "command! -nargs=1 LspUpdate lua require'my_lsp/servers'.update_servers(<f-args>)"

return M
