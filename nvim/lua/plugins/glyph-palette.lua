vim.api.nvim_exec([[
  augroup glyph_palette
    autocmd! *
    autocmd FileType NvimTree call glyph_palette#apply()
  augroup END
]], true)
