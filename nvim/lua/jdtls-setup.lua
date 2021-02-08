local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local pickers = require'telescope.pickers'

local M = {}

-- Configure UI {{{
function M.configure_ui()
  require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    local index = 0
    pickers.new(opts, {
      prompt_title = prompt,
      finder = finders.new_table {
        results = items,
        entry_maker = function(entry)
          index = index + 1

          return {
            value = entry,
            display = index .. ': ' .. label_fn(entry),
            ordinal = index .. label_fn(entry),
          }
        end,
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr)
        actions.goto_file_selection_edit:replace(function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)

          cb(selection.value)
        end)

        return true
      end,
    }):find()
  end
end
-- }}}

-- Initialize client {{{
function M.initialize_client()
    vim.api.nvim_command [[command! -buffer JdtCompile lua require'jdtls'.compile()]]
    vim.api.nvim_command [[command! -buffer JdtUpdateConfig lua require'jdtls'.update_project_config()]]
    vim.api.nvim_command [[command! -buffer JdtJol lua require'jdtls'.jol()]]
    vim.api.nvim_command [[command! -buffer JdtBytecode lua require'jdtls'.javap()]]
    vim.api.nvim_command [[command! -buffer JdtJshell lua require'jdtls'.jshell()]]

  require'jdtls'.start_or_attach({
    capabilities = require'lsp-attach'.get_capabilities(),
    on_attach = function(client, bufnr)
      require'lsp-attach'.custom_attach(client, bufnr)

      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = { noremap=true, silent=true }
      buf_set_keymap('n', '<leader>ca', "<cmd>lua require('jdtls').code_action()<CR>", opts)
      buf_set_keymap('v', '<leader>ca', "<esc><cmd>lua require('jdtls').code_action(true)<CR>", opts)
    end,
    cmd = {'run_jdtls.sh'}
  })
end
-- }}}

return M
