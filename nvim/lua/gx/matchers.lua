local matchers = {
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
    file_pattern = [[plugins.*\.lua$]],
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
    file_pattern = [[package\.json$]],
    pattern = [[^\s*"\(\S\+\)"]],
    handler = function(match)
      return 'https://npmjs.com/package/' .. match[2]
    end,
  },
}

local ok, custom_matchers = pcall(require, 'custom.gx-matchers')
if ok then
  vim.list_extend(matchers, custom_matchers)
end

local default_matcher = {
  file_pattern = [[.*]],
  -- Borrowed from https://github.com/xiyaowong/link-visitor.nvim
  pattern = [[\v\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\-=?!+/0-9a-z]+|:\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\([&:#*@~%_\-=?!+;/.0-9a-z]*\)|\[[&:#*@~%_\-=?!+;/.0-9a-z]*\]|\{%([&:#*@~%_\-=?!+;/.0-9a-z]*|\{[&:#*@~%_\-=?!+;/.0-9a-z]*\})\})+]],
  handler = function(match)
    return match[1]
  end,
}

table.insert(matchers, default_matcher)

return matchers
