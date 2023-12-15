# Enviroment Variables
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LANG='en_US.UTF-8'

# Enviroment Variables - User
export REPOS="${HOME}/repos"
export GITHUB_REPO="${REPOS}/github/five-dots"
export NOTES="${HOME}/notes"
export SPARK_HOME="${HOME}/src/spark/spark-3.3.0-bin-hadoop3"

# Enviroment Variables - PATH
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

# Zim
export ZIM_HOME="${XDG_CACHE_HOME}/zim"

# nnn config
export NNN_PLUG="d:dragdrop;c:fzcd;f:fzopen;g:gitroot;j:autojump;p:preview-tui;;:fzplug"

# Environment Variables - Secrets
[[ -f "${ZDOTDIR}/secrets" ]] && source "${ZDOTDIR}/secrets"

# Disalbe compinit as Zim controls compinit
skip_global_compinit=1

