local annotationGenKey = 'annotationsLastGenerated'

local parameterOverrides = {
  ['false'] = 'bool',
  ['function'] = 'fn',
  ['end'] = 'end_',
}

local supportedTypes = {
  any = 'any',
  ['nil'] = 'nil',

  str = 'string',
  string = 'string',
  uuid = 'string',
  uuidstring = 'string',
  errmsg = 'string',
  error = 'string',
  errorstring = 'string',

  bool = 'boolean',
  boolean = 'boolean',
  ['true'] = 'boolean',
  ['false'] = 'boolean',

  integer = 'integer',
  number = 'number',
  distance = 'number',
  keycode = 'number',
  ['rotation angle'] = 'number',
  sec = 'number',
  seconds = 'number',

  table = 'table',

  app = 'hs.application',
  audio = 'hs.audiodevice',
  datastore = 'hs.webview.datastore',
  device = 'hs.audiodevice',
  echorequest = 'hs.network.ping.echoRequest',
  menubaritem = 'hs.menubar',
  notification = 'hs.notify',
  serialport = 'hs.serial',
  spotlightitem = 'hs.spotlight',
  synthesizer = 'hs.speech',
  toolbar = 'hs.webview.toolbar',
  usercontentcontroller = 'hs.webview.usercontent',
  win = 'hs.window',
}

local signatureOverrides = {
  ['hs.console.titleVisibility([state]) -> current value'] = 'hs.console.titleVisibility([state]) -> string',
  ['hs.tangent.sendPanelConnectionStatesRequest())'] = 'hs.tangent.sendPanelConnectionStatesRequest()',
  ['hs.chooser:enableDefaultForQuery([]) -> hs.chooser object or boolean'] = 'hs.chooser:enableDefaultForQuery(enableDefaultForQuery) -> hs.chooser object or boolean',
  ['hs.notify.register(tag, fn) -> id'] = 'hs.notify.register(tag, fn) -> number',
  ['hs.pasteboard.readSound([name], [all]) -> hs.sound object or array of hs.sound objects'] = 'hs.pasteboard.readSound([name], [all]) -> hs.sound | hs.sound[]',
  ['hs.screen.find(hint) -> hs.screen object(s)'] = 'hs.screen.find(hint) -> hs.screen | nil',
  ['hs.screen.watcher.new(fn) -> watcher'] = 'hs.screen.watcher.new(fn) -> hs.screen.watcher',
  ['hs.window.filter:getWindows([sortOrder]) -> list of hs.window objects'] = 'hs.window.filter:getWindows([sortOrder]) -> hs.window[]',
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

local moduleNames = {}
for _, module in ipairs(modules) do
  moduleNames[module.name] = module.name
end

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

      ---@type string
      local returnMatch = item.signature:match('%s*->%s*(.*)')
      if returnMatch and returnMatch:lower() ~= 'none' then
        local returnStr = returnMatch
          :gsub('%sor%s', ' | ')
          :gsub('`', '')
          :gsub('(%S+)Object', '%1')
          :gsub('%sobjects', '[]')
          :gsub('%sobject%(s%)', '[]')
          :gsub('%sobject', '')
        ---@type string[]
        local returnParts = hs.fnutils.split(returnStr, '%s*|%s*')

        local matchedReturnParts = {}
        for _, returnPart in ipairs(returnParts) do
          local suffix = returnPart:match('(%[%])$')
          local modifiedReturnPart = returnPart == 'self' and module.name
            or returnPart:gsub('%[%]$', ''):gsub('^hs.geometry%s.+', 'hs.geometry'):lower()

          local matchedReturnPart = supportedTypes[modifiedReturnPart]
            or moduleNames[modifiedReturnPart]
            or moduleNames['hs.' .. modifiedReturnPart]

          if matchedReturnPart then
            table.insert(matchedReturnParts, matchedReturnPart .. (suffix or ''))
          end
        end

        if #returnParts == #matchedReturnParts then
          local returnType = table.concat(matchedReturnParts, ' | ')
          table.insert(itemLines, '---@return ' .. returnType)
        else
          table.insert(itemLines, '---@return any')
        end
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
