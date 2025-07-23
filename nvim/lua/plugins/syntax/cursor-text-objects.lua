---@type LazySpec
return {
  'ColinKennedy/cursor-text-objects.nvim',
  keys = {
    {
      '[',
      '<Plug>(cursor-text-objects-up)',
      desc = 'Run from your current cursor to the end of the text-object.',
      mode = { 'o', 'x' },
    },
    {
      ']',
      '<Plug>(cursor-text-objects-down)',
      desc = 'Run from your current cursor to the end of the text-object.',
      mode = { 'o', 'x' },
    },
  },
}
