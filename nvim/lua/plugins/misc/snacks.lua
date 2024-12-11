---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      margin = { top = 1 },
      width = { max = 50 },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = false },
    styles = {
      notification = {
        bo = { filetype = 'snacks_notif' },
        border = MY_CONFIG.border_style,
        ft = 'markdown',
        wo = { wrap = true },
      },
    },
    words = { enabled = true, modes = { 'n', 'c' } },
  },
  init = function()
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local progress = vim.defaulttable()

    require('utils').augroup('snacks', {
      {
        'LspProgress',
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local value = args.data.params.value
          if not client or type(value) ~= 'table' then
            return
          end
          local client_progress = progress[client.id]

          for i = 1, #client_progress + 1 do
            if i == #client_progress + 1 or client_progress[i].token == args.data.params.token then
              client_progress[i] = {
                token = args.data.params.token,
                msg = ('**%d%%** %s%s'):format(
                  value.kind == 'end' and 100 or value.percentage or 100,
                  value.title or '',
                  value.message and (' **%s**'):format(value.message) or ''
                ),
                done = value.kind == 'end',
              }
              break
            end
          end

          local msg = {}
          progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
          end, client_progress)

          vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
              notif.icon = #progress[client.id] == 0 and ' '
                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
          })
        end,
      },
    })
  end,
  keys = {
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete buffer',
    },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
}
