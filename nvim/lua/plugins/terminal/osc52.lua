return {
  'ojroques/nvim-osc52',
  commit = '5e0210990b3c809ec58bbf830e0dabd4bda3a949',
  config = function()
    require('osc52').setup({
      silent = true,
      tmux_passthrough = true,
    })

    local function copy(lines, _)
      require('osc52').copy(table.concat(lines, '\n'))
    end

    local function paste()
      return {
        vim.fn.split(vim.fn.getreg(''), '\n'),
        vim.fn.getregtype(''),
      }
    end

    vim.g.clipboard = {
      name = 'osc52',
      copy = { ['+'] = copy, ['*'] = copy },
      paste = { ['+'] = paste, ['*'] = paste },
    }
  end,
}
