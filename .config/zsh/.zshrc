#!/usr/bin/env zsh

# Alias
[[ -f "${ZDOTDIR}/aliases" ]] && source "${ZDOTDIR}/aliases"

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

#
# Zim
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

# Initialize modules
export ZIM_HOME="${XDG_CACHE_HOME}/zim"
[[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]] && source ${ZIM_HOME}/zimfw.zsh init -q
source ${ZIM_HOME}/init.zsh

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
autoload -Uz cd-gitroot
autoload -Uz lg
