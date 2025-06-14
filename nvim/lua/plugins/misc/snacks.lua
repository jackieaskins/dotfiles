---@type LazySpec
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = function()
    local border = MY_CONFIG.border_style

    ---@type snacks.Config
    return {
      bigfile = { enabled = false },
      image = { enabled = true },
      indent = {
        enabled = true,
        animate = { enabled = false },
        chunk = {
          enabled = true,
          char = { arrow = '─' },
        },
      },
      input = { enabled = true },
      notifier = {
        enabled = true,
        margin = { top = 1 },
        width = { max = 50 },
      },
      picker = require('plugins.misc.snacks.picker').get_config(),
      quickfile = { enabled = true },
      styles = {
        input = {
          border = border,
          relative = 'cursor',
        },
        ---@diagnostic disable-next-line: missing-fields
        notification = {
          border = border,
          ft = 'markdown',
          wo = { wrap = true },
        },
        ---@diagnostic disable-next-line: missing-fields
        notification_history = {
          border = border,
          backdrop = 100,
        },
      },
      words = { enabled = true, modes = { 'n', 'c' } },
    }
  end,
  init = function()
    local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
    local progress = vim.defaulttable()

    require('plugins.misc.snacks.picker').get_init()

    local utils = require('utils')

    utils.user_command('Notifications', function()
      Snacks.notifier.show_history()
    end)

    utils.augroup('snacks', {
      {
        'FileType',
        pattern = { 'gitcommit', 'markdown' },
        command = 'let b:snacks_indent = v:false',
      },
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
  keys = function()
    local default_keys = {
      {
        '<leader>bd',
        function()
          Snacks.bufdelete()
        end,
        desc = 'Delete Buffer',
      },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        desc = 'Next Reference',
        mode = { 'n', 't' },
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        desc = 'Prev Reference',
        mode = { 'n', 't' },
      },
    }

    return vim.list_extend(default_keys, require('plugins.misc.snacks.picker').get_keys())
  end,
}
