## dotfiles

``` sh
git clone git@github.com:five-dots/dotfiles.git
cd dotfiles

# CLI
stow -Rvt ~ \
    R \
    asdf \
    direnv \
    fdfind \
    gcloud \
    git \
    jump \
    lazydocker \
    lazygit \
    nvchad \
    nvim \
    pypoetry \
    qmk \
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
