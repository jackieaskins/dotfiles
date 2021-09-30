return function()
  vim.api.nvim_buf_set_keymap(0, 'n', 'e', '<cmd>enew<CR>', { noremap = true })

  return {
    lines = {
      '[e] <empty buffer>',
    },
    align = 'left',
  }
end
