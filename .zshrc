#!/usr/bin/env zsh

# Environment Variables
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

# Environment Variables
export REPOS="${HOME}/repos"
export GITHUB_REPO="${REPOS}/github/five-dots"
export NOTES="${HOME}/notes"
export SPARK_HOME="${HOME}/src/spark/spark-3.3.0-bin-hadoop3"

# Environment Variables - Secrets
[[ -s "${HOME}/.secrets" ]] && source "${HOME}/.secrets"

# Enviroment Variable - PATH
paths=(
    "${HOME}/.local/bin"       # pip, pipx, stack (haskel)
    "${HOME}/.cargo/bin"       # rust
    "${HOME}/.emacs.d/bin"     # doom-emacs
    "${HOME}/emacs/emacs/bin"  # emacs
    "${SPARK_HOME}/bin"        # spark
    "${HOME}/bin"
)
for p in "${paths[@]}"; do
    export PATH="${p}:${PATH}"
done

# direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# prezto
[[ -s "${HOME}/.zprezto/init.zsh" ]] && source "${HOME}/.zprezto/init.zsh"

# mcfly
if (( $+commands[mcfly] )); then
    export MCFLY_KEY_SCHEME=vim
    eval "$(mcfly init zsh)"
fi

# asdf
[[ -s "${HOME}/.asdf/asdf.sh" ]] && source "${HOME}/.asdf/asdf.sh"

# alias
[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

# gh cli completion
(( $+commands[gh] )) && eval "$(gh completion -s zsh)"
