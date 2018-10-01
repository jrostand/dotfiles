_retval_prompt() {
  if ! ps1opt retval; then
    return 0
  fi
  echo ' %(0?.%F{green}%f.%F{red}%? %f)'
}
