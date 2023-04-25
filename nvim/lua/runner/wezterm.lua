local runner_height = '40'

local existing_pane_id = nil
local last_command = nil
local visible = true

---@return 'right' | 'bottom'
local function get_direction()
  return vim.go.columns > 160 and 'right' or 'bottom'
end

local function wezterm_cli(args)
  return vim.trim(vim.fn.system('wezterm cli ' .. table.concat(args, ' ')))
end

local function pane_exists()
  if not existing_pane_id then
    return false
  end

  local panes = vim.json.decode(wezterm_cli({ 'list', '--format=json' })) or {}

  for _, pane in ipairs(panes) do
    if tostring(pane.pane_id) == existing_pane_id then
      return true
    end
  end

  return false
end

---@param name 'interrupt' | 'clear'
local function set_user_var(name)
  if not existing_pane_id then
    return
  end

  -- https://wezfurlong.org/wezterm/recipes/passing-data.html#user-vars
  -- See ~/dotfiles/wezterm/nvim_user_vars.lua
  local encoded_id = vim.trim(vim.fn.system('echo -n ' .. existing_pane_id .. ' | base64'))
  io.write(string.format('\x1b]1337;SetUserVar=nvim-%s=%s\007', name, encoded_id))
end

local function split_pane(move_pane)
  local dir = get_direction()
  local activate_dir = dir == 'bottom' and 'Up' or 'Left'

  existing_pane_id = wezterm_cli({
    'split-pane',
    '--percent=' .. runner_height,
    '--' .. dir,
    move_pane and '--move-pane-id=' .. existing_pane_id or '',
  })

  -- split-pane focuses the new pane, use activate-pane-direction to go back to nvim pane
  wezterm_cli({ 'activate-pane-direction', activate_dir })

  visible = true
end

local function ensure_runner_exists()
  if not pane_exists() then
    split_pane()
  end
end

---@type Runner
local wezterm = {}

function wezterm.open_runner()
  ensure_runner_exists()
end

function wezterm.toggle_pane()
  if not pane_exists() then
    return split_pane()
  end

  if visible then
    wezterm_cli({ 'move-pane-to-new-tab', '--pane-id=' .. existing_pane_id })
    wezterm_cli({ 'set-tab-title', '--pane-id=' .. existing_pane_id, '"nvim runner"' })
    visible = false
  else
    split_pane(true)
  end
end

function wezterm.close_runner()
  wezterm_cli({ 'kill-pane', '--pane-id=' .. existing_pane_id })
  existing_pane_id = nil
end

function wezterm.interrupt_runner()
  set_user_var('interrupt')
end

function wezterm.run_command(command)
  ensure_runner_exists()

  last_command = command
  wezterm_cli({
    'send-text',
    '--no-paste',
    '--pane-id=' .. existing_pane_id,
    string.format('"%s\n"', command),
  })
end

function wezterm.run_last_command()
  if not last_command then
    return vim.notify('No previous command')
  end

  wezterm.run_command(last_command)
end

function wezterm.clear_terminal_screen()
  set_user_var('clear')
end

-- Autocmd to auto-close the WezTerm runner when Vim closes
require('utils').augroup('wezterm_runner', {
  { 'VimLeave', callback = wezterm.close_runner },
})

return wezterm
