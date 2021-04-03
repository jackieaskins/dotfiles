local M = {}

function M.handle_jdt_uri(uri)
  vim.api.nvim_buf_set_option(0, 'filetype', 'java')

  local buf = vim.api.nvim_get_current_buf()

  local timeout_ms = 1000
  local params = { uri = uri }
  local response, err = vim.lsp.buf_request_sync(0, 'java/classFileContents', params, timeout_ms)

  local get_buf_content = function()
    if err then
      return 'An error occurred retrieving class file contents ' .. err
    end

    return vim.split(response[1].result, '\n', true)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, get_buf_content())
end

function M.configure(config)
  config.cmd = { 'run_jdtls.sh' }
  config.init_options = {
    extendedClientCapabilities = {
      advancedExtractRefactoringSupport = true;
      advancedOrganizeImportsSupport = true;
      classFileContentsSupport = true;
      generateToStringPromptSupport = true;
      generateConstructorsPromptSupport = true;
      generateDelegateMethodsPromptSupport = true;
      hashCodeEqualsPromptSupport = true;
      inferSelectionSupport = {"extractMethod", "extractVariable"};
      moveRefactoringSupport = true;
      overrideMethodsPromptSupport = true;
    }
  }

  return config
end

return M