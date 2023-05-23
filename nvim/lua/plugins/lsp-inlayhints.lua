return {
  'lvimuser/lsp-inlayhints.nvim',
  branch = 'anticonceal',
  config = true,
  init = function()
    require('utils').augroup('inlayhints', {
      {
        'LspAttach',
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require('lsp-inlayhints').on_attach(client, bufnr)
        end,
      },
    })
  end,
  keys = {
    {
      '<leader>ih',
      function()
        require('lsp-inlayhints').toggle()
      end,
      desc = 'Toggle Inlay Hints',
    },
  },
}
