---Reads icons from cache if it exists and `force_reload` is false
---Otherwise iterates through web-devicons and updates each hex based on cterm color
---@param force_reload boolean
local function load_icons(force_reload)
  local web_devicons = require('nvim-web-devicons')
  local cache_exists, existing_icons = pcall(require, 'devicons.cached_icons')

  if cache_exists and not force_reload then
    web_devicons.set_icon(existing_icons)
    return
  end

  local icons = web_devicons.get_icons()
  local all_icons = vim.tbl_extend('force', icons, {
    gomod = icons.go,
    mod = icons.go,
    vimrc = icons.vim,
    zshrc = icons.zsh,
    TelescopePrompt = { icon = '', name = 'Telescope', cterm_color = 4 },
    NvimTree = { icon = '󰙅', name = 'NvimTree', cterm_color = 2 },
  })

  local colored_icons = {}
  for icon_name, opts in pairs(all_icons) do
    local color_name = require('devicons.cterm_colors')[tonumber(opts.cterm_color)].color
    local color = require('colors').get_colors()[color_name]
    colored_icons[icon_name] = vim.tbl_extend('force', opts, { color = color })
  end

  web_devicons.set_icon(colored_icons)

  local cache_file, err = io.open(os.getenv('HOME') .. '/dotfiles/nvim/lua/devicons/cached_icons.lua', 'w')
  if err then
    vim.notify('Unable to open cached icons file: ' .. err)
  end

  if cache_file then
    cache_file:write('return' .. vim.inspect(colored_icons):gsub('%s', ''))
    cache_file:close()
  end

  vim.notify('Updated web-devicon colors')
end

return {
  'nvim-tree/nvim-web-devicons',
  load_icons = load_icons,
  build = function()
    load_icons(true)
  end,
  config = function()
    require('nvim-web-devicons').setup({ default = false })
    load_icons(false)

    require('utils').augroup('devicons_reload', {
      {
        'BufWritePost',
        pattern = 'web-devicons.lua,cterm_colors.lua',
        callback = function()
          load_icons(true)
          require('tint').refresh()
        end,
      },
    })
  end,
}
