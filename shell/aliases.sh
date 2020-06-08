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

# ls
if [ -x "$(command -v exa)" ]; then
    alias ls='exa --classify --color=auto'
    alias la='ls --all'
    alias ll='la --long --group --header --git --time-style=long-iso'
else
    alias ls='ls -F'
    alias la='ls -A'
    alias ll='la -l'
fi

# rg
if [ -x "$(command -v rg)" ]; then
	  # -i: ignore case
    alias rg='rg -i'
fi

# radian
if [ -x "$(command -v radian)" ]; then
    alias r='radian'
fi

# emacs
if [ "$(uname -s)" = 'Linux' ]; then
    # emacs with chemacs option
    alias doom-emacs='emacs --with-profile doom-emacs'
    alias vanilla-emacs='emacs --with-profile vanilla-emacs --dump-file="/home/shun/.emacs.d/emacs.pdmp"'
    alias spacemacs='emacs --with-profile spacemacs'
    alias centaur-emacs='emacs --with-profile centaur-emacs'
    alias prelude-emacs='emacs --with-profile prelude-emacs'

    alias doom='doom --emacsdir .doom-emacs.d'
fi

if [ "$(uname -s)" = 'Darwin' ]; then
    alias spacemacs='EMACS_DISTRO=spacemacs open -n /Applications/Emacs.app'
    alias doom-emacs='EMACS_DISTRO=doom-emacs open -n /Applications/Emacs.app'
    alias centaur-emacs='EMACS_DISTRO=centaur-emacs open -n /Applications/Emacs.app'
    alias vanilla-emacs='EMACS_DISTRO=vanilla-emacs open -n /Applications/Emacs.app'
    alias prelude-emacs='EMACS_DISTRO=prelude-emacs open -n /Applications/Emacs.app'

    # alias vanilla-emacs='open -n /Applications/Emacs.app --with-profile vanilla-emacs'
    # alias spacemacs='open -n /Applications/Emacs.app --with-profile spacemacs'
    # alias doom-emacs='open -n /Applications/Emacs.app --with-profile doom-emacs'
    # alias centaur-emacs='open -n /Applications/Emacs.app --with-profile centuar-emacs'
    # alias prelude-emacs='open -n /Applications/Emacs.app --with-profile prelude-emacs'
fi

# haskell stack
alias ghci='stack ghci'
alias ghc='stack ghc --'
alias runghc='stack runghc --'

# Homebrew
if [ "$(uname)" = 'Darwin' ]; then
	# suppress brew doctor warnings caused by pyenv
	# https://qiita.com/lyrical_magical_girl/items/0aced97d2a77702a376a
	alias brew="PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin brew"
fi

# Emacs on WSL
# https://mmktomato.github.io/2018/03/21/detect-wsl.html
# https://www49.atwiki.jp/ntemacs/pages/69.html
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  alias emacs="LIBGL_ALWAYS_INDIRECT=1 emacs"
fi
