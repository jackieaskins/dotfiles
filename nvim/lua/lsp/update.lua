local lsp_servers = require('lsp.servers')

local function get_active_server_names()
  return vim.tbl_map(function(client)
    return client.name
  end, vim.lsp.buf_get_clients(0))
end

local function update_servers(server_list)
  server_list = server_list or get_active_server_names()

  local server_commands = {}
  for _, server in ipairs(server_list) do
    server_commands[server] = lsp_servers.install_commands[server]
  end

  require('installer').install(server_commands, vim.fn.stdpath('data') .. '/lsp-servers')
end

return {
  update_servers = function(server_names)
    update_servers(server_names and vim.split(server_names, ' ') or nil)
  end,
  update_all_servers = function()
    update_servers(lsp_servers.server_names)
  end,
}
