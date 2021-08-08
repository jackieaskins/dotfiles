return function(config)
  config.cmd = { 'run_jdtls.sh' }
  config.init_options = {
    extendedClientCapabilities = {
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      inferSelectionSupport = { 'extractMethod', 'extractVariable' },
      moveRefactoringSupport = true,
      overrideMethodsPromptSupport = true,
    },
  }

  return config
end
