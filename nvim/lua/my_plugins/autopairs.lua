require'nvim-autopairs'.setup()

function _G.handle_enter() return require'nvim-autopairs'.autopairs_cr() end

require'my_utils'.map('i', '<CR>', 'v:lua.handle_enter()', {expr = true})
