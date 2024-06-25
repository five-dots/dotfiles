#Requires AutoHotkey v2.0
#SingleInstance Force

#Include ./lib/ime/IMEv2.ahk
#Include komorebi.ahk

~Esc::IME_SET(0)

#HotIf WinActive("ahk_exe wezterm-gui.exe")
  $^c::^+c
  $^+c::^c
  $^v::^+v
  ^BS::^w  ; Ctrl-Backspace to delete word
#HotIf

; Window Operations
#q::WinClose("A")
#+m::WinMinimize("A")

; Remap Ctrl-; to Ctrl-b for tmux
^`;::^b