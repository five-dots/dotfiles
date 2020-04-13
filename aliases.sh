#!/bin/sh

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls aliases
if [ -x "$(command -v exa)" ]; then
    alias ls='exa --classify --color=auto'
    alias la='ls --all'
    alias ll='la --long --group --header --git --time-style=long-iso'
else
    alias ls='ls -F'
    alias la='ls -A'
    alias ll='la -l'
fi

# emacs
if [ $(uname -s) = 'Linux' ]; then
    alias spacemacs='EMACS_DISTRO=spacemacs emacs'
    alias doom-emacs='EMACS_DISTRO=doom-emacs emacs'
    alias centaur-emacs='EMACS_DISTRO=centaur-emacs emacs'
    alias vanilla-emacs='EMACS_DISTRO=vanilla-emacs emacs'
fi
if [ $(uname -s) = 'Darwin' ]; then
    alias spacemacs='EMACS_DISTRO=spacemacs open -n /Applications/Emacs.app'
    alias doom-emacs='EMACS_DISTRO=doom-emacs open -n /Applications/Emacs.app'
    alias centaur-emacs='EMACS_DISTRO=centaur-emacs open -n /Applications/Emacs.app'
    alias vanilla-emacs='EMACS_DISTRO=vanilla-emacs open -n /Applications/Emacs.app'
fi

# Emacs on WSL
# https://mmktomato.github.io/2018/03/21/detect-wsl.html
# https://www49.atwiki.jp/ntemacs/pages/69.html
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  alias emacs="LIBGL_ALWAYS_INDIRECT=1 emacs"
fi
