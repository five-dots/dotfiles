define :activate do |wm_class, command|
  execute("wmctrl -x -a #{wm_class.shellescape} || #{command.shellescape}")
end

# Check WM_CLASS by wmctrl -x -l
remap 'M-b', to: activate('google-chrome.Google-chrome', '/opt/google/chrome/chrome')
remap 'M-e', to: activate('emacs.Emacs', '/usr/bin/emacs')
remap 'M-t', to: activate('gnome-terminal-server.Gnome-terminal', '/usr/bin/gnome-terminal')
remap 'M-f', to: activate('nautilus.Nautilus', '/usr/bin/nautilus')
