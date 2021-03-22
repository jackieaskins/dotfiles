if has('nvim-0.5')
lua << EOF
local prettier = {
  function()
    return {
      exe = "./node_modules/.bin/prettier",
      args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
  end
}
local google = {
  function()
    return {
      exe = 'java',
      args = {
        '-jar',
        os.getenv('HOME') .. '/dotfiles/formatters/google-java-format/google-java-format.jar',
        vim.api.nvim_buf_get_name(0)
      },
      stdin = true
    }
  end
}

require('formatter').setup({
  logging = true,
  filetype = {
    java = google,
    javascript = prettier,
    javascriptreact = prettier,
    typescript = prettier,
    typescriptreact = prettier
  }
})
EOF

function! FormatWithPrettier()
  if !empty(glob('./node_modules/.bin/prettier'))
    execute 'FormatWrite'
  endif
endfunction

augroup auto_format
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.ts,*.tsx call FormatWithPrettier()
  autocmd BufWritePost *.java FormatWrite
augroup END
endif
