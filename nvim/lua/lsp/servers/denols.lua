vim.g.markdown_fenced_languages = {
  'ts=typescript',
}

---@type LspServer
return {
  install = { 'brew', 'deno' },
  config = function(config)
    config.root_dir = require('lspconfig').util.root_pattern('deno.json', 'deno.jsonc')
    return config
  end,
}
