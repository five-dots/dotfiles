#!/bin/bash

REPO=~/Dropbox/repos/github/five-dots/dotfiles

# this script
ln -sf $REPO/install.sh ~/bin/install.sh

# zsh
ln -sf $REPO/zshrc.zsh ~/.zshrc
ln -sf $REPO/zpreztorc.zsh ~/.zpreztorc

# alias
ln -sf $REPO/aliases.sh ~/.aliases

# emacs
ln -sf $REPO/emacsen/emacs.el ~/.emacs
# ln -snf $REPO/emacsen/vanilla-emacs.d ~/.emacs.d
ln -snf $REPO/emacsen/vanilla-emacs.d ~/.vanilla-emacs.d

# spacemacs
ln -sf $REPO/emacsen/spacemacs-config/spacemacs.el ~/.spacemacs
ln -snf $HOME/Dropbox/repos/github/syl20bnr/spacemacs ~/.spacemacs.d

# doom-emacs
ln -snf $HOME/Dropbox/repos/github/hlissner/doom-emacs ~/.doom-emacs.d
ln -snf $HOME/Dropbox/repos/github/hlissner/doom-emacs ~/.emacs.d
ln -snf $REPO/emacsen/doom.d ~/.doom.d

# centaur-emacs
ln -snf $HOME/Dropbox/repos/github/seagle0128/.emacs.d ~/.centaur-emacs.d

# vim
# ln -sf $REPO/vimrc.vim ~/.vimrc
# ln -sf $REPO/gvimrc.vim ~/.gvimrc

# R
ln -sf $REPO/Rprofile.R ~/.Rprofile
ln -sf $REPO/Renviron.sh ~/.Renviron
ln -sf $REPO/secret.R ~/.secret.R

# git
ln -sf $REPO/gitconfig ~/.gitconfig

# Linux only
if [ $(uname -s) = 'Linux' ]; then
    # bash
    ln -sf $REPO/profile.sh ~/.profile
    ln -sf $REPO/bashrc.sh ~/.bashrc

    # x11
    ln -sf $REPO/xsessionrc.sh ~/.xsessionrc
    ln -sf $REPO/Xresources ~/.Xresources

    # keymap
    ln -sf $REPO/xkeysnail.py ~/.xkeysnail.py
    ln -sf $REPO/xremap.rb ~/.xremap.rb

    # systemd
    ln -sf $REPO/systemd/xremap.service ~/.config/systemd/user/xremap.service

    # fontconfig
    ln -sf $REPO/fonts.conf ~/.config/fontconfig/fonts.conf

    # gnome Apps
    ln -sf $REPO/gnome-apps/spacemacs.desktop ~/.local/share/applications/spacemacs.desktop
    ln -sf $REPO/gnome-apps/doom-emacs.desktop ~/.local/share/applications/doom-emacs.desktop
    ln -sf $REPO/gnome-apps/spacemacsclient.desktop ~/.local/share/applications/spacemacsclient.desktop

    # mozc
    ln -snf ~/Dropbox/mozc/.mozc ~/.mozc

    # vscode
    ln -sf $REPO/vscode/settings.json ~/.config/Code/User/settings.json

    # misc
    ln -sf $REPO/inputrc.sh ~/.inputrc
fi

# MacOS only
if [ $(uname -s) = 'Darwin' ]; then
    :
fi
