local M = {}

local hotkeyGroups = {}

local cmd = '⌘'
local alt = '⌥'
local ctrl = '⌃'
local shift = '⇧'
local meh = '􀋀' -- Hammerspoon doesn't have a symbol defined for meh
local hyper = '✧'

local modMap = { cmd = cmd, command = cmd, ctrl = ctrl, control = ctrl, alt = alt, option = alt, shift = shift }

---@param groupName string
---@param desc string
---@param mods string[]
---@param key string
local function addHotkey(groupName, desc, mods, key)
  local mappedMods = hs.fnutils.imap(mods, function(mod)
    return modMap[mod] or mod
  end)

  local modStr = ''
  if hs.fnutils.contains(mappedMods, cmd) then
    modStr = modStr .. cmd
  end
  if hs.fnutils.contains(mappedMods, ctrl) then
    modStr = modStr .. ctrl
  end
  if hs.fnutils.contains(mappedMods, alt) then
    modStr = modStr .. alt
  end
  if hs.fnutils.contains(mappedMods, shift) then
    modStr = modStr .. shift
  end

  if modStr == (cmd .. ctrl .. alt .. shift) then
    modStr = hyper
  end

  local modKey = modStr .. string.upper(key)
  if hotkeyGroups[modKey] then
    error('Hot key ' .. modKey .. 'is already defined with description: ' .. desc)
  end
  hotkeyGroups[modKey] = { desc = desc, groupName = groupName }
end

---Bind a hot key and add it to store for display
---@param groupName string
---@param desc string
---@param mods string[]
---@param key string
---@param pressedfn fun()
---@param message string | nil
function M.register(groupName, desc, mods, key, pressedfn, message)
  addHotkey(groupName, desc, mods, key)

  if message then
    hs.hotkey.bind(mods, key, message, pressedfn)
  else
    hs.hotkey.bind(mods, key, pressedfn)
  end
end

---Generate a wrapper function to register hotkeys in a common group
---@param groupName string
---@return fun(desc: string, mods: string[], key: string, pressedfn: fun(), message: string | nil)
function M.registerGroup(groupName)
  return function(desc, mods, key, pressedfn, message)
    M.register(groupName, desc, mods, key, pressedfn, message)
  end
end

---Annotate a hotkey that is not defined directly (i.e. hotkeys defined by spoons)
---@param desc string
---@param mods string[]
---@param key string
function M.annotate(groupName, desc, mods, key)
  addHotkey(groupName, desc, mods, key)
end

---Generate a wrapper function to annotate hotkeys in a common group
---@param groupName string
---@return fun(desc: string, mods: string[], key: string)
function M.annotateGroup(groupName)
  return function(desc, mods, key)
    M.annotate(groupName, desc, mods, key)
  end
end

---Verify that all hotkeys have an associated description
function M.verify()
  local missingHotkeys = {}

  ---@diagnostic disable-next-line: param-type-mismatch
  for _, key in ipairs(hs.hotkey.getHotkeys()) do
    if not hotkeyGroups[key.idx] then
      table.insert(missingHotkeys, key.idx)
    end
  end

  if #missingHotkeys > 0 then
    error('The following hotkeys are not annotated: ' .. table.concat(missingHotkeys, ', '))
  end
end

---Show a dialog alert with all of the defined hotkeys
function M.show()
  local hotkeysByGroup = {}
  for key, value in pairs(hotkeyGroups) do
    local group = hotkeysByGroup[value.groupName] or {}
    group[key] = value.desc
    hotkeysByGroup[value.groupName] = group
  end

  local dialogText = {}
  for groupName, descs in pairs(hotkeysByGroup) do
    table.insert(dialogText, groupName)
    for key, desc in pairs(descs) do
      -- Handles switching key combo for meh key into meh symbol
      table.insert(dialogText, desc .. ' - ' .. key:gsub(ctrl .. alt .. shift, meh))
    end
    table.insert(dialogText, '')
  end

  table.insert(
    dialogText,
    table.concat({
      cmd .. ': command ',
      ctrl .. ': control ',
      alt .. ': option ',
      shift .. ': shift ',
      meh .. ': meh',
      hyper .. ': hyper',
    }, ' ')
  )

  hs.dialog.alert(
    hs.screen.mainScreen():fullFrame().center.x,
    10,
    function() end,
    'Hammerspoon Hotkeys',
    table.concat(dialogText, '\n'),
    'Dismiss',
    nil,
    'informational'
  )
end

return M
