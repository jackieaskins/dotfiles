---@class FormatterConfig
---@field required_files? string[]
---@field filetypes string[]

local utils = require('utils')

---@type table<string, FormatterConfig>
local formatters
---@type table<string, string[]>
local formatters_by_ft
local function load_formatters()
  formatters = utils.import_json_file('~/dotfiles/nix/home/modules/neovim/formatters.json')

  formatters_by_ft = {}
  for name, formatter in pairs(formatters) do
    for _, ft in ipairs(formatter.filetypes) do
      local curr_formatters = formatters_by_ft[ft] or {}
      table.insert(curr_formatters, name)
      formatters_by_ft[ft] = curr_formatters
    end
  end
end

local M = {}

---Get formatters for filetype
---@param filetype string
---@return string[]
function M.get_formatters(filetype)
  if not formatters_by_ft then
    load_formatters()
  end

  return formatters_by_ft[filetype] or {}
end

---Get formatters for filetype considering the required file
---@param filetype string
---@return string[]
function M.get_active_formatters(filetype)
  return vim.tbl_filter(function(formatter_name)
    local formatter = formatters[formatter_name]
    return formatter.required_files == nil
      or vim.iter(formatter.required_files):any(function(file)
        return utils.file_exists(file)
      end)
  end, M.get_formatters(filetype))
end

return M
