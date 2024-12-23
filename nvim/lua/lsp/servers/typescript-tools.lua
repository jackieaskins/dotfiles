---@type LspServer
return {
  display = 'ts-tools',
  install = {
    'npm',
    table.concat({
      'typescript',
      'typescript-svelte-plugin',
      'typescript-styled-plugin',
    }, ' '),
  },
  skip_lspconfig = true,
}
