require('pairs'):setup({
  enter = {
    enable_mapping = false,
  },
  pairs = {
    ['*'] = {
      { '(', ')' },
      { '[', ']' },
      { '{', '}' },
      { "'", "'" },
      { '"', '"' },
      { '`', '`' },
    },
    html = {},
  },
})
