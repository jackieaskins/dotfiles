-- General Settings {{{
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    signs = true,
  }
)
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

vim.g.lsp_utils_location_opts = {
  mode = 'editor',
  list = {
    border = true,
    title = 'Locations',
  },
  preview = {
    border = true,
    title = 'Preview',
  },
}

vim.g.lsp_utils_codeaction_opts = {
  mode = 'editor',
  list = {
    border = true,
    title = 'Code Actions',
  }
}

vim.cmd[[ highlight LspDiagnosticsDefaultHint guifg=#70ace5 ]]

vim.fn.sign_define("LspDiagnosticsSignError", {text = "", texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "🛈", texthl = "LspDiagnosticsSignInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "!", texthl = "LspDiagnosticsSignHint"})
-- }}}

-- Completion {{{
vim.o.completeopt = 'menu,menuone,noselect'
require'compe'.setup {
  enabled = true;
  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  }
}

local compe_opts = { silent = true, expr = true, noremap = true }
vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', compe_opts)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', compe_opts)
vim.api.nvim_set_keymap('i', '<C-f>', 'compe#scroll({ "delta": +4 })', compe_opts)
vim.api.nvim_set_keymap('i', '<C-b>', 'compe#scroll({ "delta": -4 })', compe_opts)

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#confirm']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

local vsnip_opts = { expr = true, silent = true }
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", vsnip_opts)
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", vsnip_opts)

vim.g['vsnip_snippet_dir'] = vim.fn.expand("$HOME/dotfiles/vim-common/snippets/")
-- }}}

-- Status {{{
local lsp_status = require'lsp-status'
lsp_status.register_progress()
-- }}}

-- Lightbulb {{{
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
-- }}}

-- Language Servers {{{
-- https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md
local lspconfig = require'lspconfig'
local custom_attach = require'lsp-attach'.custom_attach
local capabilities = require'lsp-attach'.get_capabilities()

local simple_servers = { "jsonls", "pyright", "solargraph", "vimls" }
for _, server in ipairs(simple_servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = custom_attach
  }
end

-- diagnosticls {{{
local eslint = {
  command = 'eslint_d',
  rootPatterns = {'.git'},
  debounce = 100,
  args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
  sourceName = 'eslint',
  parseJson = {
    errorsRoot = '[0].messages',
    line = 'line',
    column = 'column',
    endLine = 'endLine',
    endColumn = 'endColumn',
    message = '[eslint] ${message} [${ruleId}]',
    security = 'severity'
  },
  securities = {
    [2] = 'error',
    [1] = 'warning'
  }
}

lspconfig.diagnosticls.setup{
  capabilities = capabilities,
  on_attach = custom_attach,
  root_dir = lspconfig.util.root_pattern('.git'),
  filetypes = {'javascript', 'javascriptreact', 'typescript', 'typescriptreact'},
  init_options = {
    linters = {eslint = eslint},
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint'
    }
  }
}
-- }}}

-- jdtls {{{
lspconfig.jdtls.setup {
  capabilities = capabilities,
  on_attach = custom_attach,
  cmd = { 'run_jdtls.sh' },
  init_options = {
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
}
-- }}}

-- sumneko_lua {{{
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = vim.fn.expand('$HOME/dotfiles/lsp-servers/lua-language-server')
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

lspconfig.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  capabilities = capabilities,
  on_attach = custom_attach,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}
-- }}}

-- tsserver {{{
lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    custom_attach(client, bufnr)
  end
}
-- }}}
-- }}}
