return function()
  vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', { noremap = true })

  return {
    lines = {
      '[q] <quit>',
    },
    align = 'left',
  }
end
