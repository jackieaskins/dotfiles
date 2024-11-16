local function handle_modification(method_suffix, params)
  local clients = vim.lsp.get_clients()

  for _, client in ipairs(clients) do
    local will_rename_method = 'workspace/will' .. method_suffix
    if client.supports_method(will_rename_method) then
      local resp = client.request_sync(will_rename_method, params, 1000, 0)
      if resp and resp.result then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end

    local did_rename_method = 'workspace/did' .. method_suffix
    if client.supports_method(did_rename_method) then
      client.notify(did_rename_method)
    end
  end
end

local M = {}

---Send LSP events when a file is created/deleted
---@param args AutoCmdCallbackArgs
function M.create_or_delete(args)
  local params = {
    files = {
      uri = vim.uri_from_fname(args.data.from or args.data.to),
    },
  }

  local method_suffix = args.event == 'MiniFilesActionCreate' and 'CreateFiles' or 'DeleteFiles'

  handle_modification(method_suffix, params)
end

---Send LSP events when a file is renamed/moved
---@param args AutoCmdCallbackArgs
function M.rename_or_move(args)
  local params = {
    files = {
      {
        oldUri = vim.uri_from_fname(args.data.from),
        newUri = vim.uri_from_fname(args.data.to),
      },
    },
  }

  handle_modification('RenameFiles', params)
end

return M
