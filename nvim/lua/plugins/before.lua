return {
  'bloznelis/before.nvim',
  config = true,
  init = function()
    local user_command = require('utils').user_command

    user_command('BeforeLast', function()
      require('before').jump_to_last_edit()
    end)

    user_command('BeforeNext', function()
      require('before').jump_to_next_edit()
    end)
  end,
}
