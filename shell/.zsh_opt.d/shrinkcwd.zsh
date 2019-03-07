# Shamelessly stolen from oh-my-zsh's shrink-path
# I just removed all the options because this is how I like it
# https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/shrink-path

_shrinkdir() {
  setopt localoptions
  setopt rc_quotes null_glob

  typeset -a tree expn
  typeset result part dir=${1-PWD}
  typeset -i i

  dir=$1

  [[ -d $dir ]] || return 0

  dir=${dir/#$HOME/\~}
  tree=(${(s:/:)dir})
  (
    if [[ $tree[1] == \~* ]] {
      cd -q ${~tree[1]}
      result=$tree[1]
      shift tree
    } else {
      cd -q /
    }
    for dir in $tree; {
      if (( $#tree == 1 )) {
        result+="/$tree"
        break
      }
      expn=(a b)
      part=''
      i=0
      until [[ (( ${#expn} == 1 )) || $dir = $expn || $i -gt 99 ]] do
        (( i++ ))
        part+=$dir[$i]
        expn=($(echo ${part}*(-/)))
        break
      done
      result+="/$part"
      cd -q $dir
      shift tree
    }
    echo ${result:-./}
  )
}

_shrinkcwd_prompt() {
  if ! ps1opt shrinkcwd; then
    echo '%~'
    return 0
  fi

  _shrinkdir $PWD
}
