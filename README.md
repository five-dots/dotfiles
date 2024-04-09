## dotfiles

``` sh
git clone git@github.com:five-dots/dotfiles.git
cd dotfiles

# CLI
stow -Rvt ~ \
    asdf \
    direnv \
    fdfind \
    gcloud \
    git \
    jump \
    lazydocker \
    lazygit \
    pypoetry \
    qmk \
    R \
    radian \
    sql-formatter \
    streamlit \
    tmux \
    zsh

# GUI
stow -Rvt ~ \
    fontconfig \
    kitty \
    vscode \
    wezterm \
    xkeysnail

# Hidden
stow -Rvt ~ \
    awscli \
    dbt \
    snowsql
```
