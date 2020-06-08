#!/bin/bash

REPO=~/Dropbox/repos/github/five-dots/dotfiles

# this script
ln -sf $REPO/install.sh ~/bin/install.sh

# zsh
ln -sf $REPO/shell/zshrc.zsh ~/.zshrc
ln -sf $REPO/shell/zpreztorc.zsh ~/.zpreztorc

# alias
ln -sf $REPO/shell/aliases.sh ~/.aliases

# emacs bootloader
ln -sf $REPO/emacsen/emacs.el ~/.emacs
# ln -sf $HOME/Dropbox/repos/github/plexus/chemacs/.emacs ~/.emacs
# ln -sf $REPO/emacsen/emacs-profiles.el ~/.emacs-profiles.el

# doom-emacs (default)
ln -snf $REPO/emacsen/doom-emacs-config ~/.doom.d

# vanilla emacs
ln -sf $REPO/emacsen/vanilla-emacs-config/init.el ~/.vanilla-emacs.d/init.el
ln -snf $REPO/emacsen/vanilla-emacs-config/elisp ~/.vanilla-emacs.d/elisp

# spacemacs
ln -sf $REPO/emacsen/spacemacs-config/spacemacs.el ~/.spacemacs
# ln -snf $HOME/Dropbox/repos/github/syl20bnr/spacemacs ~/.spacemacs.d

# centaur-emacs
# ln -snf $HOME/Dropbox/repos/github/seagle0128/.emacs.d ~/.centaur-emacs.d

# prelude-emacs
# ln -snf $HOME/Dropbox/repos/github/bbatsov/prelude ~/.prelude-emacs.d

# vim
# ln -sf $REPO/vim/vimrc.vim ~/.vimrc
# ln -sf $REPO/vim/gvimrc.vim ~/.gvimrc

# R
ln -sf $REPO/R/Rprofile.R ~/.Rprofile
ln -sf $REPO/R/Renviron.sh ~/.Renviron
ln -sf $REPO/R/secret.R ~/.secret.R

# git
ln -sf $REPO/gitconfig ~/.gitconfig

# skk
ln -sf $REPO/skk.el ~/.skk

# mozc
ln -snf ~/Dropbox/mozc/.mozc ~/.mozc

# Linux only
if [ $(uname -s) = 'Linux' ]; then
    # bash/shell
    ln -sf $REPO/shell/profile.sh ~/.profile
    ln -sf $REPO/shell/bashrc.sh ~/.bashrc
    ln -sf $REPO/shell/inputrc.sh ~/.inputrc

    # X11
    ln -sf $REPO/X11/xsessionrc.sh ~/.xsessionrc
    ln -sf $REPO/X11/Xresources ~/.Xresources

    # Keybind
    ln -sf $REPO/keybind/xkeysnail.py ~/.xkeysnail.py
    ln -sf $REPO/keybind/xremap.rb ~/.xremap.rb
    ln -sf $REPO/keybind/Xmodmap ~/.Xmodmap
    ln -sf $REPO/keybind/keybindings.sh ~/.keybindings.sh
    ln -snf $REPO/autokey ~/.config/autokey/data

    # systemd
    ln -sf $REPO/systemd/xremap.service ~/.config/systemd/user/xremap.service

    # Font
    ln -snf ~/Dropbox/fonts ~/.fonts
    ln -sf $REPO/fonts.conf ~/.config/fontconfig/fonts.conf

    # Startup script
    ln -sf $REPO/autostart/keybindings.desktop ~/.config/autostart/keybindings.desktop

    # Gnome Apps
    ln -sf $REPO/gnome-apps/spacemacs.desktop ~/.local/share/applications/spacemacs.desktop
    ln -sf $REPO/gnome-apps/doom-emacs.desktop ~/.local/share/applications/doom-emacs.desktop
    ln -sf $REPO/gnome-apps/spacemacsclient.desktop ~/.local/share/applications/spacemacsclient.desktop

    # mozc
    ln -snf ~/Dropbox/mozc/.mozc ~/.mozc

    # vscode
    ln -sf $REPO/vscode/settings.json ~/.config/Code/User/settings.json

fi

# MacOS only
if [ $(uname -s) = 'Darwin' ]; then
    :
fi
