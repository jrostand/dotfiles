_git_branch_and_sha() {
  local branch="" sha='' fmtbranch=''

  branch=$(git symbolic-ref -q HEAD 2>/dev/null | sed s/refs\\/heads\\///)

  if [ -z $branch ]; then
    echo '%F{red}detached%f'
    return 0
  fi

  case $branch in
    master)
      fmtbranch="%K{red}%F{black}$branch%f%k";;
    *)
      fmtbranch="%F{blue}$branch%f";;
  esac

  sha=$(git rev-parse --short --quiet HEAD)

  if [ ! $sha ]; then
    sha='%F{red}\ue729%f'
  fi

  echo "$fmtbranch %F{yellow}$sha%f"
}

_git_status_char() {
  local git_status="$(git status 2>/dev/null)"

  if [[ $git_status =~ 'nothing to commit' ]]; then
    echo '%F{blue}\uf0c8%f'
  elif [[ $git_status =~ 'to be committed' ]]; then
    echo "%F{white}\uf0c8%f"
  else
    echo "%F{red}\uf0c8%f"
  fi
}

_git_remote_char() {
  local git_remotes="$(git remote -v 2>/dev/null)"

  if [[ $git_remotes =~ 'gitlab.com' ]]; then
    echo '\uf296'
  elif [[ $git_remotes =~ 'github.com' ]]; then
    echo '\uf113'
  else
    echo '\ue702'
  fi
}

_git_prompt() {
  if ! ps1opt git; then
    return 0
  fi

  git rev-parse --git-dir >/dev/null 2>&1 && echo "$(_git_remote_char)  $(_git_branch_and_sha) $(_git_status_char)"
}
