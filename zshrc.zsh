
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Environment variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.doom-emacs.d/bin:$PATH"
export PATH="/usr/local/share/libFM/bin:$PATH"

export REPOS="$HOME/Dropbox/repos"
export GITHUB_REPO="$REPOS/github/five-dots"

export EDITOR=nvim
export VISUAL=nvim
export EMACS_DISTRO=vanilla-emacs

# Linux only
if [ $(uname -s) = 'Linux' ]; then
    export PATH="$HOME/.cask/bin:$PATH"
    export PATH="/usr/local/share/LIBFFM/bin:$PATH"
    export LANG=en_US.UTF-8

    # anyenv
    if [ -d ~/.anyenv ]; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init -)"
    fi
fi

# MacOS only
if [ $(uname) = 'Darwin' ]; then
    # anyenv
    if [ -x "$(command -v anyenv)" ]; then
        eval "$(anyenv init -)"
    fi
fi

# PAGER
if [ -x "$(command -v bat)" ]; then
    export PAGER=bat
fi

# Load aliases
if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

# For WSL X-Server
if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
    export DISPLAY=localhost:0.0
fi

# IQFeed setting
if [ -f ~/.iqfeed_credentials ]; then
	  source ~/.iqfeed_credentials.sh
fi
