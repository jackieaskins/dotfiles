require('nvim-autopairs').setup({})

if packer_plugins['nvim-compe'] then
  require('nvim-autopairs.completion.compe').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
  })
elseif packer_plugins['nvim-cmp'] then
  require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
    insert = false,
  })
end
