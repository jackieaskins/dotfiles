local success, colors = pcall(require, 'onenord.colors')
return success and colors.load() or {}
