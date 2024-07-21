---@class Override
---@field newSignature string
---@field originalSignature string

-- TODO: detect when originalSignature changes

---@type table<string, Override>
return {
  ['hs.accessibilityState'] = {
    newSignature = 'hs.accessibilityState(shouldPrompt) -> boolean',
    originalSignature = 'hs.accessibilityState(shouldPrompt) -> isEnabled',
  },
  ['hs.appfinder.windowFromWindowTitlePattern'] = {
    newSignature = 'hs.appfinder.windowFromWindowTitlePattern(pattern) -> hs.window | nil',
    originalSignature = 'hs.appfinder.windowFromWindowTitlePattern(pattern) -> app or nil',
  },
  ['hs.application.infoForBundleID'] = {
    newSignature = 'hs.application.infoForBundleID(bundleID) -> table<string, any> | nil',
    originalSignature = 'hs.application.infoForBundleID(bundleID) -> table or nil',
  },
  ['hs.application.infoForBundlePath'] = {
    newSignature = 'hs.application.infoForBundlePath(bundlePath) -> table<string, any> | nil',
    originalSignature = 'hs.application.infoForBundlePath(bundlePath) -> table or nil',
  },
  ['hs.application.localizationsForBundleID'] = {
    newSignature = 'hs.application.localizationsForBundleID(bundleID) -> string[] | nil',
    originalSignature = 'hs.application.localizationsForBundleID(bundleID) -> table or nil',
  },
  ['hs.application.localizationsForBundlePath'] = {
    newSignature = 'hs.application.localizationsForBundlePath(bundlePath) -> string[] | nil',
    originalSignature = 'hs.application.localizationsForBundlePath(bundlePath) -> table or nil',
  },
  ['hs.application.preferredLocalizationsForBundleID'] = {
    newSignature = 'hs.application.preferredLocalizationsForBundleID(bundleID) -> string[] | nil',
    originalSignature = 'hs.application.preferredLocalizationsForBundleID(bundleID) -> table or nil',
  },
  ['hs.application.preferredLocalizationsForBundlePath'] = {
    newSignature = 'hs.application.preferredLocalizationsForBundlePath(bundlePath) -> string[] | nil',
    originalSignature = 'hs.application.preferredLocalizationsForBundlePath(bundlePath) -> table or nil',
  },
  ['hs.axuielement.axtextmarker._functionCheck'] = {
    newSignature = 'hs.axuielement.axtextmarker._functionCheck() -> table<string, boolean>',
    originalSignature = 'hs.axuielement.axtextmarker._functionCheck() -> table',
  },
  ['hs.axuielement.observer:watching'] = {
    newSignature = 'hs.axuielement.observer:watching([element]) -> string[]',
    originalSignature = 'hs.axuielement.observer:watching([element]) -> table',
  },
  ['hs.axuielement:childrenWithRole'] = {
    newSignature = 'hs.axuielement:childrenWithRole(role) -> hs.axuielement[]',
    originalSignature = 'hs.axuielement:childrenWithRole(role) -> table',
  },
  ['hs.axuielement:path'] = {
    newSignature = 'hs.axuielement:path() -> hs.axuielement[]',
    originalSignature = 'hs.axuielement:path() -> table',
  },
  ['hs.base64.decode'] = {
    newSignature = 'hs.base64.decode(str) -> string',
    originalSignature = 'hs.base64.decode(str) -> val',
  },
  ['hs.battery._report'] = {
    newSignature = 'hs.battery._report() -> table<string, any>',
    originalSignature = 'hs.battery._report() -> table',
  },
  ['hs.battery.getAll'] = {
    newSignature = 'hs.battery.getAll() -> table<string, any>',
    originalSignature = 'hs.battery.getAll() -> table',
  },
  ['hs.bonjour.service:addresses'] = {
    newSignature = 'hs.bonjour.service:addresses() -> string[]',
    originalSignature = 'hs.bonjour.service:addresses() -> table',
  },
  ['hs.bonjour:includesPeerToPeer'] = {
    newSignature = 'hs.bonjour:includesPeerToPeer([value]) -> boolean | hs.bonjour',
    originalSignature = 'hs.bonjour:includesPeerToPeer([value]) -> current value | browserObject',
  },
  ['hs.camera.allCameras'] = {
    newSignature = 'hs.camera.allCameras() -> hs.camera[]',
    originalSignature = 'hs.camera.allCameras() -> table',
  },
  ['hs.canvas.elementSpec'] = {
    newSignature = 'hs.canvas.elementSpec() -> table<string, any>',
    originalSignature = 'hs.canvas.elementSpec() -> table',
  },
  ['hs.canvas:_accessibilitySubrole'] = {
    newSignature = 'hs.canvas:_accessibilitySubrole([subrole]) -> hs.canvas | string',
    originalSignature = 'hs.canvas:_accessibilitySubrole([subrole]) -> canvasObject | current value',
  },
  ['hs.canvas:alpha'] = {
    newSignature = 'hs.canvas:alpha([alpha]) -> hs.canvas | number',
    originalSignature = 'hs.canvas:alpha([alpha]) -> canvasObject | currentValue',
  },
  ['hs.canvas:appendElements'] = {
    newSignature = 'hs.canvas:appendElements(elements) -> canvasObject',
    originalSignature = 'hs.canvas:appendElements(element...) -> canvasObject',
  },
  ['hs.canvas:behavior'] = {
    newSignature = 'hs.canvas:behavior([behavior]) -> hs.canvas | integer | string | table',
    originalSignature = 'hs.canvas:behavior([behavior]) -> canvasObject | currentValue',
  },
  ['hs.canvas:behaviorAsLabels'] = {
    newSignature = 'hs.canvas:behaviorAsLabels(behaviorTable) -> hs.canvas | string[]',
    originalSignature = 'hs.canvas:behaviorAsLabels(behaviorTable) -> canvasObject | currentValue',
  },
  ['hs.canvas:clickActivating'] = {
    newSignature = 'hs.canvas:clickActivating([flag]) -> hs.canvas | boolean',
    originalSignature = 'hs.canvas:clickActivating([flag]) -> canvasObject | currentValue',
  },
  ['hs.canvas:elementKeys'] = {
    newSignature = 'hs.canvas:elementKeys(index, [optional]) -> string[]',
    originalSignature = 'hs.canvas:elementKeys(index, [optional]) -> table',
  },
  ['hs.canvas:frame'] = {
    newSignature = 'hs.canvas:frame([rect]) -> hs.canvas | table<string, number>',
    originalSignature = 'hs.canvas:frame([rect]) -> canvasObject | currentValue',
  },
  ['hs.canvas:level'] = {
    newSignature = 'hs.canvas:level([level]) -> hs.canvas | number',
    originalSignature = 'hs.canvas:level([level]) -> canvasObject | currentValue',
  },
  ['hs.canvas:replaceElements'] = {
    newSignature = 'hs.canvas:replaceElements(elements) -> hs.canvas',
    originalSignature = 'hs.canvas:replaceElements(element...) -> canvasObject',
  },
  ['hs.canvas:size'] = {
    newSignature = 'hs.canvas:size([size]) -> hs.canvas | table<string, number>',
    originalSignature = 'hs.canvas:size([size]) -> canvasObject | currentValue',
  },
  ['hs.canvas:topLeft'] = {
    newSignature = 'hs.canvas:topLeft([point]) -> hs.canvas | table<string, number>',
    originalSignature = 'hs.canvas:topLeft([point]) -> canvasObject | currentValue',
  },
  ['hs.canvas:transformation'] = {
    newSignature = 'hs.canvas:transformation([matrix]) -> hs.canvas | table<string, number>',
    originalSignature = 'hs.canvas:transformation([matrix]) -> canvasObject | current value',
  },
  ['hs.canvas:wantsLayer'] = {
    newSignature = 'hs.canvas:wantsLayer([flag]) -> hs.canvas | boolean',
    originalSignature = 'hs.canvas:wantsLayer([flag]) -> canvasObject | currentValue',
  },
  ['hs.chooser:attachedToolbar'] = {
    newSignature = 'hs.chooser:attachedToolbar([toolbar]) -> hs.chooser | hs.webview.toolbar',
    originalSignature = 'hs.chooser:attachedToolbar([toolbar]) -> hs.chooser object | currentValue',
  },
  ['hs.chooser:enableDefaultForQuery'] = {
    newSignature = 'hs.chooser:enableDefaultForQuery(enableDefaultForQuery) -> hs.chooser | boolean',
    originalSignature = 'hs.chooser:enableDefaultForQuery([]) -> hs.chooser object or boolean',
  },
  ['hs.cleanUTF8forConsole'] = {
    newSignature = 'hs.cleanUTF8forConsole(inString) -> string',
    originalSignature = 'hs.cleanUTF8forConsole(inString) -> outString',
  },
  ['hs.console.alpha'] = {
    newSignature = 'hs.console.alpha([alpha]) -> number',
    originalSignature = 'hs.console.alpha([alpha]) -> currentValue',
  },
  ['hs.console.behaviorAsLabels'] = {
    newSignature = 'hs.console.behaviorAsLabels(behaviorTable) -> string[]',
    originalSignature = 'hs.console.behaviorAsLabels(behaviorTable) -> currentValue',
  },
  ['hs.console.getHistory'] = {
    newSignature = 'hs.console.getHistory() -> string[]',
    originalSignature = 'hs.console.getHistory() -> array',
  },
  ['hs.console.level'] = {
    newSignature = 'hs.console.level([theLevel]) -> integer',
    originalSignature = 'hs.console.level([theLevel]) -> currentValue',
  },
  ['hs.console.titleVisibility'] = {
    newSignature = 'hs.console.titleVisibility([state]) -> string',
    originalSignature = 'hs.console.titleVisibility([state]) -> current value',
  },
  ['hs.console:behavior'] = {
    newSignature = 'hs.console.behavior([behavior]) -> number',
    originalSignature = 'hs.console.behavior([behavior]) -> currentValue',
  },
  ['hs.console:toolbar'] = {
    newSignature = 'hs.console.toolbar([toolbar]) -> hs.webview.toolbar | nil',
    originalSignature = 'hs.console.toolbar([toolbar]) -> toolbarObject | currentValue',
  },
  ['hs.crash.dumpCLIBS'] = {
    newSignature = 'hs.crash.dumpCLIBS() -> string[]',
    originalSignature = 'hs.crash.dumpCLIBS() -> table',
  },
  ['hs.dialog.color.mode'] = {
    newSignature = 'hs.dialog.color.mode([value]) -> string',
    originalSignature = 'hs.dialog.color.mode([value]) -> table',
  },
  ['hs.doc.hsdocs.browserDarkMode'] = {
    newSignature = 'hs.doc.hsdocs.browserDarkMode([value]) -> boolean | nil',
    originalSignature = 'hs.doc.hsdocs.browserDarkMode([value]) -> currentValue',
  },
  ['hs.doc.hsdocs.browserFrame'] = {
    newSignature = 'hs.doc.hsdocs.browserFrame([frameTable]) -> table<string, number>',
    originalSignature = 'hs.doc.hsdocs.browserFrame([frameTable]) -> currentValue',
  },
  ['hs.doc.hsdocs.forceExternalBrowser'] = {
    newSignature = 'hs.doc.hsdocs.forceExternalBrowser([value]) -> boolean',
    originalSignature = 'hs.doc.hsdocs.forceExternalBrowser([value]) -> currentValue',
  },
  ['hs.doc.hsdocs.interface'] = {
    newSignature = 'hs.doc.hsdocs.interface([interface]) -> string',
    originalSignature = 'hs.doc.hsdocs.interface([interface]) -> currentValue',
  },
  ['hs.doc.hsdocs.moduleEntitiesInSidebar'] = {
    newSignature = 'hs.doc.hsdocs.moduleEntitiesInSidebar([value]) -> boolean',
    originalSignature = 'hs.doc.hsdocs.moduleEntitiesInSidebar([value]) -> currentValue',
  },
  ['hs.doc.hsdocs.port'] = {
    newSignature = 'hs.doc.hsdocs.port([value]) -> number',
    originalSignature = 'hs.doc.hsdocs.port([value]) -> currentValue',
  },
  ['hs.doc.hsdocs.trackBrowserFrame'] = {
    newSignature = 'hs.doc.hsdocs.trackBrowserFrame([value]) -> boolean',
    originalSignature = 'hs.doc.hsdocs.trackBrowserFrame([value]) -> currentValue',
  },
  ['hs.doc.markdown.convert'] = {
    newSignature = 'hs.doc.markdown.convert(markdown, [type]) -> string',
    originalSignature = 'hs.doc.markdown.convert(markdown, [type]) -> output',
  },
  ['hs.doc.registeredFiles'] = {
    newSignature = 'hs.doc.registeredFiles() -> string[]',
    originalSignature = 'hs.doc.registeredFiles() -> table',
  },
  ['hs.drawing.color.lists'] = {
    newSignature = 'hs.drawing.color.lists() -> table<string, table<string, colorTable>>',
    originalSignature = 'hs.drawing.color.lists() -> table',
  },
  ['hs.drawing:behaviorAsLabels'] = {
    newSignature = 'hs.drawing:behaviorAsLabels() -> string[]',
    originalSignature = 'hs.drawing:behaviorAsLabels() -> table',
  },
  ['hs.drawing:clickCallbackActivating'] = {
    newSignature = 'hs.drawing:clickCallbackActivating([falseFlag]) -> hs.drawing | boolean',
    originalSignature = 'hs.drawing:clickCallbackActivating([false]) -> drawingObject or current value',
  },
  ['hs.drawing:clippingRectangle'] = {
    newSignature = 'hs.drawing:clippingRectangle([rect]) -> hs.drawing | table',
    originalSignature = 'hs.drawing:clippingRectangle([rect]) -> drawingObject or current value',
  },
  ['hs.drawing:imageAlignment'] = {
    newSignature = 'hs.drawing:imageAlignment([type]) -> hs.drawing | string',
    originalSignature = 'hs.drawing:imageAlignment([type]) -> drawingObject or current value',
  },
  ['hs.drawing:imageAnimates'] = {
    newSignature = 'hs.drawing:imageAnimates([flag]) -> hs.drawing | boolean',
    originalSignature = 'hs.drawing:imageAnimates([flag]) -> drawingObject or current value',
  },
  ['hs.drawing:imageFrame'] = {
    newSignature = 'hs.drawing:imageFrame([type]) -> hs.drawing | string',
    originalSignature = 'hs.drawing:imageFrame([type]) -> drawingObject or current value',
  },
  ['hs.drawing:imageScaling'] = {
    newSignature = 'hs.drawing:imageScaling([type]) -> hs.drawing | string',
    originalSignature = 'hs.drawing:imageScaling([type]) -> drawingObject or current value',
  },
  ['hs.drawing:orderBelow'] = {
    newSignature = 'hs.drawing:orderBelow([object2]) -> hs.drawing',
    originalSignature = 'hs.drawing:orderBelow([object2]) -> object1',
  },
  ['hs.eventtap.event.newKeyEventSequence'] = {
    newSignature = 'hs.eventtap.event.newKeyEventSequence(modifiers, character) -> hs.eventtap.event[]',
    originalSignature = 'hs.eventtap.event.newKeyEventSequence(modifiers, character) -> table',
  },
  ['hs.eventtap.event:getFlags'] = {
    newSignature = 'hs.eventtap.event:getFlags() -> table<string, boolean>',
    originalSignature = 'hs.eventtap.event:getFlags() -> table',
  },
  ['hs.eventtap.event:getKeyCode'] = {
    newSignature = 'hs.eventtap.event:getKeyCode() -> number',
    originalSignature = 'hs.eventtap.event:getKeyCode() -> keycode',
  },
  ['hs.eventtap.scrollWheel'] = {
    newSignature = 'hs.eventtap.scrollWheel(offsets, modifiers, unit)',
    originalSignature = 'hs.eventtap.scrollWheel(offsets, modifiers, unit) -> event',
  },
  ['hs.fnutils.sortByKeyValues'] = {
    newSignature = 'hs.fnutils.sortByKeyValues(table[ , fn]) -> function',
    originalSignature = 'hs.fnutils.sortByKeyValues(table[ , function]) -> function',
  },
  ['hs.fnutils.sortByKeys'] = {
    newSignature = 'hs.fnutils.sortByKeys(table[ , fn]) -> function',
    originalSignature = 'hs.fnutils.sortByKeys(table[ , function]) -> function',
  },
  ['hs.fs.tagsGet'] = {
    newSignature = 'hs.fs.tagsGet(filepath) -> string[] | nil',
    originalSignature = 'hs.fs.tagsGet(filepath) -> table or nil',
  },
  ['hs.fs.volume.allVolumes'] = {
    newSignature = 'hs.fs.volume.allVolumes([showHidden]) -> table<string, table<string, any>>',
    originalSignature = 'hs.fs.volume.allVolumes([showHidden]) -> table',
  },
  ['hs.fs.volume.new'] = {
    newSignature = 'hs.fs.volume.new(fn) -> hs.fs.volume',
    originalSignature = 'hs.fs.volume.new(fn) -> watcher',
  },
  ['hs.fs.xattr.list'] = {
    newSignature = 'hs.fs.xattr.list(path, [options]) -> string[]',
    originalSignature = 'hs.fs.xattr.list(path, [options]) -> table',
  },
  ['hs.grid.get'] = {
    newSignature = 'hs.grid.get(win) -> hs.geometry',
    originalSignature = 'hs.grid.get(win) -> cell',
  },
  ['hs.hash.bMD5'] = {
    newSignature = 'hs.hash.bMD5(data) -> string',
    originalSignature = 'hs.hash.bMD5(data) -> data',
  },
  ['hs.hash.bSHA1'] = {
    newSignature = 'hs.hash.bSHA1(data) -> string',
    originalSignature = 'hs.hash.bSHA1(data) -> data',
  },
  ['hs.hash.bSHA256'] = {
    newSignature = 'hs.hash.bSHA256(data) -> string',
    originalSignature = 'hs.hash.bSHA256(data) -> data',
  },
  ['hs.hash.bSHA512'] = {
    newSignature = 'hs.hash.bSHA512(data) -> string',
    originalSignature = 'hs.hash.bSHA512(data) -> data',
  },
  ['hs.host.addresses'] = {
    newSignature = 'hs.host.addresses() -> string[]',
    originalSignature = 'hs.host.addresses() -> table',
  },
  ['hs.host.gpuVRAM'] = {
    newSignature = 'hs.host.gpuVRAM() -> table<string, number>',
    originalSignature = 'hs.host.gpuVRAM() -> table',
  },
  ['hs.host.locale.availableLocales'] = {
    newSignature = 'hs.host.locale.availableLocales() -> string[]',
    originalSignature = 'hs.host.locale.availableLocales() -> table',
  },
  ['hs.host.locale.preferredLanguages'] = {
    newSignature = 'hs.host.locale.preferredLanguages() -> string[]',
    originalSignature = 'hs.host.locale.preferredLanguages() -> table',
  },
  ['hs.host.locale.registerCallback'] = {
    newSignature = 'hs.host.locale.registerCallback(fn) -> string',
    originalSignature = 'hs.host.locale.registerCallback(function) -> uuidString',
  },
  ['hs.host.names'] = {
    newSignature = 'hs.host.names() -> string[]',
    originalSignature = 'hs.host.names() -> table',
  },
  ['hs.host.volumeInformation'] = {
    newSignature = 'hs.host.volumeInformation([showHidden]) -> table<string, table<string, any>>',
    originalSignature = 'hs.host.volumeInformation([showHidden]) -> table',
  },
  ['hs.http.convertHtmlEntities'] = {
    newSignature = 'hs.http.convertHtmlEntities(inString) -> string',
    originalSignature = 'hs.http.convertHtmlEntities(inString) -> outString',
  },
  ['hs.http.doAsyncRequest'] = {
    newSignature = 'hs.http.doAsyncRequest(url, method, data, headers, callback, [cachePolicy], [enableRedirect])',
    originalSignature = 'hs.http.doAsyncRequest(url, method, data, headers, callback, [cachePolicy|enableRedirect])',
  },
  ['hs.httpserver.hsminweb.cgilua.doscript'] = {
    newSignature = 'hs.httpserver.hsminweb.cgilua.doscript(filename) -> string ...',
    originalSignature = 'hs.httpserver.hsminweb.cgilua.doscript(filename) -> results',
  },
  ['hs.httpserver.hsminweb.cgilua.lp.translate'] = {
    newSignature = 'hs.httpserver.hsminweb.cgilua.lp.translate(source) -> string',
    originalSignature = 'hs.httpserver.hsminweb.cgilua.lp.translate(source) -> luaCode',
  },
  ['hs.httpserver:maxBodySize'] = {
    newSignature = 'hs.httpserver:maxBodySize([size]) -> hs.httpserver | integer',
    originalSignature = 'hs.httpserver:maxBodySize([size]) -> object | current-value',
  },
  ['hs.image.getExifFromPath'] = {
    newSignature = 'hs.image.getExifFromPath(path) -> table<string, any> | nil',
    originalSignature = 'hs.image.getExifFromPath(path) -> table | nil',
  },
  ['hs.image:colorAt'] = {
    newSignature = 'hs.image:colorAt(point) -> hs.drawing.color',
    originalSignature = 'hs.image:colorAt(point) -> table',
  },
  ['hs.json.decode'] = {
    newSignature = 'hs.json.decode(jsonString) -> table<string, any>',
    originalSignature = 'hs.json.decode(jsonString) -> table',
  },
  ['hs.json.read'] = {
    newSignature = 'hs.json.read(path) -> table<string, any> | nil',
    originalSignature = 'hs.json.read(path) -> table | nil',
  },
  ['hs.keycodes.layouts'] = {
    newSignature = 'hs.keycodes.layouts([sourceID]) -> string[]',
    originalSignature = 'hs.keycodes.layouts([sourceID]) -> table',
  },
  ['hs.keycodes.methods'] = {
    newSignature = 'hs.keycodes.methods([sourceID]) -> string[]',
    originalSignature = 'hs.keycodes.methods([sourceID]) -> table',
  },
  ['hs.location:currentRegion'] = {
    newSignature = 'hs.location:currentRegion() -> string | nil',
    originalSignature = 'hs.location:currentRegion() -> identifier | nil',
  },
  ['hs.math.randomFromRange'] = {
    newSignature = 'hs.math.randomFromRange(start, end_) -> integer',
    originalSignature = 'hs.math.randomFromRange(start, end) -> integer',
  },
  ['hs.menubar:autosaveName'] = {
    newSignature = 'hs.menubar:autosaveName([name]) -> hs.menubar | string',
    originalSignature = 'hs.menubar:autosaveName([name]) -> menubaritem | current-value',
  },
  ['hs.menubar:imagePosition'] = {
    newSignature = 'hs.menubar:imagePosition([position]) -> hs.menubar | string',
    originalSignature = 'hs.menubar:imagePosition([position]) -> menubaritem | current-value',
  },
  ['hs.menubar:stateImageSize'] = {
    newSignature = 'hs.menubar:stateImageSize([size]) -> hs.image | table<string, number>',
    originalSignature = 'hs.menubar:stateImageSize([size]) -> hs.image object | current value',
  },
  ['hs.midi.devices'] = {
    newSignature = 'hs.midi.devices() -> string[]',
    originalSignature = 'hs.midi.devices() -> table',
  },
  ['hs.midi.virtualSources'] = {
    newSignature = 'hs.midi.virtualSources() -> string[]',
    originalSignature = 'hs.midi.virtualSources() -> table',
  },
  ['hs.mouse.names'] = {
    newSignature = 'hs.mouse.names() -> string[]',
    originalSignature = 'hs.mouse.names() -> table',
  },
  ['hs.network.addresses'] = {
    newSignature = 'hs.network.addresses([interface_list]) -> string[]',
    originalSignature = 'hs.network.addresses([interface_list]) -> table',
  },
  ['hs.network.configuration:contents'] = {
    newSignature = 'hs.network.configuration:contents([keys], [pattern]) -> table<string, any>',
    originalSignature = 'hs.network.configuration:contents([keys], [pattern]) -> table',
  },
  ['hs.network.configuration:dhcpInfo'] = {
    newSignature = 'hs.network.configuration:dhcpInfo([serviceID]) -> table<string, any>',
    originalSignature = 'hs.network.configuration:dhcpInfo([serviceID]) -> table',
  },
  ['hs.network.configuration:keys'] = {
    newSignature = 'hs.network.configuration:keys([keypattern]) -> string[]',
    originalSignature = 'hs.network.configuration:keys([keypattern]) -> table',
  },
  ['hs.network.configuration:location'] = {
    newSignature = 'hs.network.configuration:location() -> string',
    originalSignature = 'hs.network.configuration:location() -> location',
  },
  ['hs.network.configuration:locations'] = {
    newSignature = 'hs.network.configuration:locations() -> table<string, string>',
    originalSignature = 'hs.network.configuration:locations() -> table',
  },
  ['hs.network.configuration:setCallback'] = {
    newSignature = 'hs.network.configuration:setCallback(fn) -> storeObject',
    originalSignature = 'hs.network.configuration:setCallback(function) -> storeObject',
  },
  ['hs.network.host.addressesForHostname'] = {
    newSignature = 'hs.network.host.addressesForHostname(name[, fn]) -> string[] | hs.network.host',
    originalSignature = 'hs.network.host.addressesForHostname(name[, fn]) -> table | hostObject',
  },
  ['hs.network.host.hostnamesForAddress'] = {
    newSignature = 'hs.network.host.hostnamesForAddress(address[, fn]) -> string[] | hs.network.host',
    originalSignature = 'hs.network.host.hostnamesForAddress(address[, fn]) -> table | hostObject',
  },
  ['hs.network.interfaces'] = {
    newSignature = 'hs.network.interfaces() -> string[]',
    originalSignature = 'hs.network.interfaces() -> table',
  },
  ['hs.network.ping.echoRequest:acceptAddressFamily'] = {
    newSignature = 'hs.network.ping.echoRequest:acceptAddressFamily([family]) -> hs.network.ping.echoRequest | string',
    originalSignature = 'hs.network.ping.echoRequest:acceptAddressFamily([family]) -> echoRequestObject | current value',
  },
  ['hs.network.reachability:setCallback'] = {
    newSignature = 'hs.network.reachability:setCallback(fn) -> hs.network.reachability',
    originalSignature = 'hs.network.reachability:setCallback(function) -> reachabilityObject',
  },
  ['hs.noises.new'] = {
    newSignature = 'hs.noises.new(fn) -> hs.noises',
    originalSignature = 'hs.noises.new(fn) -> listener',
  },
  ['hs.notify.deliveredNotifications'] = {
    newSignature = 'hs.notify.deliveredNotifications() -> hs.notify[]',
    originalSignature = 'hs.notify.deliveredNotifications() -> table',
  },
  ['hs.notify.new'] = {
    newSignature = 'hs.notify.new([fn,][attributes]) -> hs.notify',
    originalSignature = 'hs.notify.new([fn,][attributes]) -> notification',
  },
  ['hs.notify.register'] = {
    newSignature = 'hs.notify.register(tag, fn) -> number',
    originalSignature = 'hs.notify.register(tag, fn) -> id',
  },
  ['hs.notify.scheduledNotifications'] = {
    newSignature = 'hs.notify.scheduledNotifications() -> hs.notify[]',
    originalSignature = 'hs.notify.scheduledNotifications() -> table',
  },
  ['hs.notify.show'] = {
    newSignature = 'hs.notify.show(title, subTitle, information[, tag]) -> hs.notify',
    originalSignature = 'hs.notify.show(title, subTitle, information[, tag]) -> notification',
  },
  ['hs.notify.unregister'] = {
    newSignature = 'hs.notify.unregister(idOrTag)',
    originalSignature = 'hs.notify.unregister(id|tag)',
  },
  ['hs.notify:actionButtonTitle'] = {
    newSignature = 'hs.notify:actionButtonTitle([buttonTitle]) -> hs.notify | string',
    originalSignature = 'hs.notify:actionButtonTitle([buttonTitle]) -> notificationObject | current-setting',
  },
  ['hs.notify:additionalActions'] = {
    newSignature = 'hs.notify:additionalActions([actionsTable]) -> hs.notify | string[]',
    originalSignature = 'hs.notify:additionalActions([actionsTable]) -> notificationObject | table',
  },
  ['hs.notify:alwaysPresent'] = {
    newSignature = 'hs.notify:alwaysPresent([alwaysPresent]) -> hs.notify | boolean',
    originalSignature = 'hs.notify:alwaysPresent([alwaysPresent]) -> notificationObject | current-setting',
  },
  ['hs.notify:autoWithdraw'] = {
    newSignature = 'hs.notify:autoWithdraw([shouldWithdraw]) -> hs.notify | boolean',
    originalSignature = 'hs.notify:autoWithdraw([shouldWithdraw]) -> notificationObject | current-setting',
  },
  ['hs.notify:contentImage'] = {
    newSignature = 'hs.notify:contentImage([image]) -> hs.notify | hs.image',
    originalSignature = 'hs.notify:contentImage([image]) -> notificationObject | current-setting',
  },
  ['hs.notify:getFunctionTag'] = {
    newSignature = 'hs.notify:getFunctionTag() -> string | nil',
    originalSignature = 'hs.notify:getFunctionTag() -> functiontag',
  },
  ['hs.notify:hasActionButton'] = {
    newSignature = 'hs.notify:hasActionButton([hasButton]) -> hs.notify',
    originalSignature = 'hs.notify:hasActionButton([hasButton]) -> notificationObject | current-setting',
  },
  ['hs.notify:informativeText'] = {
    newSignature = 'hs.notify:informativeText([informativeText]) -> hs.notify | string',
    originalSignature = 'hs.notify:informativeText([informativeText]) -> notificationObject | current-setting',
  },
  ['hs.notify:otherButtonTitle'] = {
    newSignature = 'hs.notify:otherButtonTitle([buttonTitle]) -> hs.notify | string',
    originalSignature = 'hs.notify:otherButtonTitle([buttonTitle]) -> notificationObject | current-setting',
  },
  ['hs.notify:soundName'] = {
    newSignature = 'hs.notify:soundName([soundName]) -> hs.notify | string',
    originalSignature = 'hs.notify:soundName([soundName]) -> notificationObject | current-setting',
  },
  ['hs.notify:subTitle'] = {
    newSignature = 'hs.notify:subTitle([subtitleText]) -> hs.notify | string',
    originalSignature = 'hs.notify:subTitle([subtitleText]) -> notificationObject | current-setting',
  },
  ['hs.notify:title'] = {
    newSignature = 'hs.notify:title([titleText]) -> hs.notify | string',
    originalSignature = 'hs.notify:title([titleText]) -> notificationObject | current-setting',
  },
  ['hs.pasteboard.allContentTypes'] = {
    newSignature = 'hs.pasteboard.allContentTypes([name]) -> string[][]',
    originalSignature = 'hs.pasteboard.allContentTypes([name]) -> table',
  },
  ['hs.pasteboard.contentTypes'] = {
    newSignature = 'hs.pasteboard.contentTypes([name]) -> string[]',
    originalSignature = 'hs.pasteboard.contentTypes([name]) -> table',
  },
  ['hs.pasteboard.pasteboardTypes'] = {
    newSignature = 'hs.pasteboard.pasteboardTypes([name]) -> string[]',
    originalSignature = 'hs.pasteboard.pasteboardTypes([name]) -> table',
  },
  ['hs.pasteboard.readURL'] = {
    newSignature = 'hs.pasteboard.readURL([name], [all]) -> string | string[]',
    originalSignature = 'hs.pasteboard.readURL([name], [all]) -> string or array of strings representing file or resource urls',
  },
  ['hs.pasteboard.watcher:start'] = {
    newSignature = 'hs.pasteboard.watcher:start() -> hs.pasteboard.watcher',
    originalSignature = 'hs.pasteboard.watcher:start() -> timer',
  },
  ['hs.pasteboard.watcher:stop'] = {
    newSignature = 'hs.pasteboard.watcher:stop() -> hs.pasteboard.watcher',
    originalSignature = 'hs.pasteboard.watcher:stop() -> timer',
  },
  ['hs.screen.find'] = {
    newSignature = 'hs.screen.find(hint) -> hs.screen ...',
    originalSignature = 'hs.screen.find(hint) -> hs.screen object(s)',
  },
  ['hs.screen:getInfo'] = {
    newSignature = 'hs.screen:getInfo() -> table<string, any> | nil',
    originalSignature = 'hs.screen:getInfo() -> table or nil',
  },
  ['hs.screen:snapshot'] = {
    newSignature = 'hs.screen:snapshot([rect]) -> hs.image',
    originalSignature = 'hs.screen:snapshot([rect]) -> object',
  },
  ['hs.screenRecordingState'] = {
    newSignature = 'hs.screenRecordingState(shouldPrompt) -> boolean',
    originalSignature = 'hs.screenRecordingState(shouldPrompt) -> isEnabled',
  },
  ['hs.serial.availablePortNames'] = {
    newSignature = 'hs.serial.availablePortNames() -> string[]',
    originalSignature = 'hs.serial.availablePortNames() -> table',
  },
  ['hs.serial.availablePortPaths'] = {
    newSignature = 'hs.serial.availablePortPaths() -> string[]',
    originalSignature = 'hs.serial.availablePortPaths() -> table',
  },
  ['hs.settings.get'] = {
    newSignature = 'hs.settings.get(key) -> string | boolean | number | nil | table<string, any>',
    originalSignature = 'hs.settings.get(key) -> string or boolean or number or nil or table or binary data',
  },
  ['hs.settings.getKeys'] = {
    newSignature = 'hs.settings.getKeys() -> table<string | number, string | boolean>',
    originalSignature = 'hs.settings.getKeys() -> table',
  },
  ['hs.settings.watchKey'] = {
    newSignature = 'hs.settings.watchKey(identifier, key, [fn]) -> string | function | nil',
    originalSignature = 'hs.settings.watchKey(identifier, key, [fn]) -> identifier | current value',
  },
  ['hs.sharing.fileURL'] = {
    newSignature = 'hs.sharing.fileURL(path) -> string[]',
    originalSignature = 'hs.sharing.fileURL(path) -> table',
  },
  ['hs.sharing.shareTypesFor'] = {
    newSignature = 'hs.sharing.shareTypesFor(items) -> string[]',
    originalSignature = 'hs.sharing.shareTypesFor(items) -> identifiersTable',
  },
  ['hs.sharing:attachments'] = {
    newSignature = 'hs.sharing:attachments() -> string[] | nil',
    originalSignature = 'hs.sharing:attachments() -> table | nil',
  },
  ['hs.sharing:recipients'] = {
    newSignature = 'hs.sharing:recipients([recipients]) -> string[] | hs.sharing',
    originalSignature = 'hs.sharing:recipients([recipients]) -> current value | sharingObject',
  },
  ['hs.sharing:subject'] = {
    newSignature = 'hs.sharing:subject([subject]) -> hs.sharing | string',
    originalSignature = 'hs.sharing:subject([subject]) -> current value | sharingObject',
  },
  ['hs.shortcuts.list'] = {
    newSignature = 'hs.shortcuts.list() -> any[]',
    originalSignature = 'hs.shortcuts.list() -> []',
  },
  ['hs.socket:listen'] = {
    newSignature = 'hs.socket:listen(portOrPath) -> self or nil',
    originalSignature = 'hs.socket:listen(port|path) -> self or nil',
  },
  ['hs.sound.getAudioEffectNames'] = {
    newSignature = 'hs.sound.getAudioEffectNames() -> string[]',
    originalSignature = 'hs.sound.getAudioEffectNames() -> table',
  },
  ['hs.sound.soundFileTypes'] = {
    newSignature = 'hs.sound.soundFileTypes() -> string[]',
    originalSignature = 'hs.sound.soundFileTypes() -> table',
  },
  ['hs.sound.soundTypes'] = {
    newSignature = 'hs.sound.soundTypes() -> string[]',
    originalSignature = 'hs.sound.soundTypes() -> table',
  },
  ['hs.sound.systemSounds'] = {
    newSignature = 'hs.sound.systemSounds() -> string[]',
    originalSignature = 'hs.sound.systemSounds() -> table',
  },
  ['hs.sound:device'] = {
    newSignature = 'hs.sound:device([deviceUID]) -> hs.sound | string',
    originalSignature = 'hs.sound:device([deviceUID]) -> soundObject | UID string',
  },
  ['hs.sound:name'] = {
    newSignature = 'hs.sound:name([soundName]) -> hs.sound | string',
    originalSignature = 'hs.sound:name([soundName]) -> soundObject | name string',
  },
  ['hs.sound:setCallback'] = {
    newSignature = 'hs.sound:setCallback(fn) -> soundObject',
    originalSignature = 'hs.sound:setCallback(function) -> soundObject',
  },
  ['hs.speech.attributesForVoice'] = {
    newSignature = 'hs.speech.attributesForVoice(voice) -> table<string, any>',
    originalSignature = 'hs.speech.attributesForVoice(voice) -> table',
  },
  ['hs.speech.availableVoices'] = {
    newSignature = 'hs.speech.availableVoices([full]) -> string[]',
    originalSignature = 'hs.speech.availableVoices([full]) -> array',
  },
  ['hs.speech.listener:blocksOtherRecognizers'] = {
    newSignature = 'hs.speech.listener:blocksOtherRecognizers([flag]) -> hs.speech.listener | boolean',
    originalSignature = 'hs.speech.listener:blocksOtherRecognizers([flag]) -> recognizerObject | current value',
  },
  ['hs.speech.listener:commands'] = {
    newSignature = 'hs.speech.listener:commands([commandsArray]) -> hs.speech.listener | string[]',
    originalSignature = 'hs.speech.listener:commands([commandsArray]) -> recognizerObject | current value',
  },
  ['hs.speech.listener:foregroundOnly'] = {
    newSignature = 'hs.speech.listener:foregroundOnly([flag]) -> hs.speech.listener | boolean',
    originalSignature = 'hs.speech.listener:foregroundOnly([flag]) -> recognizerObject | current value',
  },
  ['hs.speech.listener:title'] = {
    newSignature = 'hs.speech.listener:title([title]) -> hs.speech.listener | string',
    originalSignature = 'hs.speech.listener:title([title]) -> recognizerObject | current value',
  },
  ['hs.speech:voice'] = {
    newSignature = 'hs.speech:voice([full] | [voice]) -> hs.speech | string',
    originalSignature = 'hs.speech:voice([full] | [voice]) -> synthesizerObject | voice',
  },
  ['hs.speech:volume'] = {
    newSignature = 'hs.speech:volume([volume]) -> hs.speech | number',
    originalSignature = 'hs.speech:volume([volume]) -> synthesizerObject | volume',
  },
  ['hs.spotlight.group:value'] = {
    newSignature = 'hs.spotlight.group:value() -> hs.spotlight.group[] | nil',
    originalSignature = 'hs.spotlight.group:value() -> value',
  },
  ['hs.spotlight.item:attributes'] = {
    newSignature = 'hs.spotlight.item:attributes() -> string[]',
    originalSignature = 'hs.spotlight.item:attributes() -> table',
  },
  ['hs.spotlight:callbackMessages'] = {
    newSignature = 'hs.spotlight:callbackMessages([messages]) -> string[] | hs.spotlight',
    originalSignature = 'hs.spotlight:callbackMessages([messages]) -> table | spotlightObject',
  },
  ['hs.styledtext.fontFamilies'] = {
    newSignature = 'hs.styledtext.fontFamilies() -> string[]',
    originalSignature = 'hs.styledtext.fontFamilies() -> table',
  },
  ['hs.styledtext.fontNames'] = {
    newSignature = 'hs.styledtext.fontNames() -> string[]',
    originalSignature = 'hs.styledtext.fontNames() -> table',
  },
  ['hs.styledtext.fontNamesWithTraits'] = {
    newSignature = 'hs.styledtext.fontNamesWithTraits(fontTraitMask) -> string[]',
    originalSignature = 'hs.styledtext.fontNamesWithTraits(fontTraitMask) -> table',
  },
  ['hs.styledtext.fontPath'] = {
    newSignature = 'hs.styledtext.fontPath(font) -> string',
    originalSignature = 'hs.styledtext.fontPath(font) -> table',
  },
  ['hs.styledtext:gmatch'] = {
    newSignature = 'hs.styledtext:gmatch(pattern) -> function',
    originalSignature = 'hs.styledtext:gmatch(pattern) -> iterator-function',
  },
  ['hs.styledtext:match'] = {
    newSignature = 'hs.styledtext:match(pattern, [init]) -> string ... | nil',
    originalSignature = 'hs.styledtext:match(pattern, [init]) -> match ... | nil',
  },
  ['hs.tangent.sendPanelConnectionStatesRequest'] = {
    newSignature = 'hs.tangent.sendPanelConnectionStatesRequest()',
    originalSignature = 'hs.tangent.sendPanelConnectionStatesRequest())',
  },
  ['hs.task:environment'] = {
    newSignature = 'hs.task:environment() -> table<string, string>',
    originalSignature = 'hs.task:environment() -> environment',
  },
  ['hs.task:terminationReason'] = {
    newSignature = 'hs.task:terminationReason() -> string | boolean',
    originalSignature = 'hs.task:terminationReason() -> exitCode | false',
  },
  ['hs.task:terminationStatus'] = {
    newSignature = 'hs.task:terminationStatus() -> string | boolean',
    originalSignature = 'hs.task:terminationStatus() -> exitCode | false',
  },
  ['hs.urlevent.getAllHandlersForScheme'] = {
    newSignature = 'hs.urlevent.getAllHandlersForScheme(scheme) -> string[]',
    originalSignature = 'hs.urlevent.getAllHandlersForScheme(scheme) -> table',
  },
  ['hs.webview.toolbar.attachToolbar'] = {
    newSignature = 'hs.webview.toolbar.attachToolbar([obj1], [obj2]) -> hs.webview.toolbar | nil',
    originalSignature = 'hs.webview.toolbar.attachToolbar([obj1], [obj2]) -> obj1',
  },
  ['hs.webview.toolbar:allowedItems'] = {
    newSignature = 'hs.webview.toolbar:allowedItems() -> string[]',
    originalSignature = 'hs.webview.toolbar:allowedItems() -> array',
  },
  ['hs.webview.toolbar:identifier'] = {
    newSignature = 'hs.webview.toolbar:identifier() -> string',
    originalSignature = 'hs.webview.toolbar:identifier() -> identifier',
  },
  ['hs.webview.toolbar:items'] = {
    newSignature = 'hs.webview.toolbar:items() -> string[]',
    originalSignature = 'hs.webview.toolbar:items() -> array',
  },
  ['hs.webview.toolbar:savedSettings'] = {
    newSignature = 'hs.webview.toolbar:savedSettings() -> table<string, any>',
    originalSignature = 'hs.webview.toolbar:savedSettings() -> table',
  },
  ['hs.webview.toolbar:visibleItems'] = {
    newSignature = 'hs.webview.toolbar:visibleItems() -> hs.webview.toolbar[]',
    originalSignature = 'hs.webview.toolbar:visibleItems() -> array',
  },
  ['hs.webview:allowGestures'] = {
    newSignature = 'hs.webview:allowGestures([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:allowGestures([value]) -> webviewObject | current value',
  },
  ['hs.webview:allowMagnificationGestures'] = {
    newSignature = 'hs.webview:allowMagnificationGestures([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:allowMagnificationGestures([value]) -> webviewObject | current value',
  },
  ['hs.webview:allowNavigationGestures'] = {
    newSignature = 'hs.webview:allowNavigationGestures([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:allowNavigationGestures([value]) -> webviewObject | current value',
  },
  ['hs.webview:allowNewWindows'] = {
    newSignature = 'hs.webview:allowNewWindows([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:allowNewWindows([value]) -> webviewObject | current value',
  },
  ['hs.webview:allowTextEntry'] = {
    newSignature = 'hs.webview:allowTextEntry([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:allowTextEntry([value]) -> webviewObject | current value',
  },
  ['hs.webview:alpha'] = {
    newSignature = 'hs.webview:alpha([alpha]) -> hs.webview | number',
    originalSignature = 'hs.webview:alpha([alpha]) -> webviewObject | currentValue',
  },
  ['hs.webview:attachedToolbar'] = {
    newSignature = 'hs.webview:attachedToolbar([toolbar]) -> hs.webview | hs.webview.toolbar',
    originalSignature = 'hs.webview:attachedToolbar([toolbar]) -> webviewObject | currentValue',
  },
  ['hs.webview:behaviorAsLabels'] = {
    newSignature = 'hs.webview:behaviorAsLabels(behaviorTable) -> hs.webview | string[]',
    originalSignature = 'hs.webview:behaviorAsLabels(behaviorTable) -> webviewObject | currentValue',
  },
  ['hs.webview:children'] = {
    newSignature = 'hs.webview:children() -> hs.webview[]',
    originalSignature = 'hs.webview:children() -> array',
  },
  ['hs.webview:closeOnEscape'] = {
    newSignature = 'hs.webview:closeOnEscape([flag]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:closeOnEscape([flag]) -> webviewObject | current value',
  },
  ['hs.webview:deleteOnClose'] = {
    newSignature = 'hs.webview:deleteOnClose([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:deleteOnClose([value]) -> webviewObject | current value',
  },
  ['hs.webview:examineInvalidCertificates'] = {
    newSignature = 'hs.webview:examineInvalidCertificates([flag]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:examineInvalidCertificates([flag]) -> webviewObject | current value',
  },
  ['hs.webview:frame'] = {
    newSignature = 'hs.webview:frame([rect]) -> hs.webview | table<string, number>',
    originalSignature = 'hs.webview:frame([rect]) -> webviewObject | currentValue',
  },
  ['hs.webview:level'] = {
    newSignature = 'hs.webview:level([theLevel]) -> hs.drawing | integer',
    originalSignature = 'hs.webview:level([theLevel]) -> drawingObject | currentValue',
  },
  ['hs.webview:magnification'] = {
    newSignature = 'hs.webview:magnification([value]) -> hs.webview | number',
    originalSignature = 'hs.webview:magnification([value]) -> webviewObject | current value',
  },
  ['hs.webview:navigationID'] = {
    newSignature = 'hs.webview:navigationID() -> string',
    originalSignature = 'hs.webview:navigationID() -> navigationID',
  },
  ['hs.webview:shadow'] = {
    newSignature = 'hs.webview:shadow([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:shadow([value]) -> webviewObject | current value',
  },
  ['hs.webview:size'] = {
    newSignature = 'hs.webview:size([size]) -> hs.webview | table<string, number>',
    originalSignature = 'hs.webview:size([size]) -> webviewObject | currentValue',
  },
  ['hs.webview:topLeft'] = {
    newSignature = 'hs.webview:topLeft([point]) -> hs.webview | table<string, number>',
    originalSignature = 'hs.webview:topLeft([point]) -> webviewObject | currentValue',
  },
  ['hs.webview:transparent'] = {
    newSignature = 'hs.webview:transparent([value]) -> hs.webview | boolean',
    originalSignature = 'hs.webview:transparent([value]) -> webviewObject | current value',
  },
  ['hs.webview:urlParts'] = {
    newSignature = 'hs.webview:urlParts() -> string[]',
    originalSignature = 'hs.webview:urlParts() -> table',
  },
  ['hs.webview:userAgent'] = {
    newSignature = 'hs.webview:userAgent([agent]) -> hs.webview | string',
    originalSignature = 'hs.webview:userAgent([agent]) -> webviewObject | current value',
  },
  ['hs.webview:windowStyle'] = {
    newSignature = 'hs.webview:windowStyle(mask) -> hs.webview | integer',
    originalSignature = 'hs.webview:windowStyle(mask) -> webviewObject | currentMask',
  },
  ['hs.wifi.availableNetworks'] = {
    newSignature = 'hs.wifi.availableNetworks([interface]) -> string[]',
    originalSignature = 'hs.wifi.availableNetworks([interface]) -> table',
  },
  ['hs.wifi.interfaces'] = {
    newSignature = 'hs.wifi.interfaces() -> string[]',
    originalSignature = 'hs.wifi.interfaces() -> table',
  },
  ['hs.wifi.watcher:watchingFor'] = {
    newSignature = 'hs.wifi.watcher:watchingFor([messages]) -> hs.wifi.watcher | string[]',
    originalSignature = 'hs.wifi.watcher:watchingFor([messages]) -> watcher | current-value',
  },
  ['hs.window.filter:getFilters'] = {
    newSignature = 'hs.window.filter:getFilters() -> table<string, any>',
    originalSignature = 'hs.window.filter:getFilters() -> table',
  },
  ['hs.window.list'] = {
    newSignature = 'hs.window.list(allWindows) -> table<string, any>[]',
    originalSignature = 'hs.window.list(allWindows) -> table',
  },
}

-- vim:foldlevel=1
