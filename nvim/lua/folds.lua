-- Code borrowed & modified from:
-- https://www.reddit.com/r/neovim/comments/1le6l6x/add_decoration_to_the_folded_lines/
-- https://github.com/chrisgrieser/nvim-origami

----------------------------------------------------------------------
--                             Segments                             --
----------------------------------------------------------------------

---@alias Segment { icon: string; text: string; hl: string }[]
---@alias GetSegment fun(buf: integer, foldstart: integer, foldend: integer): (Segment | nil)

---@type GetSegment
local function get_line_count_segment(_, foldstart, foldend)
  return { { icon = '󰘕 ', text = foldend - foldstart + 1, hl = 'MoreMsg' } }
end

---@type GetSegment
local function get_search_count_segment(buf, foldstart, foldend)
  if not vim.o.hlsearch or vim.v.hlsearch == 0 then
    return
  end

  local sucess, matches = pcall(vim.fn.matchbufline, buf, vim.fn.getreg('/'), foldstart, foldend)
  if not sucess then
    return
  end

  local searchcount = #matches
  if searchcount > 0 then
    return { { icon = ' ', text = searchcount, hl = 'Question' } }
  end
end

local diag_icons = require('diagnostic.icons')
local diag_hls = {
  [vim.diagnostic.severity.ERROR] = 'DiagnosticError',
  [vim.diagnostic.severity.WARN] = 'DiagnosticWarn',
  [vim.diagnostic.severity.INFO] = 'DiagnosticInfo',
  [vim.diagnostic.severity.HINT] = 'DiagnosticHint',
}

---@type GetSegment
local function get_diagnostics_segment(buf, foldstart, foldend)
  local diag_counts = {}
  for lnum = foldstart - 1, foldend - 1 do
    for severity, value in pairs(vim.diagnostic.count(buf, { lnum = lnum })) do
      diag_counts[severity] = value + (diag_counts[severity] or 0)
    end
  end

  return vim
    .iter(ipairs(vim.diagnostic.severity))
    :map(function(severity)
      local count = diag_counts[severity]
      return count and { icon = diag_icons[severity], text = count, hl = diag_hls[severity] }
    end)
    :totable()
end

local type_icons = { change = '~', delete = '-', add = '+' }
local type_hls = { change = 'GitSignsChange', delete = 'GitSignsDelete', add = 'GitSignsAdd' }

---@type GetSegment
local function get_gitsigns_segment(buf, foldstart, foldend)
  local gitsigns = require('gitsigns')

  local hunks_in_fold = { change = 0, delete = 0, add = 0 }

  for _, hunk in pairs(gitsigns.get_hunks(buf) or {}) do
    local hunk_start = hunk.added.start

    if hunk.type == 'delete' then
      local is_in_fold = hunk_start >= foldstart and hunk_start <= foldend

      if is_in_fold then
        hunks_in_fold['delete'] = hunks_in_fold['delete'] + hunk.removed.count
      end
    else
      local hunk_end = hunk_start - 1 + hunk.added.count

      local overlap_start = math.max(foldstart + 1, hunk_start) -- + 1 since 1st folded line still visible
      local overlap_end = math.min(foldend, hunk_end)
      local overlap = overlap_end - overlap_start + 1

      if overlap > 0 then
        hunks_in_fold[hunk.type] = hunks_in_fold[hunk.type] + overlap
      end
    end
  end

  local chunks = {}
  for type, hunks in pairs(hunks_in_fold) do
    if hunks > 0 then
      table.insert(chunks, { icon = type_icons[type], text = hunks, hl = type_hls[type] })
    end
  end

  return chunks
end

local segments = {
  get_line_count_segment,
  get_search_count_segment,
  get_diagnostics_segment,
  get_gitsigns_segment,
}

----------------------------------------------------------------------
--                            Rendering                             --
----------------------------------------------------------------------

local ns = vim.api.nvim_create_namespace('user.folds')

local function render_folded_segments(win, buf, foldstart, foldend)
  local line = vim.api.nvim_buf_get_lines(buf, foldstart - 1, foldstart, false)[1]

  local wininfo = vim.fn.getwininfo(win)[1]
  local leftcol = wininfo and wininfo.leftcol or 0 ---@diagnostic disable-line: undefined-field
  local wincol = math.max(0, vim.fn.virtcol({ foldstart, line:len() }) - leftcol)

  local virt_text = vim
    .iter(segments)
    :map(function(get_segment)
      return get_segment(buf, foldstart, foldend)
    end)
    :flatten(1)
    :map(function(segment)
      return {
        { '·', { 'Folded' } }, -- Add an extra fold fillchar before each segment
        { segment.icon .. segment.text, { 'Bold', segment.hl } },
      }
    end)
    :flatten(1)
    :totable()

  vim.api.nvim_buf_set_extmark(buf, ns, foldstart - 1, 0, {
    virt_text = virt_text,
    virt_text_win_col = wincol,
    hl_mode = 'combine',
    ephemeral = true,
  })
end

vim.api.nvim_set_decoration_provider(ns, {
  on_win = function(_, win, buf, topline, botline)
    vim.api.nvim_win_call(win, function()
      local line = topline

      while line <= botline do
        local foldstart = vim.fn.foldclosed(line)

        if foldstart ~= -1 then
          local foldend = vim.fn.foldclosedend(foldstart)
          render_folded_segments(win, buf, foldstart, foldend)
          line = foldend
        end

        line = line + 1
      end
    end)
  end,
})
