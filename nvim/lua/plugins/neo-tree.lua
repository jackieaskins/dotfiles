local neotree = require('neo-tree')

vim.g.neo_tree_remove_legacy_commands = 1

-- Rename Handler {{{
local function rename_file(bufnr, source, destination)
  return function()
    local tsserver_client
    for _, client in pairs(vim.lsp.get_active_clients({ buffer = bufnr })) do
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
          sourceUri = vim.uri_from_fname(source),
          targetUri = vim.uri_from_fname(destination),
        },
      },
    })

    if not ok then
      vim.notify('Tsserver rename failed', vim.log.levels.ERROR)
    end
  end
end

local function handle_rename(data)
  local source = data.source
  local destination = data.destination
  local tsserver_regex = '[.][tj][s]x?$'

  local file_to_open
  if vim.fn.isdirectory(destination) == 1 then
    local tsserver_files = require('plenary.scandir').scan_dir(destination, {
      hidden = true,
      add_dirs = false,
      respect_gitignore = false,
      search_pattern = tsserver_regex,
    })

    if #tsserver_files > 0 then
      file_to_open = tsserver_files[1]
    end
  elseif destination:match(tsserver_regex) then
    file_to_open = destination
  end

  if file_to_open == nil then
    return
  end

  local choice = vim.fn.confirm('Do you want to update imports for ' .. destination .. '?', '&Yes\n&No', 1)

  if choice ~= 1 then
    return
  end

  local bufnr = vim.fn.bufadd(file_to_open)
  vim.fn.bufload(bufnr)
  vim.fn.setbufvar(bufnr, '&buflisted', 1)

  -- Deferring to give enough time for the client to attach
  vim.defer_fn(rename_file(bufnr, source, destination), 1000)
end
-- }}}

neotree.setup({
  close_if_last_window = true,
  default_component_configs = {
    icon = { folder_empty = '' },
    indent = { with_expanders = true },
    modified = { highlight = 'Normal' },
  },
  event_handlers = {
    { event = 'file_renamed', handler = handle_rename },
    { event = 'file_moved', handler = handle_rename },
    {
      event = 'file_opened',
      handler = function()
        neotree.close_all()
      end,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      never_show = { '.DS_Store' },
    },
    find_by_full_path_words = true,
    group_empty_dirs = true,
    window = {
      mapping_options = { nowait = true },
      mappings = {
        -- Clean up defaults (default behavior indicated in comment)
        ['<BS>'] = 'none', -- Moves the root directory up a level
        s = 'none', -- Open in vertical split
        S = 'none', -- Open in horizontal split
        t = 'none', -- Open in new tab
        ['[g'] = 'none', -- Go to previous git modified file
        [']g'] = 'none', -- Go to next git modified file
        ['/'] = 'none', -- Trigger fuzzy filtering

        -- New mappings
        m = { 'move', config = { show_path = 'relative' } },
        o = 'open',
        ['<CR>'] = 'open',
        ['<C-v>'] = 'open_vsplit',
        ['<C-x>'] = 'open_split',
        ['<C-t>'] = 'open_tabnew',
        ['[c'] = 'prev_git_modified',
        [']c'] = 'next_git_modified',
        ['<tab>'] = 'toggle_preview',
      },
    },
  },
  popup_border_style = 'rounded',
})

-- vim:foldmethod=marker foldlevel=0
