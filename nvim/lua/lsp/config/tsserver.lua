local map = require('utils').map

local function organize_imports(client, bufnr)
  return function()
    local response = client.request_sync('workspace/executeCommand', {
      command = '_typescript.organizeImports',
      arguments = { vim.api.nvim_buf_get_name(bufnr) },
    }, 1000, bufnr)

    if response.err then
      vim.notify(response.err, vim.log.levels.ERROR)
    end
  end
end

local function import_current(client, bufnr)
  return function()
    local function apply_edits(code_action)
      local response = client.request_sync('workspace/executeCommand', code_action.command, 1000, bufnr)
      if response.err then
        vim.notify(response.err, vim.log.levels.ERROR)
      end
    end

    local params = vim.lsp.util.make_range_params()
    params.context = { diagnostics = vim.diagnostic.get(bufnr) }
    local response = client.request_sync('textDocument/codeAction', params, 1000, bufnr)
    if response.err then
      return vim.notify(response.err, vim.log.levels.ERROR)
    end

    local import_code_actions = vim.tbl_filter(function(result)
      return vim.startswith(result.title, 'Add import') or vim.startswith(result.title, 'Update import from')
    end, response.result)

    if #import_code_actions == 1 then
      apply_edits(import_code_actions[1])
    elseif #import_code_actions > 1 then
      vim.ui.select(import_code_actions, {
        prompt = 'Select import',
        format_item = function(item)
          return item.title
        end,
      }, function(choice)
        if choice ~= nil then
          apply_edits(choice)
        end
      end)
    else
      vim.notify('No import code actions', vim.log.levels.INFO)
    end
  end
end

return function(config)
  local preferences = { format = { indentSize = 2 } }
  config.settings = { javascript = preferences, typescript = preferences }

  config.on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    require('lsp.attach')(client, bufnr)

    local function bsk(mode, lhs, rhs, opts)
      map(mode, lhs, rhs, vim.tbl_extend('keep', { buffer = bufnr }, opts or {}))
    end

    -- TODO: Handle import all
    bsk('n', '<leader>oi', organize_imports(client, bufnr), { desc = 'Organize imports' })
    bsk('n', '<leader>ic', import_current(client, bufnr), { desc = 'Import current' })
  end

  return config
end
