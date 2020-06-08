
; Ctrl+j => ESC
^j::
	Send, {Escape 2}
	return

; Ctrl+; => ESC
; ^`;::
; 	Send, {Escape 2}
; 	return

; Ctrl+h => Backspace
; ^h::
; 	Send, {Backspace}
; 	return

; Left Alt + hjkl
<!h::
	Send, {Left}
	return
<!j::
	Send, {Down}
	return
<!k::
	Send, {Up}
	return
<!l::
	Send, {Right}
	return

; Alt + uiop => PageDown,PageUp,Home,End
;<!u::
;	Send, {PgDn}
;	return
;<!i::
;	Send, {PgUp}
;	return

; Ctrl + Alt + hjkl => Home, }, {, End
;<!^h::
;	Send, {Home}
;	return
;<!^j::
;	Send, {}} ; Send }
;	return
;<!^k::
;	Send, {{} ; Send {
;	return
;<!^l::
;	Send, {End}
;	return

; Ctrl+Alt hjkl => Mouse wheel
;<!^j::
;	Send, {WheelDown 4}
;	Return
;<!^k::
;	Send, {WheelUp 4}
;	Return
;<!^h::
;	Send, {WheelLeft 5}
;	Return
;<!^l::
;	Send, {WheelRight 5}
;	Return

