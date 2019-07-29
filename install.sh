#!/bin/sh

REPO=~/Dropbox/repos/github/five-dots/dotfiles

# Install script
ln -sf $REPO/install.sh ~/bin/install.sh

# Shell
ln -sf $REPO/bashrc ~/.bashrc
ln -sf $REPO/bash_aliases ~/.bash_aliases
ln -sf $REPO/inputrc ~/.inputrc
ln -sf $REPO/profile ~/.profile
ln -sf $REPO/config.fish ~/.config/fish/config.fish

# X11
ln -sf $REPO/xsessionrc ~/.xsessionrc
ln -sf $REPO/Xresources ~/.Xresources

# Keymap
ln -sf $REPO/xkeysnail.py ~/.xkeysnail.py
ln -sf $REPO/xremap.rb ~/.xremap.rb

# emacs
ln -sf ~/Dropbox/repos/github/syl20bnr/spacemacs ~/.spacemacs.d
ln -sf $REPO/emacs.d ~/.emacs.d
ln -sf $REPO/emacs.el ~/.emacs
ln -sf $REPO/spacemacs.el ~/.spacemacs

# vim
# ln -sf $REPO/vimrc.vim ~/.vimrc
# ln -sf $REPO/gvimrc.vim ~/.gvimrc

# R
ln -sf $REPO/Rprofile.R ~/.Rprofile
ln -sf $REPO/secret.R ~/.secret.R

# systemd
ln -sf $REPO/systemd/xremap.service ~/.config/systemd/user/xremap.service

# git
ln -sf $REPO/gitconfig ~/.gitconfig

# vscode
ln -sf $REPO/vscode/settings.json ~/.config/Code/User/settings.json

# Fontconfig
ln -sf $REPO/fonts.conf ~/.config/fontconfig/fonts.conf
