local M = {}

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

return M
