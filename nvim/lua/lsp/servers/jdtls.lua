return {
  config = function(config)
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
  end,
  install = function(servers_dir)
    local install_dir = servers_dir .. '/eclipse.jdt.ls'
    local zip_file = 'jdt-language-server-latest.tar.gz'

    return {
      'rm -rf ' .. install_dir,
      'mkdir ' .. install_dir,
      'wget http://download.eclipse.org/jdtls/snapshots/' .. zip_file,
      'tar -xf ' .. zip_file .. ' -C ' .. install_dir,
      'rm ' .. zip_file,
      'cd ' .. install_dir,
      'wget https://projectlombok.org/downloads/lombok.jar',
    }
  end,
}
