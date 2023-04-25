vim.cmd.Lazy('load vimux')

---@type Runner
local tmux = {}

function tmux.open_runner()
  vim.cmd.VimuxOpenRunner()
end

function tmux.toggle_pane()
  vim.cmd.VimuxTogglePane()
end

function tmux.close_runner()
  vim.cmd.VimuxCloseRunner()
end

function tmux.interrupt_runner()
  vim.cmd.VimuxInterruptRunner()
end

function tmux.run_command(command)
  vim.fn.VimuxRunCommand(command)
end

function tmux.run_last_command()
  vim.cmd.VimuxRunLastCommand()
end

function tmux.clear_terminal_screen()
  vim.cmd.VimuxClearTerminalScreen()
end

return tmux
