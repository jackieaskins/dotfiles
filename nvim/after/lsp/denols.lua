vim.g.markdown_fenced_languages = {
  'ts=typescript',
}

---@type vim.lsp.Config
return {
  root_markers = { 'deno.json', 'deno.jsonc' },
}
