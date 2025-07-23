---@type vim.lsp.Config
return {
  -- Remove compile_commands.json (use clangd instead)
  -- Maybe should remove c from filetype instead? TBD
  root_markers = { 'buildServer.json', '*.xcodeproj', '*.xcworkspace' },
}
