local getKnownTypes = require('config.annotations.knownTypes').getKnownTypes
local getReturnType = require('config.annotations.returnType').getReturnType
local overrides = require('config.annotations.overrides')

---@type HSDocString[] | nil
local docstrings = hs.json.read(hs.docstrings_json_file)

if docstrings == nil then
  hs.alert.show('No docstrings..?')
  return
end

local annotationsPath = './generatedAnnotations'
hs.fs.rmdir(annotationsPath)
hs.fs.mkdir(annotationsPath)

local knownTypes = getKnownTypes(docstrings)

local unhandledReturns = {}

---@param fnReturn string
---@param moduleName string
---@return string | nil
local function getFunctionReturnType(fnReturn, moduleName)
  local rets = hs.fnutils.split(fnReturn:gsub(' or ', ' | '), '%s*|%s*')

  local types = {}

  for _, ret in ipairs(rets) do
    local type = getReturnType(ret, moduleName, knownTypes)

    if type then
      types[#types + 1] = type
    end
  end

  local type = #types == #rets and table.concat(types, ' | ') or nil

  return type
end

---@param file file*
---@param moduleName string
---@return fun(header: string, fns: HSFunction[], moduleName: string)
local function getFunctionParser(file, moduleName)
  return function(header, fns, sep)
    if #fns > 0 then
      file:write('-- ' .. header .. ' {{{\n\n')
    end

    for _, fn in ipairs(fns) do
      local fullFn = moduleName .. sep .. fn.name

      local override = overrides[fullFn] or {}
      local signature = override.newSignature or fn.signature

      file:write('---' .. fn.doc:gsub('\n', '\n---') .. '\n')

      local sigParts = hs.fnutils.split(signature, '%s*->%s*')
      local fnReturn = signature:find('->') and sigParts[#sigParts]:gsub('^%s+', ''):gsub('%s+$', '') or ''

      local params = hs.fnutils.map(
        hs.fnutils.split(signature:gsub('%s*->%s*.*', ''):match('%((.*)%)'), ','),
        function(param)
          return param:gsub('%[', ''):gsub('%]', ''):gsub('^%s+', ''):gsub('%s+$', ''):gsub('%s+.*', '')
        end
      )
      for _, param in ipairs(params) do
        file:write('---@param ' .. param .. ' any\n')
      end

      if fnReturn ~= '' and fnReturn:lower() ~= 'none' then
        local type = getFunctionReturnType(fnReturn, moduleName)

        if not type then
          unhandledReturns[fullFn] = {
            newSignature = hs.fnutils.split(fn.signature, '-> ')[1] .. '-> ',
            defaultSignature = fn.signature,
          }
        end

        file:write('---@return ' .. (type or 'any') .. '\n')
      end

      if fn.type == 'Deprecated' then
        file:write('---@deprecated\n')
      end

      file:write(string.format('function %s(%s) end\n\n', fullFn, table.concat(params, ', ')))
    end

    if #fns > 0 then
      file:write('-- }}}\n\n')
    end
  end
end

for _, docstring in ipairs(docstrings) do
  local moduleName = docstring.name
  local file = io.open(annotationsPath .. '/' .. moduleName .. '.lua', 'w')

  if not file then
    return
  end

  file:write('---@meta ' .. moduleName .. '\n\n')
  file:write('---@class ' .. moduleName .. '\n')
  file:write(moduleName .. ' = {}\n\n')

  local constants = docstring.Constant
  if #constants > 0 then
    file:write('-- Constants {{{\n\n')
  end
  for _, constant in ipairs(constants) do
    file:write('---' .. constant.doc:gsub('\n', '\n---') .. '\n')
    file:write('---@type any\n')
    file:write(moduleName .. '.' .. constant.name .. ' = nil\n\n')
  end
  if #constants > 0 then
    file:write('-- }}}\n\n')
  end

  local functionParser = getFunctionParser(file, moduleName)
  functionParser('Constructors', docstring.Constructor, '.')
  functionParser('Functions', docstring.Function, '.')
  functionParser('Methods', docstring.Method, ':')

  file:write('-- ' .. 'vim:foldmethod=marker foldlevel=0')

  file:close()
end

hs.json.write(unhandledReturns, './unhandledReturns.json', true, true)
