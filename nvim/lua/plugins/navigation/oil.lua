local border_config = { border = MY_CONFIG.border_style }

---@type LazySpec
return {
  { 'JezerM/oil-lsp-diagnostics.nvim', ft = 'oil', opts = {} },
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      confirmation = border_config,
      float = border_config,
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-p>'] = false,
        ['<C-v>'] = { 'actions.select', opts = { vertical = true } },
        ['<C-s>'] = { 'actions.select', opts = { horizontal = true } },
        gp = 'actions.preview',
        gr = 'actions.refresh',
      },
      keymaps_help = border_config,
      progress = border_config,
      ssh = border_config,
      win_options = {
        number = false,
        relativenumber = false,
        signcolumn = 'yes:2',
      },
      view_options = {
        is_hidden_file = function()
          return false
        end,
      },
    },
    dependencies = {
      'echasnovski/mini.icons',
    },
    lazy = false,
    keys = {
      { '-', '<cmd>Oil<CR>' },
      { '_', '<cmd>Oil .<CR>' },
    },
    init = function()
      local utils = require('utils')

      utils.augroup('oil-git-signs', {
        {
          'FileType',
          pattern = 'oil',
          callback = function(args)
            local buf = args.buf

            if vim.b[buf].loading_git_signs then
              return
            end

            vim.b[buf].loading_git_signs = true

            utils.augroup('oil-git-signs-buf-' .. buf, {
              {
                { 'BufReadPost', 'BufWritePost', 'InsertLeave', 'TextChanged' },
                buffer = buf,
                callback = function()
                  vim.system({
                    'git',
                    '-c',
                    'status.relativePaths=true',
                    'status',
                    '--short',
                    '--ignored',
                    '--no-renames',
                    '.',
                  }, {
                    cwd = require('oil').get_current_dir(buf),
                    text = true,
                  }, function(out)
                    if out.code ~= 0 then
                      return
                    end

                    vim.schedule(function()
                      local file_statuses = require('plugins.navigation.oil.git').add_git_signs(buf, out)
                      vim.b[buf].file_statuses = file_statuses
                    end)
                  end)
                end,
              },
              {
                { 'InsertLeave', 'TextChanged' },
                buffer = buf,
                callback = function()
                  require('plugins.navigation.oil.git').set_signs(buf, vim.b[buf].file_statuses)
                end,
              },
            })
          end,
        },
      })
    end,
  },
}
