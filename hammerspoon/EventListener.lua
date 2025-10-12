---@class EventListener.Event
---@field activeSpacesChanged 'activeSpacesChanged'

---@class EventListener
---@field events EventListener.Event
---@field private eventTimers table<string, hs.timer.delayed>
---@field private subscribers table<string, function[]>
local EventListener = {
  events = { activeSpacesChanged = 'activeSpacesChanged' },
  eventTimers = {},
  subscribers = {},
}

---@param eventName string
---@param callback function
function EventListener.subscribe(eventName, callback)
  local subscribers = EventListener.subscribers[eventName] or {}
  table.insert(subscribers, callback)
  EventListener.subscribers[eventName] = subscribers
end

---@param eventName string
function EventListener.emitEvent(eventName)
  local eventTimer = EventListener.eventTimers[eventName]
    or hs.timer.delayed.new(0.1, function()
      for _, subscriber in ipairs(EventListener.subscribers[eventName] or {}) do
        subscriber()
      end
    end)
  EventListener.eventTimers[eventName] = eventTimer

  eventTimer:stop():start()
end

return EventListener
