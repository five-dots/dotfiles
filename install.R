#!/usr/bin/env Rscript

## Check packages availability and attach them ---------------------------------
need_pkgs <- c("fs", "tibble", "glue", "purrr", "rlang")
inst_pkgs <- installed.packages()[, 1L]
if (!all(need_pkgs %in% inst_pkgs))
  stop(paste0(need_pkgs, collapse = ", "), " are needed to run this script.")

for (pkg in need_pkgs)
  library(pkg, character.only = TRUE, warn.conflicts = FALSE, quietly = TRUE)

## Make symlinks ---------------------------------------------------------------

g <- glue
r <- "~/Dropbox/repos/github/five-dots/dotfiles"
s <- g("{r}/shell")
e <- g("{r}/emacsen")
k <- g("{r}/keymap")
a <- g("{r}/autostart")
G <- g("{r}/gnome-apps")

sysd <- "~/.config/systemd"
auto <- "~/.config/autostart"
gapp <- "~/.local/share/applications"

## os: "Both", "Linux" or "Darwin"

files <- tribble(
  ~src, ~dist, ~os,
  ## Shortcuts
  g("{r}/install.R"),                   "~/bin/install.R", "Both",
  g("~/Dropbox/repos/private/scripts"), "~/scripts",       "Both",

  ## Shell
  g("{s}/zshrc.zsh"),     "~/.zshrc",     "Both",
  g("{s}/zpreztorc.zsh"), "~/.zpreztorc", "Both",
  g("{s}/aliases.sh"),    "~/.aliases",   "Both",
  g("{s}/profile.sh"),    "~/.profile",   "Linux",
  g("{s}/bashrc.sh"),     "~/.bashrc",    "Linux",
  g("{s}/inputrc.sh"),    "~/.inputrc",   "Linux",

  ## Emacs
  ## g("{e}/emacs.el"),               "~/.emacs",             "Both",
  g("~/Dropbox/repos/github/plexus/chemacs/.emacs"), "~/.emacs", "Both",
  g("{e}/emacs-profiles.el"),       "~/.emacs-profiles.el",       "Both",
  g("{e}/emacs.d/init.el"),         "~/.emacs.d/init.el",         "Both",
  g("{e}/doom.d"),                  "~/.doom.d",                  "Both",
  g("{e}/spacemacs/spacemacs.el"),  "~/.spacemacs",               "Both",
  g("{e}/emacs.d/init.el"),         "~/.emacs.d/init.el",         "Both",
  g("{e}/emacs.d/init-config.org"), "~/.emacs.d/init-config.org", "Both",
  g("{e}/emacs.d/dump.el"),         "~/.emacs.d/dump.el",         "Both",

  ## Vim
  ## g("{r}/vim/vimrc.vim"),  "~/.vimrc",  "Both",
  ## g("{r}/vim/gvimrc.vim"), "~/.gvimrc", "Both",

  ## R
  g("{r}/R/Rprofile.R"),       "~/.Rprofile",         "Both",
  g("{r}/R/Renviron.sh"),      "~/.Renviron",         "Both",
  g("{r}/R/secret.R"),         "~/.secret.R",         "Both",
  g("{r}/R/radian_profile.R"), "~/.radian_profile.R", "Both",

  ## Keybind
  g("{k}/Xmodmap"),      "~/.Xmodmap",             "Linux",
  g("{k}/xremap.rb"),    "~/.xremap.rb",           "Linux",
  g("{k}/xkeysnail.py"), "~/.xkeysnail.py",        "Linux",
  g("{k}/keymap.sh"),    "~/.keymap.sh",           "Linux",
  g("{k}/autokey"),      "~/.config/autokey/data", "Linux",

  ## Startup script
  g("{a}/keymap.desktop"), g("{auto}/keymap.desktop"), "Linux",

  ## systemd
  g("{r}/systemd/xremap.service"), g("{sysd}/user/xremap.service"), "Linux",

  ## X11
  g("{r}/X11/xsessionrc.sh"), "~/.xsessionrc", "Linux",
  g("{r}/X11/Xresources"),    "~/.Xresources", "Linux",

  ## Font
  g("~/Dropbox/fonts"), "~/.fonts",                        "Linux",
  g("{r}/fonts.conf"),  "~/.config/fontconfig/fonts.conf", "Linux",

  ## Gnome apps
  g("{G}/emacs.desktop"),           g("{gapp}/emacs.desktop"),           "Linux",
  g("{G}/spacemacs.desktop"),       g("{gapp}/spacemacs.desktop"),       "Linux",
  ## g("{G}/spacemacsclient.desktop"), g("{gapp}/spacemacsclient.desktop"), "Linux",
  g("{G}/doom-emacs.desktop"),      g("{gapp}/doom-emacs.desktop"),      "Linux",
  g("{G}/vbox_win10.desktop"),      g("{gapp}/vbox_win10.desktop"),      "Linux",
  g("{G}/tws_U1655952.desktop"),    g("{gapp}/tws_U1655952.desktop"),    "Linux",
  g("{G}/tws_U1960993.desktop"),    g("{gapp}/tws_U1960993.desktop"),    "Linux",
  g("{G}/tws_DU324132.desktop"),    g("{gapp}/tws_DU324132.desktop"),    "Linux",

  ## vscode
  g("{r}/vscode/settings.json"), "~/.config/Code/User/settings.json", "Linux",

  ## Misc
  g("{r}/gitconfig"), "~/.gitconfig", "Both",
  g("{r}/skk.el"),    "~/.skk",       "Both",

  ## g("~/Dropbox/mozc/.mozc"),        "~/.mozc",                           "Both",
)

purrr::pwalk(files, function(src, dist, os) {
  ## Check platform
  if (os != "Both" && Sys.info()["sysname"] != os) return()

  ## Create source directory if not exist
  dist_dir <- path_dir(dist)
  if (!dir_exists(dist_dir)) dir_create(dist_dir, recurse = TRUE)

  ## Delete current symlink if exists
  if (is_link(dist)) link_delete(dist)

  if (!file_exists(dist) && !dir_exists(dist))
    link_create(src, dist)

})
