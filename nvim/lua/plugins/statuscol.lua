return {
  'luukvbaal/statuscol.nvim',
  opts = {
    separator = ' ',
    -- Hackily add separator between statuscol and buffer text
    -- Note: Only works if fold function is last in 'order' below
    foldfunc = function(...)
      local is_wrapped_line = vim.v.virtnum ~= 0
      local sep = is_wrapped_line and '' or '%#StatusColSep# │ '
      return require('statuscol.builtin').foldfunc(...) .. sep
    end,
    setopt = true,
    order = 'SNsF',
    relculright = true,
    ft_ignore = { 'NvimTree', 'help' },
  },
}
