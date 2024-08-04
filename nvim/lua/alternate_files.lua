local utils = require('utils')

---@class Config
---@field pattern string
---@field alternates table<string, string[]>

---@type Config[]
local configs = {
  {
    --              %1                  %2        %3           %4
    pattern = [[\v^(.+/)?__snapshots__/(.+)\.(spec|test)\.(%(j|t)sx?)\.snap$]],
    alternates = {
      source = { '%1%2.%4' },
      test = { '%1%2.%3.%4' },
    },
  },
  {
    --              %1    %2        %3           %4
    pattern = [[\v^(.+/)?(.+)\.(spec|test)\.(%(j|t)sx?)$]],
    alternates = {
      source = { '%1%2.%4' },
      snapshot = { '%1__snapshots__/%2.%3.%4.snap' },
    },
  },
  {
    --              %1    %2        %3
    pattern = [[\v^(.+/)?(.+)\.(%(j|t)sx?)$]],
    alternates = {
      test = { '%1%2.spec.%3', '%1%2.test.%3' },
      snapshot = { '%1__snapshots__/%2.spec.%3.snap', '%1__snapshots__/%2.test.%3.snap' },
    },
  },
}

---Find the first config where the pattern matches relative_file
---@param relative_file string
---@return table<string, string[]>[] | nil
---@return string[]
local function get_matching_config(relative_file)
  for _, config in ipairs(configs) do
    local matches = vim.fn.matchlist(relative_file, config.pattern)

    if #matches > 0 then
      return config.alternates, matches
    end
  end

  return nil, {}
end

---Parse the given option into a relative file path by using the provided mappings
---@param option string
---@param matches string[]
---@return string
local function parse_option(option, matches)
  local alternate = option

  for i = 2, #matches do
    alternate = alternate:gsub('%%' .. tostring(i - 1), matches[i])
  end

  return alternate
end

local M = {}

M.define_user_commands = function(file, buf)
  local relative_file = vim.fn.fnamemodify(file, ':.')

  local alternates, matches = get_matching_config(relative_file)
  if alternates == nil then
    return
  end

  for type, options in pairs(alternates) do
    for prefix, cmd in pairs({ E = 'edit', V = 'vsplit', S = 'split' }) do
      utils.buf_user_command(buf, prefix .. type, function()
        local choices = {}

        for _, option in ipairs(options) do
          local alternate = parse_option(option, matches)

          if #options == 1 or utils.file_exists(vim.fn.getcwd() .. '/' .. alternate) then
            vim.cmd[cmd](alternate)
            return
          end

          table.insert(choices, alternate)
        end

        vim.ui.select(choices, {
          prompt = 'No ' .. type .. ' file exists, choose filename:',
        }, function(alternate)
          if alternate then
            vim.cmd[cmd](alternate)
          end
        end)
      end)
    end
  end
end

return M
