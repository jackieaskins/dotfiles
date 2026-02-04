---@type LazySpec
return {
  's1n7ax/nvim-comment-frame',
  keys = { '<leader>cf', '<leader>cF' },
  config = function()
    require('nvim-comment-frame').setup({
      keymap = '<leader>cf',
      multiline_keymap = '<leader>cF',
      languages = {
        tmux = { start_str = '#', end_str = '#' },
        sh = { start_str = '#', end_str = '#' },
        vim = { start_str = '"', end_str = '"' },
        zsh = { start_str = '#', end_str = '#' },
      },
    })
  end,
}
