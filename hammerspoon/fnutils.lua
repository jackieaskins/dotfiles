local M = {}

---Return whether two arrays are equal by comparing items
---@generic V
---@param list1 V[]
---@param list2 V[]
---@return boolean
function M.iequals(list1, list2)
  if #list1 ~= #list2 then
    return false
  end

  for index, value in ipairs(list1) do
    if value ~= list2[index] then
      return false
    end
  end

  return true
end

---Group list values by result of fn(value)
---@generic K, V
---@param list V[]
---@param fn fun(value: V): K
---@return { [K]: V[] }
function M.igroupBy(list, fn)
  local output = {}

  for _, value in ipairs(list) do
    local groupName = fn(value)

    local curr = output[groupName] or {}
    table.insert(curr, value)
    output[groupName] = curr
  end

  return output
end

---Reduce a list
---@generic I, O
---@param list I[]
---@param fn fun(val: I, curr: O, index: integer): O
---@param init O
---@return O
function M.ireduce(list, fn, init)
  local curr = init

  for index, value in ipairs(list) do
    curr = fn(value, curr, index)
  end

  return curr
end

---Map a list
---@generic I, O
---@param list I[]
---@param fn fun(value: I, index: integer): O
---@return O[]
function M.imap(list, fn)
  local output = {}

  for index, value in ipairs(list) do
    output[index] = fn(value, index)
  end

  return output
end

---Return a table with mapped keys and values
---@generic IK, OK, IV, OV
---@param t { [IK]: IV }
---@param fn fun(key: IK, value: IV): OK, OV
---@return { [OK]: OV }
function M.map(t, fn)
  local output = {}

  for key, value in pairs(t) do
    local newKey, newValue = fn(key, value)
    output[newKey] = newValue
  end

  return output
end

---Return a table with the same keys as t, but with values mapped to the return value of fn
---@generic K, IV, OV
---@param t { [K]: IV }
---@param fn fun(value: IV, key: K): OV
---@return { [K]: OV }
function M.mapValues(t, fn)
  local output = {}

  for key, value in pairs(t) do
    output[key] = fn(value, key)
  end

  return output
end

---Return a table with the same values as t, but with keys mapped to the return value of fn
---@generic IK, OK, V
---@param t { [IK]: V }
---@param fn fun(key: IK, value: V): OK
---@return { [OK]: V }
function M.mapKeys(t, fn)
  local output = {}

  for key, value in pairs(t) do
    output[fn(key, value)] = value
  end

  return output
end

---Get the keys from the provided table
---@generic K, V
---@param t { [K]: V }
---@return K[]
function M.getKeys(t)
  local keys = {}

  for key, _ in pairs(t) do
    table.insert(keys, key)
  end

  return keys
end

---Merge multiple tables together
---@generic K, V
---@param ... table<K, V>
---@return table<K, V>
function M.mergeTables(...)
  local rv = {}

  for _, tbl in ipairs({ ... }) do
    for key, value in pairs(tbl) do
      rv[key] = value
    end
  end

  return rv
end

return M
