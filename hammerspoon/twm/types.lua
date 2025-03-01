---@alias Layout 'h_tiled' | 'v_tiled' | 'accordion'

---@class SavedWorkspace
---@field layout Layout
---@field children (SavedWorkspace | string)[]

---@alias MonitorConfiguration table<string, SavedWorkspace[]>
