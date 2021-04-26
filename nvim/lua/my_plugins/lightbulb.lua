require'my_utils'.augroup('lightbulb', {
  {
    'CursorHold,CursorHoldI',
    '*',
    "lua require'nvim-lightbulb'.update_lightbulb()",
  }
})
