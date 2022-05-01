-- https://github.com/kyazdani42/nvim-tree.lua

vim.g.nvim_tree_group_empty = 1

require('nvim-tree').setup({
  view = {
    signcolumn = 'no',
    width = 50,
  },
  renderer = {
    indent_markers = { enable = true },
  },
  git = {
    ignore = false,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

local function rename_file(bufnr, data)
  return function()
    local tsserver_client
    for _, client in pairs(vim.lsp.buf_get_clients(bufnr)) do
      if client.name == 'tsserver' then
        tsserver_client = client
      end
    end

    if tsserver_client == nil then
      vim.notify('No tsserver client attached to buffer', vim.log.levels.ERROR)
      return
    end

    local ok = tsserver_client.request('workspace/executeCommand', {
      command = '_typescript.applyRenameFile',
      arguments = {
        {
          sourceUri = vim.uri_from_fname(data.old_name),
          targetUri = vim.uri_from_fname(data.new_name),
        },
      },
    })

    if not ok then
      vim.notify('Tsserver rename failed', vim.log.levels.ERROR)
    end
  end
end

require('nvim-tree.events').on_node_renamed(function(data)
  local tsserver_regex = '[.][tj][s]x?$'

  local file_to_open
  if vim.fn.isdirectory(data.new_name) == 1 then
    local tsserver_files = require('plenary.scandir').scan_dir(data.new_name, {
      hidden = true,
      add_dirs = false,
      respect_gitignore = false,
      search_pattern = tsserver_regex,
    })

    if #tsserver_files > 0 then
      file_to_open = tsserver_files[1]
    end
  elseif data.new_name:match(tsserver_regex) then
    file_to_open = data.new_name
  end

  if file_to_open == nil then
    return
  end

  local choice = vim.fn.confirm('Do you want to update imports for ' .. data.new_name .. '?', '&Yes\n&No', 1)

  if choice ~= 1 then
    return
  end

  local bufnr = vim.fn.bufadd(file_to_open)
  vim.fn.bufload(bufnr)
  vim.fn.setbufvar(bufnr, '&buflisted', 1)

  -- Deferring to give enough time for the client to attach
  vim.defer_fn(rename_file(bufnr, data), 1000)
end)
