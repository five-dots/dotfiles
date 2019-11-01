#!/bin/sh

REPO=~/Dropbox/repos/github/five-dots/dotfiles

# Install script
ln -sf $REPO/install.sh ~/bin/install.sh

# Shell
ln -sf $REPO/bashrc.sh ~/.bashrc
ln -sf $REPO/bash_aliases.sh ~/.bash_aliases
ln -sf $REPO/inputrc.sh ~/.inputrc
ln -sf $REPO/profile.sh ~/.profile
ln -sf $REPO/config.fish ~/.config/fish/config.fish

# X11
ln -sf $REPO/xsessionrc.sh ~/.xsessionrc
ln -sf $REPO/Xresources ~/.Xresources

# Keymap
ln -sf $REPO/xkeysnail.py ~/.xkeysnail.py
ln -sf $REPO/xremap.rb ~/.xremap.rb

# emacs
ln -sf $REPO/emacsen/emacs.el ~/.emacs
ln -sf $REPO/emacsen/spacemacs-config/spacemacs.el ~/.spacemacs

ln -snf $REPO/emacsen/spacemacs.d ~/.spacemacs.d
ln -snf $REPO/emacsen/spacemacs.d ~/.emacs.d
ln -snf $REPO/emacsen/vanilla-emacs.d ~/.vanilla-emacs.d
ln -snf $REPO/emacsen/doom.d ~/.doom.d
# ln -snf ~/.doom-emacs.d ~/.emacs.d

# vim
# ln -sf $REPO/vimrc.vim ~/.vimrc
# ln -sf $REPO/gvimrc.vim ~/.gvimrc

# R
ln -sf $REPO/Rprofile.R ~/.Rprofile
ln -sf $REPO/Renviron.sh ~/.Renviron
ln -sf $REPO/secret.R ~/.secret.R

# systemd
ln -sf $REPO/systemd/xremap.service ~/.config/systemd/user/xremap.service

# git
ln -sf $REPO/gitconfig ~/.gitconfig

# vscode
ln -sf $REPO/vscode/settings.json ~/.config/Code/User/settings.json

# Fontconfig
ln -sf $REPO/fonts.conf ~/.config/fontconfig/fonts.conf

# Gnome Apps
ln -sf $REPO/gnome-apps/spacemacs.desktop ~/.local/share/applications/spacemacs.desktop
ln -sf $REPO/gnome-apps/doom-emacs.desktop ~/.local/share/applications/doom-emacs.desktop
ln -sf $REPO/gnome-apps/spacemacsclient.desktop ~/.local/share/applications/spacemacsclient.desktop

# mozc
ln -snf ~/Dropbox/mozc/.mozc ~/.mozc
