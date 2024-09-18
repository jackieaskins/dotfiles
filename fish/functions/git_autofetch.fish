function git_autofetch --on-event fish_prompt --description "automatically git fetch"
    set --local hasGit (find ./ -maxdepth 1 -type d -name .git -print)
    if test "$hasGit" = "./.git"
        git fetch
    end
end
