local utils = require('utils')
local home_path, tbl_extend = utils.home_path, utils.tbl_extend

---@class Tab
---@field title string
---@field cmd string
---@field cwd string

---@class Workspace
---@field cwd string
---@field tabs Tab[]

---@type table<string, Workspace>
local workspaces = {
  dotfiles = {
    cwd = home_path({ 'dotfiles' }),
    tabs = { { title = 'editor' } },
  },
}

return tbl_extend(workspaces, CUSTOM.workspaces)
