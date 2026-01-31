#copied from https://github.com/dmmulroy/.dotfiles/blob/main/home/.config/fish/functions/gbda.fish
#with small changes
function gbc -d "Delete all branches merged in current HEAD, including squashed"
  git branch --merged | \
    # *: current branch, +: current branch on worktree.
    command grep -vE  '^\*|^\+|^\s*(master|main|develop)\s*$' | \
    command xargs -r -n 1 git branch -d

  set -l default_branch (git rev-parse --abbrev-ref origin/HEAD 2>/dev/null | string replace 'origin/' '')
  git for-each-ref refs/heads/ "--format=%(refname:short)" | \
    while read branch
      set -l merge_base (git merge-base $default_branch $branch)
      if string match -q -- '-*' (git cherry $default_branch (git commit-tree (git rev-parse $branch\^{tree}) -p $merge_base -m _))
        git branch -D $branch
      end
    end
end
