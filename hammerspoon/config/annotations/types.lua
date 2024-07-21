---@class HSConstant
---@field def string
---@field desc string
---@field doc string
---@field file string
---@field lineno string
---@field name string
---@field signature string
---@field stripped_doc string
---@field type string

---@class HSFunction: HSConstant
---@field examples string[]
---@field notes string[]
---@field parameters string[]
---@field returns string[]

---@class HSVariable: HSConstant
---@field notes string[]

---@class HSDocString
---@field Command any[]
---@field Constant HSConstant[]
---@field Constructor HSFunction[]
---@field Deprecated HSFunction[]
---@field Field HSVariable[]
---@field Function HSFunction[]
---@field Method HSFunction[]
---@field Variable HSVariable[]
---@field desc string
---@field doc string
---@field items (HSConstant | HSFunction | HSVariable)[]
---@field name string
---@field stripped_doc string
---@field submodules string[]
---@field type string

---@class HSColorTable
---@field alpha number
---@field blue number
---@field green number
---@field red number

---@class HSPointTable
---@field x number
---@field y number

---@class HSPointTable
---@field w number
---@field h number

---@class HSRectTable
---@field x number
---@field y number
---@field w number
---@field h number

---@class HSHSBTable
---@field alpha number
---@field brightness number
---@field hue number
---@field saturation number

---@class HSHotkey
---@field idx string
---@field msg string
