local annotationGenKey = 'annotationsLastGenerated'

local annotationsLastGenerated = hs.settings.get(annotationGenKey)
local docstringsLastModified = hs.fs.attributes(hs.docstrings_json_file, 'modification')
assert(docstringsLastModified, 'Unable to get docstrings last modified time')

if annotationsLastGenerated ~= nil and annotationsLastGenerated > docstringsLastModified then
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
    local type = item.type
    local sep = type == 'Method' and ':' or '.'
    local itemName = moduleName .. sep .. item.name

    local itemLines = { '---' .. item.doc:gsub('\n', '\n---') }

    local isFunction = item.signature:match('%(') ~= nil
    if isFunction then
      local args = {}
      for index, _ in ipairs(item.parameters or {}) do
        table.insert(args, 'arg' .. index)
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
