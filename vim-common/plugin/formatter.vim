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
        './google-java-format.jar',
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

function! s:format()
  let useGoogle = !empty(glob('./google-java-format.jar'))
  let usePrettier = !empty(glob('./node_modules/.bin/prettier'))

  if useGoogle || usePrettier
    execute 'FormatWrite'
  endif
endfunction

augroup auto_format
  autocmd!
  autocmd BufWritePost *.java,*.js,*.jsx,*.ts,*.tsx call <SID>format()
augroup END
endif
