local finders = require'telescope.finders'
local sorters = require'telescope.sorters'
local actions = require'telescope.actions'
local pickers = require'telescope.pickers'

-- Configure UI {{{
function configure_ui()
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

-- Add mappings {{{
function add_mappings()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end

  opts = { silent = true, noremap = true }
  buf_set_keymap('n', '<leader>ca', "<cmd>lua require('jdtls').code_action()<CR>", opts)
  buf_set_keymap('v', '<leader>ca', "<esc><cmd>lua require('jdtls').code_action(true)<CR>", opts)
  buf_set_keymap('n', '<leader>dtc', "<cmd>lua require'jdtls'.test_class()<CR>", opts)
  buf_set_keymap('n', '<leader>dtm', "<cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)

  vim.api.nvim_command [[command! -buffer JdtCompile lua require'jdtls'.compile()]]
  vim.api.nvim_command [[command! -buffer JdtUpdateConfig lua require'jdtls'.update_project_config()]]
  vim.api.nvim_command [[command! -buffer JdtJol lua require'jdtls'.jol()]]
  vim.api.nvim_command [[command! -buffer JdtBytecode lua require'jdtls'.javap()]]
  vim.api.nvim_command [[command! -buffer JdtJshell lua require'jdtls'.jshell()]]
end
-- }}}

local M = {}

-- Initialize client {{{
function M.initialize_client()
  local bundles = {
    vim.fn.glob("$HOME/dotfiles/java-debug-latest/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
  }
  vim.list_extend(bundles, vim.split(vim.fn.glob("$HOME/dotfiles/vscode-java-test-latest/server/*.jar"), "\n"))

  configure_ui()
  add_mappings()

  require'jdtls'.start_or_attach({
    capabilities = require'lsp-status'.capabilities,
    on_attach = function(client, bufnr)
      require'lsp-attach'.custom_attach(client, bufnr)
      require'jdtls'.setup_dap()
    end,
    cmd = {'run_jdtls.sh'},
    init_options = {
      bundles = bundles
    }
  })
end
-- }}}

return M
