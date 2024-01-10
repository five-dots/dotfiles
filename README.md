## dotfiles

``` sh
git clone git@github.com:five-dots/dotfiles.git
cd dotfiles

# CLI
stow -Rvt ~ \
    asdf \
    direnv \
    fdfind \
    fontconfig \
    git \
    jump \
    kitty \
    lazydocker \
    lazygit \
    pypoetry \
    qmk \
    radian \
    sql-formatter \
    streamlit \
    tmux \
    wezterm \
    zsh

# GUI
stow -Rvt ~ \
    vscode \
    xkeysnail

# Hidden
stow -Rvt ~ \
    awscli \
    dbt \
    snowsql
```
