local M = {}

---Return whether the provided lsp server is supported
---@param server string
---@return boolean
function M.is_server_supported(server)
  return not vim.g.supported_servers or vim.tbl_contains(vim.g.supported_servers, server)
end

---Return lsp server display name or default server name
---@param server_name string
---@return string
function M.get_server_display_name(server_name)
  return require('lsp.servers')[server_name].display or server_name
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
        client.request(
          method,
          vim.tbl_extend('force', vim.lsp.util.make_position_params(), { kind = 'autoClose' }),
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
