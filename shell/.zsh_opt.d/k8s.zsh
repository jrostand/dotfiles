_k8s_prompt() {
  if ! ps1opt k8s; then
    return 0
  fi

  if [[ -e ~/.kube/config ]]; then
    echo '%F{blue}\ufd31' "$(kubectl config current-context)%f"
  else
    echo '%F{red}kubeconfig?%f'
  fi
}
