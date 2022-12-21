return {
  'rmagatti/goto-preview',
  config = function()
    require('goto-preview').setup({
      default_mappings = true,
      border = { '↖', '─', '╮', '│', '╯', '─', '╰', '│' },
    })
  end,
  keys = { 'gpd', 'gpi', 'gpr', 'gP' },
}
