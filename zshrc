source ~/.zsh_aliases

setopt prompt_subst

# Shell history
export HISTFILE=~/.zsh_history
export SAVEHIST=1000
export HISTSIZE=1000
setopt inc_append_history
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt no_hist_beep
setopt share_history

# PATH
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$PATH:$HOME/.shoes/federales"

# Miscellaneous variables
export TERM="xterm-256color"
export ANSIBLE_NOCOWS=1
export JAVA_HOME="/usr/lib/jvm/java-1.7.0-openjdk-amd64"

[[ -e ~/.lscolors ]] && eval $(dircolors ~/.lscolors)

ssh-add 2> /dev/null

if [ -d ~/.nvm ]; then
  export NVM_DIR="/home/julien/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

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
    sha='%F{red}ref?%f'
  fi

  echo "$fmtbranch %F{yellow}$sha%f"
}

_git_status_char() {
  local git_status="$(git status 2>/dev/null)"

  if [[ $git_status =~ 'nothing to commit' ]]; then
    echo "%K{blue}  %k"
  elif [[ $git_status =~ 'to be committed' ]]; then
    echo "%K{white}  %k"
  else
    echo "%K{red}  %k"
  fi
}

_git_prompt() {
  git rev-parse --git-dir >/dev/null 2>&1 && echo "± $(_git_branch_and_sha) $(_git_status_char)"
}

PROMPT='%F{green}%n%f@%F{magenta}%m%f :: %F{cyan}%~%f $(_git_prompt)
> '
