---@class Runner
---@field open_runner fun()
---@field toggle_pane fun()
---@field close_runner fun()
---@field interrupt_runner fun()
---@field run_command fun(command: string): nil
---@field run_last_command fun()
---@field clear_terminal_screen fun()

if vim.fn.exists('$TMUX') == 1 then
  return require('runner.tmux')
end

local term = vim.fn.getenv('TERM')

if term:find('wezterm') then
  return require('runner.wezterm')
end

vim.notify('No runner configured for terminal type', vim.log.levels.ERROR)
