source ~/.zsh_aliases
source ~/.zsh_prompt

fpath+=~/.zfunc

autoload -U compinit && compinit

setopt prompt_subst

# Shell history
export HISTFILE=~/.zsh_history
export SAVEHIST=10000
export HISTSIZE=10000
setopt inc_append_history
setopt hist_no_functions
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_ignore_dups
setopt no_hist_beep

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
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"

# ssh-add
ssh-add 2> /dev/null

function __exists() {
  builtin type $1 >/dev/null 2>&1
}

# dircolors
if [[ $(uname) = 'Darwin' ]]; then
  [[ -e ~/.lscolors ]] && eval $(gdircolors ~/.lscolors)
else
  [[ -e ~/.lscolors ]] && eval $(dircolors ~/.lscolors)
fi

# golang
if __exists go; then
  export GOPATH="$HOME/go"
  export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
fi

# nvm
if [ -d ${HOME}/.nvm ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
fi

# racer
if [[ -d ${HOME}/.racer ]]; then
  export RUST_SRC_PATH="$HOME/.racer/rustsrc"
fi

# rbenv
if [ -d ${HOME}/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# rust
if __exists rustc; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# fzf
if __exists fzf; then
  source /usr/share/fzf/key-bindings.zsh
fi
