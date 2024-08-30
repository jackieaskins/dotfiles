local utils = require('utils')

local snapshots_dir = '__snapshots__/'
local snap_extension = [[\.snap]]

local optional_dir_capture = '(.+/)?'
local test_dir_capture = '(tests?/)'
local file_base_capture = '(.+)'
local test_extension_capture = [[(\.%(spec|test))]]
local extension_capture = [[(\.[^\.]+)]]

---@class Config
---@field pattern string[]
---@field alternates table<string, string[]>

---@type Config[]
local configs = {
  -- Snapshots
  {
    pattern = {
      optional_dir_capture, -- %1
      test_dir_capture, -- %2
      optional_dir_capture, -- %3
      snapshots_dir,
      file_base_capture, -- %4
      test_extension_capture, -- %5
      extension_capture, -- %6
      snap_extension,
    },
    alternates = {
      source = { '%1src/%3%4%6', '%1lib/%3%4%6' },
      test = { '%1%2%3%4%5%6' },
    },
  },
  {
    pattern = {
      optional_dir_capture, -- %1
      snapshots_dir,
      file_base_capture, -- %2
      test_extension_capture, -- %3
      extension_capture, -- %4
      snap_extension,
    },
    alternates = {
      source = { '%1%2%4' },
      test = { '%1%2%3%4' },
    },
  },

  -- Tests
  {
    pattern = {
      optional_dir_capture, -- %1
      test_dir_capture, -- %2
      optional_dir_capture, -- %3
      file_base_capture, -- %4
      test_extension_capture, -- %5
      extension_capture, -- %6
    },
    alternates = {
      source = { '%1src/%3%4%6', '%1lib/%3%4%6' },
      snapshot = { '%1%2%3__snapshots__/%4%5%6.snap' },
    },
  },
  {
    pattern = {
      optional_dir_capture, -- %1
      file_base_capture, -- %2
      test_extension_capture, -- %3
      extension_capture, -- %4
    },
    alternates = {
      source = { '%1%2%4' },
      snapshot = { '%1__snapshots__/%2%3%4' },
    },
  },

  -- Sources
  {
    pattern = {
      optional_dir_capture, -- %1
      [[(%(src|lib)/)]], -- %2
      optional_dir_capture, -- %3
      file_base_capture, -- %4
      extension_capture, -- %5
    },
    alternates = {
      test = {
        '%1%2%3%4.spec%5',
        '%1%2%3%4.test%5',
        '%1test/%3%4.spec%5',
        '%1test/%3%4.test%5',
        '%1tests/%3%4.spec%5',
        '%1tests/%3%4.test%5',
      },
      snapshot = {
        '%1%2%3__snapshots__/%4.spec%5.snap',
        '%1%2%3__snapshots__/%4.test%5.snap',
        '%1test/%3__snapshots__/%4.spec%5.snap',
        '%1test/%3__snapshots__/%4.test%5.snap',
        '%1tests/%3__snapshots__/%4.spec%5.snap',
        '%1tests/%3__snapshots__/%4.test%5.snap',
      },
    },
  },
  {
    pattern = {
      optional_dir_capture, -- %1
      file_base_capture, -- %2
      extension_capture, -- %3
    },
    alternates = {
      test = { '%1%2.spec%3', '%1%2.test%3' },
      snapshot = { '%1__snapshots__/%2.spec%3.snap', '%1__snapshots__/%2.test%3.snap' },
    },
  },
}

---Find the first config where the pattern matches relative_file
---@param relative_file string
---@return table<string, string[]>[] | nil
---@return string[]
local function get_matching_config(relative_file)
  for _, config in ipairs(configs) do
    local regex_pattern = vim.fn.copy(config.pattern)
    table.insert(regex_pattern, 1, [[\v^]])
    table.insert(regex_pattern, '$')

    local matches = vim.fn.matchlist(relative_file, table.concat(regex_pattern))

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

local function load_alternate_files()
  if not vim.b.alternate_files then
    local relative_file = vim.fn.fnamemodify(vim.fn.bufname(), ':.')
    local alternates, matches = get_matching_config(relative_file)

    if alternates then
      vim.b.alternate_files = { alternates = alternates, matches = matches }
    end
  end

  return vim.b.alternate_files or {}
end

local M = {}

function M.get_alternate_types()
  local alt = load_alternate_files()

  if alt then
    return vim.tbl_keys(alt.alternates)
  end

  return {}
end

function M.try_open_alternate(cmd)
  local alt = load_alternate_files()
  if not alt then
    return
  end

  for type, options in pairs(alt.alternates) do
    local choices = {}

    for _, option in ipairs(options) do
      local alternate = parse_option(option, alt.matches)

      if #options == 1 or utils.file_exists(vim.fn.getcwd() .. '/' .. alternate) then
        vim.cmd[cmd](alternate)
        return
      end

      table.insert(choices, alternate)
    end

    vim.ui.select(choices, {
      prompt = 'No ' .. type .. ' file exists, choose filename:',
    }, function(choice)
      if choice then
        vim.cmd[cmd](choice)
      end
    end)
  end
end

return M
