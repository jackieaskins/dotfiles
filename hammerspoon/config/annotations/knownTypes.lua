local nonHSKnownTypes = {
  any = 'any',

  number = 'number',
  seconds = 'number',
  sec = 'number',
  nanoseconds = 'number',
  meters = 'number',
  distance = 'number',
  modulation = 'number',
  pitch = 'number',
  rate = 'number',
  ['rotation angle'] = 'number',

  integer = 'integer',

  boolean = 'boolean',
  bool = 'boolean',
  ['true'] = 'boolean',
  ['false'] = 'boolean',

  string = 'string',
  str = 'string',
  uuid = 'string',
  path = 'string',
  text = 'string',
  name = 'string',
  title = 'string',
  -- error = 'string', -- Do I want to enable this?
  ['array of strings'] = 'string[]',

  -- TODO: Make these colorTable & pointTable
  -- colortable = 'HSColorTable',
  -- pointtable = 'HSPointTable',
  -- sizetable = 'HSSizeTable',
  -- recttable = 'HSRectTable',
  -- frametable = 'HSRectTable',
  -- hsbtable = 'HSHSBTable',
  -- hotkeytable = 'HSHotkey',
  -- hsminwebTable = '?',
  -- elementSearchObject = '?',

  fn = 'function',
  ['fn()'] = 'function',
  ['function'] = 'function',

  ['nil'] = 'nil',

  ['hs.image-object'] = 'hs.image',
  audio = 'hs.audiodevice',
  app = 'hs.application',
  bridge = 'hs.milight',
  screen = 'hs.screen',
  styledtext = 'hs.styledtext',
  win = 'hs.window',

  browserobject = 'hs.bonjour',
  canvasobject = 'hs.canvas',
  notificationobject = 'hs.notify',
  pasteboardwatcher = 'hs.pasteboard.watcher',
  razerobject = 'hs.razer',
  recognizerobject = 'hs.speech.listener',
  scanobject = 'hs.wifi',
  serialportobject = 'hs.serial',
  sharingobject = 'hs.sharing',
  soundobject = 'hs.sound',
  spotlightgroupobject = 'hs.spotlight.group',
  spotlightitemobject = 'hs.spotlight.item',
  storeobject = 'hs.network.configuration',
  styledtextobject = 'hs.styledtext',
  synthesizerobject = 'hs.speech',
  usercontentcontrollerobject = 'hs.webview.usercontent',
  webviewobject = 'hs.webview',
}

return {
  ---Get table of known type mappings
  ---@param docstrings HSDocString[]
  ---@return table<string, string>
  getKnownTypes = function(docstrings)
    local knownTypes = hs.fnutils.copy(nonHSKnownTypes)

    for _, docstring in ipairs(docstrings) do
      knownTypes[docstring.name] = docstring.name
    end

    return knownTypes
  end,
}
