return {
  {
    file_pattern = [[\(Brewfile\|Brewfile_personal\)$]],
    pattern = [[\s*\(brew\|cask\)\s\+'\([a-zA-Z0-9_.-]\+\)']],
    handler = function(match)
      return table.concat({
        'https://formulae.brew.sh',
        match[2] == 'brew' and 'formula' or 'cask',
        match[3],
      }, '/')
    end,
  },
  {
    file_pattern = [[plugins\.lua$]],
    pattern = [[.*'\([a-zA-Z0-9_.-]\+\/[a-zA-Z0-9_.-]\+\)']],
    handler = function(match)
      return 'https://github.com/' .. match[2]
    end,
  },
  {
    file_pattern = [[plugins\.vim$]],
    pattern = [[Plug '\([a-zA-Z0-9_.-]\+\/[a-zA-Z0-9_.-]\+\)']],
    handler = function(match)
      return 'https://github.com/' .. match[2]
    end,
  },
  {
    file_pattern = [[tmux\.conf$]],
    pattern = [[.* @plugin '\([a-zA-Z0-9_.-]\+\/[a-zA-Z0-9_.-]\+\)']],
    handler = function(match)
      return 'https://github.com/' .. match[2]
    end,
  },
  {
    file_pattern = '[packer]',
    pattern = [[^\s\+\(\x\{7}\)\s.*\(.*\)$]],
    handler = function(match)
      local commit_hash = match[2]
      local line_nr = vim.fn.line('.') - 1

      while line_nr > 3 do
        local line = vim.fn.getline(line_nr)
        local matchlist = vim.fn.matchlist(line, [[URL:\s\(\S\+\)]])

        if #matchlist > 0 then
          return table.concat({
            matchlist[2],
            'commit',
            commit_hash,
          }, '/')
        end

        line_nr = line_nr - 1
      end

      return nil
    end,
  },
  {
    file_pattern = [[package\.json]],
    pattern = [[^\s*"\(\S\+\)"]],
    handler = function(match)
      return 'https://npmjs.com/package/' .. match[2]
    end,
  },
  {
    file_pattern = [[.*]],
    pattern = [[https\?:\/\/\(\w\+\(:\w\+\)\?@\)\?\([A-Za-z][-_0-9A-Za-z]*\.\)\{1,}\(\w\{2,}\.\?\)\{1,}\(:[0-9]\{1,5}\)\?\S*]],
    handler = function(match)
      return match[1]
    end,
  },
}
