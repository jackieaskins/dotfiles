---@class WindowTreeNode
---@field layout? Layout
---@field windowId? number
---@field children WindowTreeNode[]
---@field parent? WindowTreeNode
local WindowTreeNode = {}
WindowTreeNode.__index = WindowTreeNode

---Create window tree node
---@param layout? Layout
---@param window? hs.window
---@param children WindowTreeNode[]
---@param parent? WindowTreeNode
---@return WindowTreeNode
function WindowTreeNode.new(layout, window, children, parent)
  local self = setmetatable({}, WindowTreeNode)

  self.layout = layout
  self.windowId = window and window:id() or nil
  self.children = children
  self.parent = parent

  return self
end

---@private
---@param childIndex number
---@param frame hs.geometry
---@return hs.geometry
function WindowTreeNode:getChildFrame(childIndex, frame)
  local windowGap = 15
  local numChildren = #self.children

  if self.layout == 'v_tiled' then
    local w = (frame.w - (windowGap * (numChildren - 1))) / numChildren

    return hs.geometry.rect(frame.x + (childIndex - 1) * (w + windowGap), frame.y, w, frame.h)
  end

  if self.layout == 'h_tiled' then
    local h = (frame.h - (windowGap * (numChildren - 1))) / numChildren

    return hs.geometry.rect(frame.x, frame.y + (childIndex - 1) * (h + windowGap), frame.w, h)
  end

  -- TODO: Offset accordion windows
  return frame
end

---Draw window tree to screen
---@param frame hs.geometry
function WindowTreeNode:draw(frame)
  if self.windowId then
    require('twm.utils').setWindowFrame(hs.window.get(self.windowId), frame)
  elseif self.layout then
    for index, child in ipairs(self.children) do
      child:draw(self:getChildFrame(index, frame))
    end
  end
end

---Hide window tree windows
---@param screenFrame hs.geometry
function WindowTreeNode:hide(screenFrame)
  if self.windowId then
    local window = hs.window.get(self.windowId)

    local windowFrame = window:frame()
    require('twm.utils').setWindowFrame(
      window,
      hs.geometry.rect(screenFrame.x + screenFrame.w, screenFrame.y + screenFrame.h, windowFrame.w, windowFrame.y)
    )
  else
    for _, child in ipairs(self.children) do
      child:hide(screenFrame)
    end
  end
end

---Add window to non-leaf node
---@param window hs.window
---@return WindowTreeNode
function WindowTreeNode:addWindow(window)
  assert(not self.windowId, "Can't add window to leaf node")

  local node = WindowTreeNode.new(nil, window, {}, self)
  table.insert(self.children, node)
  return node
end

---Remove non-root node from tree
function WindowTreeNode:remove()
  local parent = self.parent
  assert(parent, "Can't remove tree root")

  local index = hs.fnutils.indexOf(parent.children, self)
  table.remove(parent.children, index)
end

return WindowTreeNode
