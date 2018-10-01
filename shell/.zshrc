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

# Prompt options
if [[ -e $HOME/.zsh_opts ]]; then
  export PROMPT_OPTS=$(cat $HOME/.zsh_opts)
else
  touch $HOME/.zsh_opts
  export PROMPT_OPTS=()
fi

# EDITOR
if [[ $(which nvim) ]]; then
  export EDITOR=$(which nvim)
else
  export EDITOR=$(which vim)
fi

# PATH
export PATH="$HOME/bin:$PATH"

# Miscellaneous variables
export ANSIBLE_NOCOWS=1
export XDG_CONFIG_HOME="$HOME/.config"

# dircolors
if [[ $(uname) = 'Darwin' ]]; then
  [[ -e ~/.lscolors ]] && eval $(gdircolors ~/.lscolors)
else
  [[ -e ~/.lscolors ]] && eval $(dircolors ~/.lscolors)
fi

# golang
if [[ $(which go) ]]; then
  export GOPATH="$HOME/go"
  export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
fi

# nvm
if [ -d ~/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# racer
if [[ -d ~/.racer ]]; then
  export RUST_SRC_PATH="$HOME/.racer/rustsrc"
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# rust
if [[ $(which rustc) ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# ssh-add
ssh-add 2> /dev/null
