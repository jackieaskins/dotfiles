local M = { 'nvim-neotest/neotest', lazy = true }

function M.init()
  local map = require('utils').map

  map('n', ']t', function()
    require('neotest').jump.next()
  end, { desc = 'Go to next test' })
  map('n', '[t', function()
    require('neotest').jump.prev()
  end, { desc = 'Go to previous test' })
  map('n', ']f', function()
    require('neotest').jump.next({ status = 'failed' })
  end, { desc = 'Go to next failed test' })
  map('n', '[f', function()
    require('neotest').jump.prev({ status = 'failed' })
  end, { desc = 'Go to previous failed test' })

  map('n', '<leader>tf', function()
    require('neotest').run.run(vim.fn.expand('%'))
  end, { desc = 'Run tests in file' })
  map('n', '<leader>tn', function()
    require('neotest').run.run()
  end, { desc = 'Run nearest test/namespace' })
  map('n', '<leader>tl', function()
    require('neotest').run.run_last()
  end, { desc = 'Run last test command' })
  map('n', '<leader>ts', function()
    require('neotest').run.stop()
  end, { desc = 'Stop currently running tests' })

  map('n', '<leader>to', function()
    require('neotest').output.open()
  end, { desc = 'Open nearest test output' })
  map('n', '<leader>tO', function()
    require('neotest').output.open({ enter = true })
  end, { desc = 'Open and enter nearest test output' })

  map('n', '<leader>tt', function()
    require('neotest').summary.toggle()
  end, { desc = 'Open test summary window' })
end

function M.config()
  local lib = require('neotest.lib')

  -- TODO: Handle updating parents when running the nearest test

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
    local query = [[
    ((call_expression
      function: (identifier) @func_name (#match? @func_name "^describe")
      arguments: (arguments (_) @namespace.name (_))
    )) @namespace.definition

    ((call_expression
      function: (call_expression) @func_name (#match? @func_name "^describe.each")
      arguments: (arguments (_) @namespace.name (_))
    )) @namespace.definition

    ((call_expression
      function: (identifier) @func_name (#match? @func_name "^(it|test)")
      arguments: (arguments (_) @test.name (_))
    )) @test.definition

    ((call_expression
      function: (call_expression) @func_name (#match? @func_name "^(it|test).each")
      arguments: (arguments (_) @test.name (_))
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

  local function is_test_in_range(node_data, position)
    local position_parts = {}
    for part in vim.gsplit(position, ':', true) do
      table.insert(position_parts, part)
    end

    local file, line, col = position_parts[1], tonumber(position_parts[2]), tonumber(position_parts[3])

    local range = node_data.range
    local start_line, start_col, end_line, end_col = range[1] + 1, range[2] + 1, range[3] + 1, range[4] + 1

    return file == node_data.path and line >= start_line and line <= end_line and col >= start_col and col <= end_col
  end

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

    local test_results = {}
    for _, test_result in ipairs(jest_result.testResults) do
      for _, assertion_result in ipairs(test_result.assertionResults) do
        local position = table.concat({
          test_result.name,
          assertion_result.location.line,
          assertion_result.location.column,
        }, ':')
        local status = status_map[assertion_result.status]

        if status ~= 'pending' then
          local position_results = test_results[position] or { status = 'passed', errors = {} }

          local new_status = position_results.status

          if new_status == 'passed' and (status == 'skipped' or status == 'failed') then
            new_status = status
          elseif new_status == 'skipped' and status == 'failed' then
            new_status = status
          end

          test_results[position] = {
            status = new_status,
            errors = vim.tbl_flatten({ position_results.errors, assertion_result.failureMessages }),
          }
        end
      end
    end

    local results = {}
    for _, node in tree:iter_nodes() do
      local node_data = node:data()
      if node_data.type == 'test' then
        for position, result in pairs(test_results) do
          if is_test_in_range(node_data, position) then
            results[node_data.id] = {
              status = result.status,
              errors = vim.tbl_map(function(err)
                return { message = err }
              end, result.errors),
            }
          end
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
    icons = { running = '' },
    jump = { enabled = true },
  })
end

return M
