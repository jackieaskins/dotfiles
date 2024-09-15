---@type LazySpec
return {
  'cormacrelf/dark-notify',
  config = function()
    require('dark_notify').run()
  end,
}
