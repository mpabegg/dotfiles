# really usefull aliases, took from https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh#L234
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
