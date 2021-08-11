local fn = vim.fn

local palette = fn['edge#get_palette']('neon')

local colors = {}
for key, value in pairs(palette) do
  colors[key] = value[1]
end

return colors
