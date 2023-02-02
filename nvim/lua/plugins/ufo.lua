local function ufo_map(fn)
  return function()
    require('ufo')[fn]()
  end
end

return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  keys = {
    { 'zR', ufo_map('openAllFolds') },
    { 'zM', ufo_map('closeAllFolds') },
  },
  config = true,
  opts = {
    fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
      local new_virt_text = {}
      local suffix = ('  %d '):format(end_lnum - lnum)
      local suffix_width = vim.fn.strdisplaywidth(suffix)
      local target_width = width - suffix_width
      local curr_width = 0

      for _, chunk in ipairs(virt_text) do
        local chunk_text = chunk[1]
        local chunk_width = vim.fn.strdisplaywidth(chunk_text)

        if target_width > curr_width + chunk_width then
          table.insert(new_virt_text, chunk)
        else
          chunk_text = truncate(chunk_text, target_width - curr_width)

          local hl_group = chunk[2]
          table.insert(new_virt_text, { chunk_text, hl_group })
          chunk_width = vim.fn.strdisplaywidth(chunk_text)

          if curr_width + chunk_width < target_width then
            suffix = suffix .. (' '):rep(target_width - curr_width - chunk_width)
          end

          break
        end
        curr_width = curr_width + chunk_width
      end

      table.insert(new_virt_text, { suffix, 'MoreMsg' })

      return new_virt_text
    end,
  },
}
