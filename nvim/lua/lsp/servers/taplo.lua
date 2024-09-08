---@type LspServer
return {
  install = function()
    return {
      'cargo install --features lsp --locked taplo-cli',
    }
  end,
}
