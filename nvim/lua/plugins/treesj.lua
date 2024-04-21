return {
  {
    'AndrewRadev/splitjoin.vim',
    init = function()
      vim.g.splitjoin_split_mapping = ''
      vim.g.splitjoin_join_mapping = ''
    end,
    cmd = { 'SplitjoinJoin', 'SplitjoinSplit' },
  },
  {
    'Wansmer/treesj',
    config = function()
      local treesj = require('treesj')

      treesj.setup({
        use_default_keymaps = false,
        langs = { jsonc = require('treesj.langs.json') },
        max_join_length = math.huge,
      })

      require('utils').augroup('treesj', {
        {
          'FileType',
          pattern = '*',
          callback = function(args)
            local bufnr = args.buf
            local bsk = require('utils').buffer_map(bufnr)

            local ok, parser = pcall(vim.treesitter.get_parser)

            if not ok or not require('treesj.langs')['presets'][parser:lang()] then
              bsk('n', 'gJ', vim.cmd.SplitjoinJoin)
              bsk('n', 'gS', vim.cmd.SplitjoinSplit)
            else
              bsk('n', 'gJ', treesj.join, { desc = 'TSJJoin' })
              bsk('n', 'gS', treesj.split, { desc = 'TSJSplit' })
            end
          end,
        },
      })
    end,
  },
}
