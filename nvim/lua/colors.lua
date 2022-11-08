local success, palette = pcall(require, 'catppuccin.palettes')
return success and palette.get_palette() or {}
