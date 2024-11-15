---@class HSModule
---@field desc string
---@field doc string
---@field items HSItem[]
---@field name string
---@field stripped_doc string
---@field submodules string[]
---@field type 'Module'
---@field Command any[]
---@field Constant HSConstant[]
---@field Constructor HSConstructor[]
---@field Deprecated HSDeprecated[]
---@field Field HSField[]
---@field Function HSFunction[]
---@field Method HSFunction[]
---@field Variable HSVariable[]

---@class HSConstant
---@field def string
---@field desc string
---@field doc string
---@field file string
---@field lineno string
---@field name string
---@field notes? string[]
---@field signature string
---@field stripped_doc string
---@field type 'Constant'

---@class HSConstructor
---@field def string
---@field desc string
---@field doc string
---@field examples string[]
---@field file string
---@field lineno string
---@field name string
---@field notes string[]
---@field parameters string[]
---@field returns string[]
---@field signature string
---@field stripped_doc string
---@field type 'Constructor'

---@class HSDeprecated
---@field def string
---@field desc string
---@field doc string
---@field file string
---@field lineno string
---@field name string
---@field notes? string[]
---@field parameters? string[]
---@field returns? string[]
---@field signature string
---@field stripped_doc string
---@field type 'Deprecated'

---@class HSField
---@field def string
---@field desc string
---@field doc string
---@field file string
---@field lineno string
---@field name string
---@field notes? string[]
---@field signature string
---@field stripped_doc string
---@field type 'Field'

---@class HSFunction
---@field def string
---@field desc string
---@field doc string
---@field examples? string[]
---@field file string
---@field lineno string
---@field name string
---@field notes string[]
---@field parameters string[]
---@field returns string[]
---@field signature string
---@field stripped_doc string
---@field type 'Function' | 'Method'

---@class HSVariable
---@field def string
---@field desc string
---@field doc string
---@field file string
---@field lineno string
---@field name string
---@field notes? string[]
---@field parameters? string[]
---@field returns? string[]
---@field signature string
---@field stripped_doc string
---@field type 'Variable'

---@alias HSItem HSConstant | HSFunction | HSVariable | HSFunction | HSConstructor | HSField | HSDeprecated
