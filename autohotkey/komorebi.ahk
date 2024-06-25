#Requires AutoHotkey v2.0
#SingleInstance Force

IsKomorebiRunning() {
  Return ProcessExist("komorebi.exe") > 0
}

Focus(direction) {
  RunWait("komorebic.exe focus " direction, , "Hide")
}

Move(direction) {
  RunWait("komorebic.exe move " direction, , "Hide")
}

Stack(direction) {
  RunWait("komorebic.exe stack " direction, , "Hide")
}

; Start/Stop Komorebi
#+^p::{
  if IsKomorebiRunning() {
    RunWait("komorebic stop", , "Hide")
  } else {
    RunWait("komorebic start --config $Env:KOMOREBI_CONFIG_HOME\komorebi.json", , "Hide")
  }
}

; Focus
#h::IsKomorebiRunning() ? Focus("left")  : Send("#h")
#j::IsKomorebiRunning() ? Focus("down")  : Send("#j")
#k::IsKomorebiRunning() ? Focus("up")    : Send("#k")
#l::IsKomorebiRunning() ? Focus("right") : Send("#l")

; Move
#+h::IsKomorebiRunning() ? Move("left")  : Send("#+h")
#+j::IsKomorebiRunning() ? Move("down")  : Send("#+j")
#+k::IsKomorebiRunning() ? Move("up")    : Send("#+k")
#+l::IsKomorebiRunning() ? Move("right") : Send("#+l")

; Stack
#+^h::IsKomorebiRunning() ? Stack("left")  : Send("#+^h")
#+^j::IsKomorebiRunning() ? Stack("down")  : Send("#+^j")
#+^k::IsKomorebiRunning() ? Stack("up")    : Send("#+^k")
#+^l::IsKomorebiRunning() ? Stack("right") : Send("#+^l")
#s::IsKomorebiRunning() ?RunWait("komorebic.exe unstack", , "Hide") : Send("#s")
#[::IsKomorebiRunning() ?RunWait("komorebic.exe cycle-stack previous", , "Hide") : Send("#[")
#]::IsKomorebiRunning() ?RunWait("komorebic.exe cycle-stack next", , "Hide") : Send("#]")

; Resize (Horizontal: +-, Vertical: Ctrl+-)
#=::IsKomorebiRunning() ?RunWait("komorebic.exe resize-axis horizontal increase", , "Hide") : Send("#=")
#-::IsKomorebiRunning() ?RunWait("komorebic.exe resize-axis horizontal decrease", , "Hide") : Send("#=")
#^=::IsKomorebiRunning() ?RunWait("komorebic.exe resize-axis vertical increase", , "Hide") : Send("#^=")
#^-::IsKomorebiRunning() ?RunWait("komorebic.exe resize-axis vertical decrease", , "Hide") : Send("#^-")

; Float and maximize
#f::IsKomorebiRunning() ? RunWait("komorebic.exe toggle-float", , "Hide") : Send("#f")
#m::IsKomorebiRunning() ? RunWait("komorebic.exe toggle-monocle", , "Hide") : WinMaximize("A")

; Misc
#o::IsKomorebiRunning() ? RunWait("komorebic.exe promote", , "Hide") : Send("#o")
#+r::IsKomorebiRunning() ? RunWait("komorebic.exe retile", , "Hide") : Send("#+r")
#p::IsKomorebiRunning() ? RunWait("komorebic.exe toggle-pause", , "Hide") : Send("#p")

; Layout
#x::IsKomorebiRunning() ? RunWait("komorebic.exe flip-layout horizontal", , "Hide") : Send("#x")
#y::IsKomorebiRunning() ? RunWait("komorebic.exe flip-layout vertical", , "Hide") : Send("#y")

; Workspaces
#^1::IsKomorebiRunning() ? RunWait("komorebic.exe focus-workspaces 0", , "Hide") : Send("#^1")
#^2::IsKomorebiRunning() ? RunWait("komorebic.exe focus-workspaces 1", , "Hide") : Send("#^2")
#^3::IsKomorebiRunning() ? RunWait("komorebic.exe focus-workspaces 2", , "Hide") : Send("#^3")

#^j::{
  if IsKomorebiRunning() {
    RunWait("komorebic.exe cycle-workspace next", , "Hide")
    RunWait("komorebic.exe cycle-monitor next", , "Hide")
    RunWait("komorebic.exe cycle-workspace next", , "Hide")
    RunWait("komorebic.exe cycle-monitor previus", , "Hide")
  } else {
    Send("#^j")   
  }
}

#^k::{
  if IsKomorebiRunning() {
    RunWait("komorebic.exe cycle-workspace previous", , "Hide")
    RunWait("komorebic.exe cycle-monitor next", , "Hide")
    RunWait("komorebic.exe cycle-workspace previous", , "Hide")
    RunWait("komorebic.exe cycle-monitor previus", , "Hide")
  } else {
    Send("#^j")   
  }
}

#+1::{
  if IsKomorebiRunning() {
    RunWait("komorebic.exe move-to-workspace 0", , "Hide")
    RunWait("komorebic.exe focus-workspaces 0", , "Hide")
  } else {
    Send("#+1")
  }
}

#+2::{
  if IsKomorebiRunning() {
    RunWait("komorebic.exe move-to-workspace 1", , "Hide")
    RunWait("komorebic.exe focus-workspaces 1", , "Hide")
  } else {
    Send("#+2")
  }
}

#+3::{
  if IsKomorebiRunning() {
    RunWait("komorebic.exe move-to-workspace 2", , "Hide")
    RunWait("komorebic.exe focus-workspaces 2", , "Hide")
  } else {
    Send("#+3")
  }
}
