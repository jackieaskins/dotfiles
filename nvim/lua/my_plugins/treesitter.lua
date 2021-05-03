require'nvim-treesitter.configs'.setup{
  ensure_installed = 'maintained',
  highlight = { enable = true },
  indent = { enable = true },
  playground = { enable = true },
  context_commentstring = { enable = true },
  autotag = {
    enable = true,
    skip_close_shortcut = '\\>'
  }
}
