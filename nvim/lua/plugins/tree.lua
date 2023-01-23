return {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<C-n>', vim.cmd.NvimTreeToggle, desc = 'NvimTreeToggle' },
    { '<leader>n', vim.cmd.NvimTreeFindFileToggle, desc = 'NvimTreeFindFileToggle' },
  },
  config = function()
    require('nvim-tree').setup({
      actions = {
        open_file = { quit_on_open = true },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      filters = { custom = { '^.git$' } },
      git = { ignore = false },
      renderer = {
        full_name = true,
        group_empty = true,
        highlight_git = true,
        icons = { git_placement = 'after' },
        indent_markers = { enable = true },
      },
      view = {
        centralize_selection = true,
        width = { max = 50 },
      },
    })

    local events = require('nvim-tree.api').events
    events.subscribe(events.Event.NodeRenamed, function(data)
      local old_uri = vim.uri_from_fname(data.old_name)
      local new_uri = vim.uri_from_fname(data.new_name)

      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name == 'tsserver' then
          client.request('workspace/executeCommand', {
            command = '_typescript.applyRenameFile',
            arguments = {
              { sourceUri = old_uri, targetUri = new_uri },
            },
          })
        else
          client.notify('workspace/didRenameFiles', {
            files = {
              { oldUri = old_uri, newUri = new_uri },
            },
          })
        end
      end
    end)
  end,
}
