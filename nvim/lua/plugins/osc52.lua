return {
  'ojroques/nvim-osc52',
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
        ---@diagnostic disable-next-line: param-type-mismatch
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
