return {
  'chrisgrieser/nvim-spider',
  keys = vim.tbl_map(function(keys)
    return {
      keys,
      '<cmd>lua require("spider").motion("' .. keys .. '")<CR>',
      mode = { 'n', 'o', 'x' },
      desc = 'Spider-' .. keys,
    }
  end, { 'w', 'e', 'b', 'ge' }),
}
