local annotationGenKey = 'annotationsLastGenerated'

local parameterOverrides = {
  ['false'] = 'bool',
  ['function'] = 'fn',
  ['end'] = 'end_',
}

local signatureOverrides = {
  ['hs.tangent.sendPanelConnectionStatesRequest())'] = 'hs.tangent.sendPanelConnectionStatesRequest()',
  ['hs.chooser:enableDefaultForQuery([]) -> hs.chooser object or boolean'] = 'hs.chooser:enableDefaultForQuery(enableDefaultForQuery) -> hs.chooser object or boolean',
}

local annotationsLastGenerated = hs.settings.get(annotationGenKey)
local docstringsLastModified = hs.fs.attributes(hs.docstrings_json_file, 'modification')
local sourceCodeLastModified = hs.fs.attributes(hs.configdir .. '/annotations/init.lua', 'modification')

if
  annotationsLastGenerated
  and docstringsLastModified
  and sourceCodeLastModified
  and annotationsLastGenerated > docstringsLastModified
  and annotationsLastGenerated > sourceCodeLastModified
then
  return
end

---@type HSModule[] | nil
local modules = hs.json.read(hs.docstrings_json_file)
assert(modules, 'Error reading docstrings json file')

local outDir = os.getenv('HOME') .. '/dotfiles/hammerspoon/annotations/generated'
hs.fs.rmdir(outDir)
hs.fs.mkdir(outDir)

for _, module in ipairs(modules) do
  local moduleName = module.name
  local file = io.open(outDir .. '/' .. moduleName .. '.lua', 'w')

  assert(file, 'File not created successfully')

  local header_lines = {
    '---@meta ' .. moduleName,
    '',
    '---' .. module.doc:gsub('\n', '\n---'),
    '---@class ' .. moduleName,
    moduleName .. ' = {}',
    '',
    '',
  }
  file:write(table.concat(header_lines, '\n'))

  for _, item in ipairs(module.items) do
    item.signature = signatureOverrides[item.signature] or item.signature

    local type = item.type
    local sep = type == 'Method' and ':' or '.'
    local itemName = moduleName .. sep .. item.name

    local itemLines = { '---' .. item.doc:gsub('\n', '\n---') }

    local isFunction = item.parameters ~= nil
    if isFunction then
      local args = {}

      -- handle case where signature has multiple sets of parentheses
      local parametersStr = item.signature:match('%((.*)%).*->') or item.signature:match('%((.*)%)$')
      local parameters = hs.fnutils.split(parametersStr, ',')
      for _, parameter in ipairs(parameters) do
        if parameter:match('%.%.%.') then
          table.insert(args, '...')
        else
          local words = {}

          for word in parameter:gsub('%s+or%s', ' | '):gmatch('[%w_%.]+') do
            if #words > 0 then
              local capitalizedWord = word:gsub('^%l', string.upper)
              table.insert(words, capitalizedWord)
            else
              table.insert(words, word)
            end
          end

          local parameterName = table.concat(words, 'Or')
          parameterName = parameterOverrides[parameterName] or parameterName

          if parameterName == '' then
          else
            table.insert(args, parameterName)
          end
        end
      end

      for _, arg in ipairs(args) do
        table.insert(itemLines, '---@param ' .. arg .. ' any')
      end
      if item.signature:match('%s*->%s*') ~= nil then
        table.insert(itemLines, '---@return any')
      end

      local argStr = table.concat(args, ', ')
      local fn = 'function ' .. itemName .. '(' .. argStr .. ') end'
      table.insert(itemLines, fn)
    else
      table.insert(itemLines, itemName .. ' = nil')
    end

    table.insert(itemLines, '')
    table.insert(itemLines, '')

    file:write(table.concat(itemLines, '\n'))
  end

  file:close()

  hs.settings.set(annotationGenKey, os.time())
end
