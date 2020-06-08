#!/bin/sh

# export PATH="$PATH:$HOME/bin:/opt/mssql-tools/bin:$HOME/julia/julia-1.0.2/bin:$HOME/.doom-emacs.d/bin"
export REPOS="$HOME/Dropbox/repos"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.doom-emacs.d/bin:$HOME/.cask/bin"
export PATH="$PATH:/usr/local/share/libFM/bin:/usr/local/share/LIBFFM/bin"

# load .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Add ~/.pyenv/shims at the top of PATH
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

export PATH="$HOME/.cargo/bin:$PATH"
