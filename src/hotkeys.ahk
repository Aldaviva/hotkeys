; Hotkeys
; - Minimize active window
; - Set Windows Explorer view mode
; - Windows Explorer location clipboard
; - Total Commander location clipboard
; - Type different characters
; - Send reserved hotkeys to other applications

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Common statements

#NoTrayIcon
#MenuMaskKey vkFF

isWindowsExplorerActive(){
	return WinActive("ahk_class CabinetWClass") or WinActive("ahk_class #32770") or WinActive("Open") or WinActive("Save") or WinActive("Browse")
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer view mode
; Ctrl+1    Extra Large Icons
; Ctrl+2    Medium Icons
; Ctrl+3    List
; Ctrl+4    Details

~^1::SendExplorerKeyboardShortcut("{Ctrl down}{Shift down}1{Shift up}")
~^2::SendExplorerKeyboardShortcut("{Ctrl down}{Shift down}3{Shift up}")
~^3::SendExplorerKeyboardShortcut("{Ctrl down}{Shift down}5{Shift up}")
~^4::SendExplorerKeyboardShortcut("{Ctrl down}{Shift down}6{Shift up}")

SendExplorerKeyboardShortcut(shortcutSequence) {
	If (isWindowsExplorerActive()) {
		SendInput, %shortcutSequence%
	}
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer location clipboard
; Total Commander location clipboard
; Ctrl+Shift+C  Copy location to clipboard
; Ctrl+Shift+V  Paste location from clipboard

~^+c::
If (isWindowsExplorerActive()) {
	SendInput, {Ctrl up}{Shift up}{Alt down}d{Alt up}{Ctrl down}c{Ctrl up}{Esc}{Tab}{Tab}{Tab}{Tab}
}
return

~^+v::
If (isWindowsExplorerActive()) {
	SendInput, {Ctrl up}{Shift up}{Alt down}d{Alt up}{Ctrl down}v{Ctrl up}{Enter}
} Else If (WinActive("ahk_class TTOTAL_CMD")) {
	; The transient autocompletion dropdown takes an extra Enter keystroke to dismiss, but it only appears sometimes.
	; When it doesn't appear, the extra Enter erroneously navigates to "..".
	; To work around this, surround the pasted path with double-quotation-marks, which seems to disable the autocompletion and still let Total Commander actually navigate to the
	; path successfully.
	;     example: "d:\Music\New Rock\Interpol"
	;
	; The syntax coloring is wrong in SublimeAutoHotkey, the following SendInput argument is actually one string literal definition, containing two single inner 
	; double-quotation-marks, and the whole thing is delimited by two outer double-quotation marks
	; package: https://github.com/ahkscript/SublimeAutoHotkey
	;
	; The AutoHotkey documentation is wrong: it says to insert an escaped double-quotation-mark with a second double-quotation mark, like ""
	;     > To include an actual quote character inside a quoted string, specify two consecutive quotes
	;	  > source: https://www.autohotkey.com/docs/Language.htm#strings
	; This inserts "" into Total Commander, not "
	SendInput, "{Shift up}{Ctrl down}l{Ctrl up}"{Ctrl down}v{Ctrl up}"{Enter}"
}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Type different characters
; Win+-              –   en dash (for ranges)
; Win+Shift+-        —   em dash (like a colon)
; Win+Shift+,        ‹   left single angle quotation mark
; Win+Shift+.        ›   right single angle quotation mark
; Win+Ctrl+Shift+,   «   left double angle quotation mark
; Win+Ctrl+Shift+.   »   right double angle quotation mark
; Win+Ctrl+Alt+,     ≤   less than or equal to
; Win+Ctrl+Alt+.     ≥   greater than or equal to
; Win+8              ×   multiplication sign
; Win+0              °   degree sign
; Win+Alt+↑          ↑   up arrow
; Win+Alt+→          →   right arrow
; Win+Alt+↓          ↓   down arrow
; Win+Alt+←          ←   left arrow
; Win+Alt+.          …   ellipsis

$#-::
	Process, Exist, Magnify.exe
	if (ErrorLevel = 0) {
		Send {U+2013}
	} else {
		SendInput, {LWin down}-{LWin up}
	}
	return
$#+-::
	Process, Exist, Magnify.exe
	if (ErrorLevel = 0) {
		Send {U+2014}
	} else {
		SendInput, {LWin down}{Shift down}-{Shift up}{LWin up}
	}
	return
#+.::      Send {U+203A}
#+^.::     Send {U+00BB}
#+,::      Send {U+2039}
#+^,::     Send {U+00AB}
#!^,::     Send {U+2264}
#!^.::     Send {U+2265}
#8::       Send {U+00D7}
#0::       Send {U+00B0}
$#!Up::    Send {U+2191}
$#!Right:: Send {U+2192}
$#!Down::  Send {U+2193}
$#!Left::  Send {U+2190}
#!.::      Send {U+2026}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Send hotkeys to PS Tray Factory that would otherwise be reserved by Windows Explorer.
; Win+Alt+T		Show PS Tray Factory menu

$#!T::Send {LWin down}{Alt down}{Ctrl down}t{Ctrl up}
