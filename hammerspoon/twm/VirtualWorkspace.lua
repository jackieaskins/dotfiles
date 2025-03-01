local fnutils = require('fnutils')
local WindowTreeNode = require('twm.WindowTreeNode')
local twmUtils = require('twm.utils')

---@class VirtualWorkspace
---@field id number
---@field screen hs.screen
---@field private fullscreen boolean
---@field private windowTree WindowTreeNode
---@field private windowIdTreeNodeMap table<number, WindowTreeNode>
local VirtualWorkspace = {}
VirtualWorkspace.__index = VirtualWorkspace

---@private
---@param defaultLayout SavedWorkspace
---@param parent? WindowTreeNode
---@param windowsByAppName table<string, hs.window[]>
---@return WindowTreeNode
function VirtualWorkspace:generateWindowTreeNode(defaultLayout, parent, windowsByAppName)
  local node = WindowTreeNode.new(defaultLayout.layout, nil, {}, parent)

  for _, child in ipairs(defaultLayout.children) do
    if type(child) == 'string' then
      local windows = windowsByAppName[child] or {}
      for _, window in ipairs(windows) do
        local childNode = WindowTreeNode.new(nil, window, {}, node)
        table.insert(node.children, childNode)
        self.windowIdTreeNodeMap[window:id()] = childNode
      end
    else
      table.insert(node.children, self:generateWindowTreeNode(child, node, windowsByAppName))
    end
  end

  return node
end

---Create a virtual workspace
---@param id number
---@param screenUUID string
---@param defaultLayout SavedWorkspace
---@param windowsByAppName table<string, hs.window[]>
---@return VirtualWorkspace
function VirtualWorkspace.new(id, screenUUID, defaultLayout, windowsByAppName)
  local self = setmetatable({}, VirtualWorkspace)

  self.id = id
  self.screen = hs.screen.find(screenUUID) --[[@as hs.screen]]
  self.windowIdTreeNodeMap = {}
  self.fullscreen = false

  self.windowTree = self:generateWindowTreeNode(defaultLayout, nil, windowsByAppName)

  return self
end

---Add window to workspace
---@param window hs.window
function VirtualWorkspace:addWindow(window)
  local node = self.windowTree:addWindow(window)
  self.windowIdTreeNodeMap[window:id()] = node
end

---Remove window from workspace
---@param window hs.window
function VirtualWorkspace:removeWindow(window)
  local windowId = window:id()
  assert(windowId)

  local node = self.windowIdTreeNodeMap[windowId]
  node:remove()
  self.windowIdTreeNodeMap[windowId] = nil
end

---Show workspace windows and focus the most recently focused window
function VirtualWorkspace:focus()
  self:showWindows()

  local focusedWindow = hs.window.focusedWindow()
  if not focusedWindow or not self.windowIdTreeNodeMap[focusedWindow:id()] then
    local windows = require('twm.windowFilter'):getWindows(hs.window.filter.sortByFocusedLast)

    for _, window in ipairs(windows) do
      if self.windowIdTreeNodeMap[window:id()] then
        window:focus()
        break
      end
    end
  end
end

---Show workspace windows
function VirtualWorkspace:showWindows()
  local paddedScreenFrame = twmUtils.getPaddedScreenFrame(self.screen)

  if self.fullscreen then
    for _, window in ipairs(self:getWindows()) do
      twmUtils.setWindowFrame(window, paddedScreenFrame)
    end
  else
    self.windowTree:draw(paddedScreenFrame)
  end
end

---Hide workspace windows
function VirtualWorkspace:hideWindows()
  self.windowTree:hide(self.screen:fullFrame())
end

---Swap windows in workspace
---@param toWindow hs.window
---@param fromWindow hs.window
function VirtualWorkspace:swapWindows(toWindow, fromWindow)
  local fromNode = self.windowIdTreeNodeMap[fromWindow:id()]
  local fromParent = fromNode.parent
  local fromIndex = hs.fnutils.indexOf(fromParent.children, fromNode)

  local toNode = self.windowIdTreeNodeMap[toWindow:id()]
  local toParent = toNode.parent
  local toIndex = hs.fnutils.indexOf(toParent.children, toNode)

  assert(fromIndex)
  assert(toIndex)

  fromParent.children[fromIndex] = toNode
  toParent.children[toIndex] = fromNode

  fromNode.parent = toParent
  toNode.parent = fromParent

  self:showWindows()
end

---Get the workspace window ids
---@return number[]
function VirtualWorkspace:getWindowIds()
  return fnutils.getKeys(self.windowIdTreeNodeMap)
end

---Get the workspace windows
---@return hs.window[]
function VirtualWorkspace:getWindows()
  return hs.fnutils.imap(self:getWindowIds(), function(windowId)
    return hs.window.get(windowId)
  end)
end

function VirtualWorkspace:toggleFullscreen()
  self.fullscreen = not self.fullscreen
  self:showWindows()
end

return VirtualWorkspace
