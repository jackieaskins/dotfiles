local fn = vim.fn

local uri = fn.expand('%')
if vim.startswith(uri, 'jdt://') then
  local buf = vim.api.nvim_get_current_buf()

  local function get_java_client()
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.name == 'jdtls' then
        return client
      end
    end
  end

  local function notify_err(msg)
    vim.notify(msg, vim.log.levels.ERROR)
  end

  local client = get_java_client()

  if not client then
    return notify_err('No JDTLS client exists')
  end

  local response, err = client.request_sync('java/classFileContents', { uri = uri }, 5000)

  if err then
    return notify_err('An error occurred retrieving class file contents: ' .. err)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response.result, '\n', true))
end
