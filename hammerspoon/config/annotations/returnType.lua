---@alias checkerFn fun(lowerValue: string, moduleName: string, knownTypes: table<string, string>): string | false

---@type checkerFn
local function knownType(lowerValue, _, knownTypes)
  return knownTypes[lowerValue]
end

---@type checkerFn
local function knownTypeVariable(lowerValue, _, knownTypes)
  local type, spread = table.unpack(hs.fnutils.split(lowerValue, ' '))
  return knownTypes[type] ~= nil and spread == '...' and knownTypes[type] .. ' ...'
end

---@type checkerFn
local function selfOrObject(lowerValue, moduleName, _)
  return hs.fnutils.contains({ 'self', 'object' }, lowerValue) and moduleName
end

---@type checkerFn
local function hsGeometry(lowerValue, _, _)
  return lowerValue:match('^hs.geometry ') and 'hs.geometry'
end

---@type checkerFn
local function typeInBackticks(lowerValue, _, knownTypes)
  local typeFromBackticks = lowerValue:match('`(.+)`')
  return typeFromBackticks and knownTypes[typeFromBackticks]
end

---@type checkerFn
local function itemOrObjectSuffix(lowerValue, moduleName, knownTypes)
  local object = lowerValue:match('^([%w%.]+)%s*object$')
  if object and knownTypes[object] then
    return knownTypes[object]
  end
  local noItem = (object and object:gsub('item$', '')) or lowerValue:gsub('item$', '')

  return moduleName:lower():match(noItem .. '$') and moduleName
end

---@type checkerFn
local function itemOrObjectSuffixArray(lowerValue, moduleName, knownTypes)
  local objects = lowerValue:match('^(.+) object%(?s%)?$')
  objects = objects and objects:gsub('^array of ', ''):gsub('^list of ', '')
  if objects and knownTypes[objects] then
    return knownTypes[objects] .. '[]'
  end
  local noItems = (objects and objects:gsub('item$', '')) or lowerValue:gsub('item$', '')
  return moduleName:lower():match(noItems .. '$') and moduleName .. '[]'
end

---@param lowerValue string
---@param moduleName string
---@param knownTypes table<string, string>
---@return string | nil
local function getType(lowerValue, moduleName, knownTypes)
  local trimmedValue = lowerValue:match('^%s*(.*)%s*$')

  local arrayMatch = trimmedValue:match('^(.+)%[%]$')
  if arrayMatch then
    local arrayType = getType(arrayMatch, moduleName, knownTypes)
    return arrayType and arrayType .. '[]' or nil
  end

  local tableMatch = trimmedValue:match('^table<(.+)>$')
  if tableMatch then
    local key, value = table.unpack(hs.fnutils.split(tableMatch, ',', 1, true))

    local keyType = getType(key, moduleName, knownTypes)
    local valueType = getType(value, moduleName, knownTypes)

    return keyType and valueType and string.format('table<%s, %s>', keyType, valueType) or nil
  end

  for _, checker in ipairs({
    knownType,
    knownTypeVariable,
    selfOrObject,
    hsGeometry,
    typeInBackticks,
    itemOrObjectSuffix,
    itemOrObjectSuffixArray,
  }) do
    local returnType = checker(trimmedValue, moduleName, knownTypes)
    if returnType then
      return returnType
    end
  end

  return nil
end

local M = {}

---@param value string
---@param moduleName string
---@param knownTypes table<string, string>
---@return string | nil
function M.getReturnType(value, moduleName, knownTypes)
  return getType(value:lower(), moduleName, knownTypes)
end

return M
