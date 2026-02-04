---@type LazySpec
return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  branch = 'main',
  lazy = false,
  config = function()
    require('nvim-treesitter-textobjects').setup({
      select = {
        enable = true,
        lookahead = true,
      },
    })
  end,
  keys = function()
    local objects = { a = 'parameter', F = 'call', f = 'function', c = 'class', l = 'loop' }

    return vim.iter(objects):fold({}, function(accum, key, textobject)
      local function get_keymap(prefix, suffix)
        return {
          prefix .. key,
          function()
            require('nvim-treesitter-textobjects.select').select_textobject(
              '@' .. textobject .. '.' .. suffix,
              'textobjects'
            )
          end,
          mode = { 'x', 'o' },
        }
      end

      table.insert(accum, get_keymap('i', 'inner'))
      table.insert(accum, get_keymap('a', 'outer'))

      return accum
    end)
  end,
}
