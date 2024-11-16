local progress_handle

---@type LazySpec
return {
  'wojciech-kulik/xcodebuild.nvim',
  enabled = require('lsp.utils').is_server_supported('sourcekit'),
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-treesitter/nvim-treesitter' },
  opts = {
    show_build_progress_bar = false,
    logs = {
      notify = function(message, severity)
        local fidget = require('fidget')

        if progress_handle then
          progress_handle.message = message
          if not message:find('Loading') then
            progress_handle:finish()
            progress_handle = nil
            if vim.trim(message) ~= '' then
              fidget.notify(message, severity)
            end
          end
        else
          fidget.notify(message, severity)
        end
      end,
      notify_progress = function(message)
        local progress = require('fidget.progress')

        if progress_handle then
          progress_handle.title = ''
          progress_handle.message = message
        else
          progress_handle = progress.handle.create({
            message = message,
            lsp_client = { name = 'xcodebuild.nvim' },
          })
        end
      end,
    },
  },
  init = function()
    require('installer').register('xcode', {
      ['xcode-build-server'] = { 'brew', 'xcode-build-server' },
      xcbeautify = { 'brew', 'xcbeautify' },
      xcodeproj = { 'gem', 'xcodeproj' },
      pymobiledevice3 = { 'pip', 'pymobiledevice3' },
    })
  end,
  ft = 'swift',
  keys = {
    { '<leader>X', '<cmd>XcodebuildPicker<CR>' },
    { '<leader>xf', '<cmd>XcodebuildProjectManager<CR>' },
    { '<leader>xb', '<cmd>XcodebuildBuild<CR>' },
    { '<leader>xB', '<cmd>XcodebuildCleanBuild<CR>' },
    { '<leader>xr', '<cmd>XcodebuildBuildRun<CR>' },
    { '<leader>xR', '<cmd>XcodebuildRun<CR>' },
    { '<leader>xl', '<cmd>XcodebuildToggleLogs<CR>' },
    { '<leader>xd', '<cmd>XcodebuildSelectDevice<CR>' },
    { '<leader>xx', '<cmd>XcodebuildQuickfixLine<CR>' },
    { '<leader>xa', '<cmd>XcodebuildCodeActions<CR>' },
  },
}
