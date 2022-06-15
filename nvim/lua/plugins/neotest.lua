local lib = require('neotest.lib')

---@type neotest.Adapter
local jest_adapter = { name = 'neotest-jest' }

jest_adapter.root = lib.files.match_root_pattern('package.json')

-- TODO: Figure out why vim.match isn't working (would be cleaner)
function jest_adapter.is_test_file(file_path)
  for _, start in ipairs({ '__tests__/.*', '%.spec', '%.test' }) do
    for _, ext in ipairs({ 'js', 'jsx', 'coffee', 'ts', 'tsx' }) do
      if file_path:match(start .. '%.' .. ext .. '$') then
        return true
      end
    end
  end

  return false
end

---@async
---@return neotest.Tree | nil
function jest_adapter.discover_positions(path)
  -- TODO: Make this less fragile (i.e. currently only works with strings)
  local query = [[
    ((call_expression
      function: (identifier) @func_name (#match? @func_name "^describe")
      arguments: (arguments (string (string_fragment) @namespace.name))
    )) @namespace.definition

    ((call_expression
      function: (identifier) @func_name (#match? @func_name "^(it|test)")
      arguments: (arguments (string (string_fragment) @test.name))
    )) @test.definition
  ]]

  return lib.treesitter.parse_positions(path, query, { nested_tests = true })
end

---@param args neotest.RunArgs
---@return neotest.RunSpec | nil
function jest_adapter.build_spec(args)
  if not args.tree then
    return
  end

  local pos = args.tree:data()

  local bin_jest = 'node_modules/.bin/jest'
  local jest = vim.fn.filereadable(bin_jest) == 1 and bin_jest or { 'npx', 'jest' }
  local results_path = vim.fn.tempname() .. '.json'

  local config_dir = require('lspconfig').util.root_pattern('jest.config.js')(pos.path)

  local command = vim.tbl_flatten({
    jest,
    config_dir and '--config=' .. config_dir .. '/jest.config.js' or {},
    '--json',
    '--coverage=false',
    '--outputFile=' .. results_path,
    pos.type ~= 'dir' and '--runTestsByPath' or {},
    '--testLocationInResults',
    vim.tbl_contains({ 'test', 'namespace' }, pos.type) and '--testNamePattern=' .. pos.name or {},
    '--verbose',
    pos.path,
  })

  return {
    command = command,
    context = { results_path = results_path, file = pos.path },
  }
end

local status_map = {
  failed = 'failed',
  broken = 'failed',
  passed = 'passed',
  skipped = 'skipped',
  unknown = 'skipped',
}

---@async
---@param spec neotest.RunSpec
---@param _ neotest.StrategyResult
---@param tree neotest.Tree
---@return neotest.Result[]
function jest_adapter.results(spec, _, tree)
  local success, data = pcall(lib.files.read, spec.context.results_path)
  if not success then
    return {}
  end

  local jest_result = vim.json.decode(data, { luanil = { object = true } })

  local results = {}
  for _, test_result in ipairs(jest_result.testResults) do
    for _, assertion_result in ipairs(test_result.assertionResults) do
      -- TODO: Make this less fragile (i.e. currently only works with strings)
      -- TODO: Handle .each tests
      local test_name = table.concat(
        vim.tbl_flatten({
          test_result.name,
          assertion_result.ancestorTitles,
          assertion_result.title,
        }),
        '::'
      )

      if assertion_result.status ~= 'pending' then
        results[test_name] = {
          status = status_map[assertion_result.status],
          errors = vim.tbl_map(function(err)
            return { message = err }
          end, assertion_result.failureMessages),
        }
      end
    end
  end

  return results
end

setmetatable(jest_adapter, {
  __call = function()
    return jest_adapter
  end,
})

require('neotest').setup({
  adapters = { jest_adapter },
  icons = { running = '' },
})
