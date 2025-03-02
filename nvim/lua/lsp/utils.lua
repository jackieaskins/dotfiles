local M = {}

local supported_servers
---Get list of supported servers
---@return string[]
function M.get_supported_servers()
  if supported_servers then
    return supported_servers
  end

  local lsp_servers = require('utils').import_json_file('~/dotfiles/nix/lsp-servers.json')

  supported_servers = vim.list_extend(vim.tbl_keys(lsp_servers), vim.tbl_keys(MY_CONFIG.additional_server_configs))
  return supported_servers
end

---Return lsp server display name or default server name
---@param server_name string
---@return string
function M.get_server_display_name(server_name)
  local server = require('lsp.servers')[server_name]
  return server and server.display or server_name
end

---Configure auto-close tag support for HTML & Svelte servers
---@param client vim.lsp.Client
---@param bufnr number
---@param method string
function M.setup_auto_close_tag(client, bufnr, method)
  local bsk = require('utils').buffer_map(bufnr)

  local function auto_insert(key)
    return function()
      vim.schedule(function()
        client:request(
          method,
          vim.tbl_extend('force', vim.lsp.util.make_position_params(0, client.offset_encoding), { kind = 'autoClose' }),
          function(_, result)
            if result then
              require('utils').snippet_expand(result)
            end
          end,
          bufnr
        )
      end)

      return key
    end
  end

  bsk('i', '>', auto_insert('>'), { expr = true })
  bsk('i', '/', auto_insert('/'), { expr = true })
end

return M
