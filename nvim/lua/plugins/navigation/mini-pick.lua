---@type LazySpec
return {
  'echasnovski/mini.pick',
  enabled = MY_CONFIG.picker == 'mini.pick',
  event = 'VeryLazy',
  dependencies = { 'echasnovski/mini.extra', config = true },
  keys = function()
    local keys = {
      -- Buffers and Files
      { '<leader>bu', 'buffers' },
      { '<C-p>', 'files' },
      { '<leader>of', 'oldfiles current_dir=true' },

      -- Search
      { '<leader>fw', 'grep pattern="<cword>"' },
      { '<leader>fW', 'grep pattern="<cWORD>"' },
      { '<leader>/', 'grep_live' },

      -- Git
      { '<leader>gs', 'git_hunks' },
      { '<leader>gl', 'git_commits' },
      { '<leader>gL', 'git_commits path="%"' },

      -- LSP
      { '<leader>sd', 'lsp scope="document_symbol"' },
      { '<leader>sw', 'lsp scope="workspace_symbol"' },
      { 'gr', 'lsp scope="references"' },
      { 'gd', 'lsp scope="definition"' },
      { 'gD', 'lsp scope="declaration"' },
      { 'gi', 'lsp scope="implementation"' },

      -- Diagnostics
      { '<leader>wd', 'diagnostic' },

      -- Misc
      { '<leader>.', 'resume' },
      { '<leader>ht', 'help default_split="vertical"' },
      { '<leader>hi', 'hl_groups' },
      { '<leader>km', 'keymaps' },
      { '<leader>z=', 'spellsuggest' },
    }

    return vim.tbl_map(function(map)
      return { map[1], '<cmd>Pick ' .. map[2] .. '<CR>' }
    end, keys)
  end,
  config = function()
    require('mini.pick').setup({
      window = {
        config = { border = MY_CONFIG.border_style },
      },
    })

    vim.ui.select = MiniPick.ui_select
  end,
}
