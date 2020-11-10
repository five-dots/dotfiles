
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Environment variables
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"              # pip, stack (haskell)
export PATH="$HOME/go/bin:$PATH"                  # go
export PATH="$HOME/.cargo/bin:$PATH"              # rust
export PATH="$HOME/.doom-emacs.d/bin:$PATH"       # doom-emacs
export PATH="$HOME/emacs/emacs-27.0.91/bin:$PATH" # latest emacs

export REPOS="$HOME/Dropbox/repos"
export GITHUB_REPO="$REPOS/github/five-dots"
export NOTES="$REPOS/github/five-dots/notes"
export EDITOR=nvim
export VISUAL=nvim

# Go
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

# CUDA
export PATH="/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# Spark
export SPARK_HOME="$HOME/spark/spark"
export PATH="$SPARK_HOME/bin:$PATH"

# MKL
export MKL_ROOT_DIR="/opt/intel/mkl"
export LD_LIBRARY_PATH="$MKL_ROOT_DIR/lib/intel64:/opt/intel/lib/intel64_lin:$LD_LIBRARY_PATH"
export LIBRARY_PATH="$MKL_ROOT_DIR/lib/intel64:$LIBRARY_PATH"

# GCP
if [[ $(hostname) = 'desk1' ]]; then
    # export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/stoked-coder-215413-ff6c3baa10f5.json"
    export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/beaconbank-analytics-cf2038f236ec.json"
    # export GCS_AUTH_FILE="$HOME/.gcp/stoked-coder-215413-ff6c3baa10f5.json"
    export GCS_AUTH_FILE="$HOME/.gcp/beaconbank-analytics-cf2038f236ec.json"
fi
if [[ $(hostname) = 'x1' ]]; then
    # export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/stoked-coder-215413-26c9179fe9d7.json"
    export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.gcp/beaconbank-analytics-cf2038f236ec.json"
    # export GCS_AUTH_FILE="$HOME/.gcp/stoked-coder-215413-26c9179fe9d7.json"
    export GCS_AUTH_FILE="$HOME/.gcp/beaconbank-analytics-cf2038f236ec.json"
fi
export GCS_DEFAULT_BUCKET=stoked-coder-test-01

# Airflow
export AIRFLOW_HOME="$HOME/airflow"

# Linux only
if [ $(uname -s) = 'Linux' ]; then
    export PATH="$HOME/.cask/bin:$PATH"
    export LANG=en_US.UTF-8

    # anyenv
    if [ -d ~/.anyenv ]; then
        export PATH="$HOME/.anyenv/bin:$PATH"
        eval "$(anyenv init -)"
    fi

    ## pyenv-virtualenv
    if [ -d ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ]; then
        eval "$(pyenv virtualenv-init -)"
    fi

fi

# MacOS only
if [ $(uname) = 'Darwin' ]; then
    # Add texinfo path as texinfo by brew is keg-only
    export PATH="/usr/local/opt/texinfo/bin:$PATH"

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

