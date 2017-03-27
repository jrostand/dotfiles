source ~/.zsh_aliases
source ~/.zsh_prompt

fpath+=~/.zfunc

autoload -U compinit && compinit

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

# Miscellaneous variables
export EDITOR=/usr/bin/vim
export GOPATH="$HOME/go"
#export TERM="xterm-256color"
export XDG_CONFIG_HOME="$HOME/.config"
export ANSIBLE_NOCOWS=1

export RUST_SRC_PATH="$HOME/.racer/rustsrc"

# PATH
export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH:/usr/local/go/bin:$GOPATH/bin"

# Mac version of dircolors (coreutils)
# [[ -e ~/.lscolors ]] && eval $(gdircolors ~/.lscolors)
# Linux version (default)
[[ -e ~/.lscolors ]] && eval $(dircolors ~/.lscolors)

ssh-add 2> /dev/null

if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
fi

if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi
