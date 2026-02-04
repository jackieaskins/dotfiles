---@type LazySpec
return {
  'ysmb-wtsg/in-and-out.nvim',
  keys = {
    {
      '<C-o>',
      function()
        require('in-and-out').in_and_out()
      end,
      mode = 'i',
    },
  },
  config = function()
    require('in-and-out').setup({})
  end,
}
