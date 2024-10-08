#!/usr/bin/env zsh

# direnv
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"

# asdf
[[ -f "${HOME}/.asdf/asdf.sh" ]] && source "${HOME}/.asdf/asdf.sh"

# fzf
[[ -f "${HOME}/.fzf.zsh" ]] && source "${HOME}/.fzf.zsh"

# gh CLI completion
(( $+commands[gh] )) && eval "$(gh completion -s zsh)"

# gcloud CLI completion
gcloud_comp="$(asdf where gcloud)/completion.zsh.inc"
[[ -f "${gcloud_comp}" ]] && source "${gcloud_comp}"

# gke-gcloud-auth-plugin https://qiita.com/kiyc/items/beb55d223f27109ea9ab
(( $+commands[gke-gcloud-auth-plugin] )) && export USE_GKE_GCLOUD_AUTH_PLUGIN=true

# jump
(( $+commands[jump] )) && eval "$(jump shell)"

# z
z_path="${HOME}/repos/github/rupa/z/z.sh"
[[ -f "${z_path}" ]] && source "${z_path}"

# rye (Python package manager)
[[ -f "${HOME}/.rye/env" ]] && source "${HOME}/.rye/env"

#
# Zim
# Install Zim by:
#   curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
#

# Histroy
export HISTFILE="${ZDOTDIR}/.zsh_history"
setopt HIST_IGNORE_ALL_DUPS

# Remove path separator from WORDCHARS
WORDCHARS=${WORDCHARS//[\/]}

# input: Append `../` to your input for each `.` you type after an initial `..`
zstyle ':zim:input' double-dot-expand yes

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Zim setup
if [[ -f "${ZIM_HOME}/init.zsh" ]]; then
    # Install missing modules and update the static initialization script
    [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] && source ${ZIM_HOME}/zimfw.zsh init -q

    # Initialize modules
    source ${ZIM_HOME}/init.zsh
fi

bindkey -v
zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

#
# Functions
#

fpath=("${ZDOTDIR}/functions" "${fpath[@]}")
autoload -Uz br
autoload -Uz bww
autoload -Uz cd-gitroot
autoload -Uz lzg
autoload -Uz n
autoload -Uz nvims
autoload -Uz showoptions
autoload -Uz yy

# Load alias setting after function load
[[ -f "${ZDOTDIR}/aliases" ]] && source "${ZDOTDIR}/aliases"
