local cmd = '⌘'
local alt = '⌥'
local ctrl = '⌃'
local shift = '⇧'
local meh = '􀫸' -- Hammerspoon doesn't have a symbol defined for meh
local hyper = '✧'

local modNames = {
  cmd = cmd,
  option = alt,
  ctrl = ctrl,
  shift = shift,
  meh = meh,
  hyper = hyper,
}
local modMap = {
  cmd = cmd,
  command = cmd,
  ctrl = ctrl,
  control = ctrl,
  alt = alt,
  option = alt,
  shift = shift,
}

local M = {}

---@type hs.menubar | nil
local menubar = hs.menubar.new(true, 'hotkeys')

---@type table<string, boolean>
local definedHotKeys = {}

---@class HotKey
---@field keys string
---@field desc string
---@field mods string[]
---@field character string

---@type table<string, HotKey[]>
local hotkeysByGroup = {}

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
  if definedHotKeys[modKey] then
    error('Hot key ' .. modKey .. 'is already defined with description: ' .. desc)
  end
  definedHotKeys[modKey] = true

  local currentKeys = hotkeysByGroup[groupName] or {}
  table.insert(currentKeys, {
    keys = modKey,
    desc = desc,
    mods = mods,
    character = key,
  })
  hotkeysByGroup[groupName] = currentKeys
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
    if not definedHotKeys[key.idx] then
      table.insert(missingHotkeys, key.idx)
    end
  end

  if #missingHotkeys > 0 then
    error('The following hotkeys are not annotated: ' .. table.concat(missingHotkeys, ', '))
  end
end

---Add menubar item with Hammerspoon hotkeys
function M.addMenubarItem()
  if not menubar then
    return
  end

  menubar:setTitle('􀇳')

  local menu = {}
  for group, hotkeys in pairs(hotkeysByGroup) do
    table.insert(menu, { title = group, disabled = true })

    for _, hotkey in ipairs(hotkeys) do
      table.insert(menu, {
        title = hotkey.desc .. ' - ' .. hotkey.keys:gsub(ctrl .. alt .. shift, meh),
        fn = function()
          hs.eventtap.keyStroke(hotkey.mods, hotkey.character)
        end,
      })
    end

    table.insert(menu, { title = '-' })
  end

  for name, mod in pairs(modNames) do
    table.insert(menu, { title = mod .. ' - ' .. name, disabled = true })
  end

  menubar:setMenu(menu)
end

return M
