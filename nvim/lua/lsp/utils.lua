local utils = require('utils')

local M = {}

---@class LspServer
---@field display? string
---@field skip_lspconfig? boolean

---@type table<string, LspServer>
local supported_servers
---Get list of supported servers
---@return table<string, LspServer>
function M.get_supported_servers()
  if supported_servers then
    return supported_servers
  end

  supported_servers = require('utils').import_json_file('~/dotfiles/nix/home/modules/neovim/lsp-servers.json')

  return supported_servers
end

---Return lsp server display name or default server name
---@param server_name string
---@return string
function M.get_server_display_name(server_name)
  local server = M.get_supported_servers()[server_name]
  return server and server.display or server_name
end

---Configure auto-close tag support for HTML & Svelte servers
---@param client vim.lsp.Client
---@param bufnr number
---@param method string
function M.setup_auto_close_tag(client, bufnr, method)
  local function auto_insert(key)
    return function()
      vim.schedule(function()
        client:request(
          method,
          vim.tbl_extend('force', vim.lsp.util.make_position_params(0, client.offset_encoding), { kind = 'autoClose' }),
          function(_, result)
            if result then
              utils.snippet_expand(result)
            end
          end,
          bufnr
        )
      end)

      return key
    end
  end

  local bsk = utils.buffer_map(bufnr)
  bsk('i', '>', auto_insert('>'), { expr = true })
  bsk('i', '/', auto_insert('/'), { expr = true })
end

---Send auto-insert command, for example for autotag in tsgo
---@param client vim.lsp.Client
---@param bufnr number
---@param key string
function M.setup_vs_code_auto_insert(client, bufnr, key)
  local bsk = utils.buffer_map(bufnr)

  bsk('i', key, function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    local params = {
      _vs_textDocument = { uri = vim.uri_from_bufnr(bufnr) },
      _vs_position = { line = row - 1, character = col + 1 },
      _vs_ch = key,
      _vs_options = {
        tabSize = vim.bo[bufnr].tabstop,
        insertSpaces = vim.bo[bufnr].expandtab,
      },
    }

    vim.schedule(function()
      client:request(
        ---@diagnostic disable-next-line: param-type-mismatch
        'textDocument/_vs_onAutoInsert',
        params,
        function(err, result, _)
          if err or not result then
            return
          end

          utils.snippet_expand(result._vs_textEdit.newText)
        end,
        bufnr
      )
    end)

    return key
  end, { expr = true })
end

return M
