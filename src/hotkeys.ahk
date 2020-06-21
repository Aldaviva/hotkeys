; Hotkeys
; - Minimize active window
; - Set Windows Explorer view mode
; - Windows Explorer location clipboard
; - Total Commander location clipboard
; - Type different characters
; - Listen for reserved hotkeys and redirect them to WinSplit Revolution

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#NoTrayIcon

; Minimize active window
; This works with Vivaldi without disabling the Desktop Window Manager Session Manager.
; Win+PageUp    Minimize active window to taskbar

; This script provides a hotkey (Win+PageUp) to minimize the active window.
; This is better than the built-in Windows shortcut of Win+Down because that also turns on screen edge snapping and other hotkeys which can't even be rebound
; This is better than WinSplit Revolution, which uses a different technique to minimize windows that causes Vivaldi to stop DWM
; This is better than UltraMon, which has a hotkey for maximizing but not minimizing a window
; sources:
;   https://www.autohotkey.com/docs/commands/WinMinimize.htm
;   https://www.autohotkey.com/docs/misc/WinTitle.htm
;
; Only used in Windows 7 and earlier, since Windows 8 and later don't have this problem with their desktop composition.

osMajorVersion := StrSplit(A_OSVersion, ".")
If (osMajorVersion[1] <= 7) {
	#PgUp::
		;WinMinimize, A ; doesn't work, causes DWM to stop

		PostMessage, 0x112, 0xF020,,, A
		; This works. DWM keeps running.
		; 0x112 = WM_SYSCOMMAND
		; 0xF020 = SC_MINIMIZE
		; A = currently active window
		return
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer view mode
; Ctrl+1    Large Icons
; Ctrl+2    List
; Ctrl+2    Details

~^1:: SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vr{Enter}")
~^2:: SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vl")
~^3:: SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vd")

SendExplorerKeyboardShortcut(shortcutSequence) {
	If (WinActive("ahk_class CabinetWClass")) {
		SendInput, %shortcutSequence%
	}
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer location clipboard
; Total Commander location clipboard
; Ctrl+Shift+C  Copy location to clipboard
; Ctrl+Shift+V  Paste location from clipboard

~^+c::
If (WinActive("ahk_class CabinetWClass")) {
	SendInput, {Ctrl up}{Shift up}{Alt down}d{Alt up}{Ctrl down}c{Ctrl up}{Esc}{Tab}{Tab}{Tab}{Tab}
}
return

~^+v::
If (WinActive("ahk_class CabinetWClass")) {
	SendInput, {Ctrl up}{Shift up}{Alt down}d{Alt up}{Ctrl down}v{Ctrl up}{Enter}
} Else If (WinActive("ahk_class TTOTAL_CMD")) {
	SendInput, {Shift up}{Ctrl down}lv{Ctrl up}{Enter}
}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Type different characters
; Win+-         –   en dash (for ranges)
; Win+Shift+-   —   em dash (like a colon)
; Win+,         ‹   left single angle quotation mark
; Win+.         ›   right single angle quotation mark
; Win+Shift+,   «   left double angle quotation mark
; Win+Shift+.   »   right double angle quotation mark
; Win+8         ×   multiplication sign
; Win+Ctrl+↑    ↑   up arrow
; Win+Ctrl+→    →   right arrow
; Win+Ctrl+↓    ↓   down arrow
; Win+Ctrl+←    ←   left arrow

#-::      Send {U+2013}
#+-::     Send {U+2014}
#.::      Send {U+203A}
#+.::     Send {U+00BB}
#,::      Send {U+2039}
#+,::     Send {U+00AB}
#8::      Send {U+00D7}
#^Up::    Send {U+2191}
#^Right:: Send {U+2192}
#^Down::  Send {U+2193}
#^Left::  Send {U+2190}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Send hotkeys to WinSplit Revolution that would otherwise be reserved by Windows Explorer.
; For this to work, WinSplit Revolution must be configured to use numpad inputs for window positioning.
; Unfortunately, WinSplit Revolution is unable to override existing hotkeys, such as Win+Home in Windows 10, like AutoHotkey can. Therefore, this script overrides the desired hotkey, then sends a different hotkey that WinSplit Revolution was able to listen for.
; In order to move elevated processes, both this program and WinSplit Revolution must also run elevated. This script's build script will add the administratorRequired element to the EXE manifest, so it will automatically try to elevate on start. Make sure to manually set WinSplit Revolution to run as administrator in the EXE file properties.
;
; This layout uses the keyboard navigation cluster for window placement.
; You can also use the Win+arrow keys for halves.
;
; Win+Home		Resize window to top half of screen
; Win+↑			Resize window to top half of screen
; Win+Del		Resize window to left half of screen
; Win+←			Resize window to left half of screen
; Win+PgDn		Resize window to right half of screen
; Win+→			Resize window to right half of screen
; Win+End		Resize window to bottom half of screen
; Win+↓			Resize window to bottom half of screen
; Win+Ins		Maximize window
; Win+Alt+Home	Resize window to top-left corner of screen
; Win+Alt+PgUp	Resize window to top-right corner of screen
; Win+Alt+End	Resize window to bottom-left corner of screen
; Win+Alt+PgDn	Resize window to bottom-right corner of screen

#Insert::#Numpad0
#Home::#Numpad8
#Delete::#Numpad4
#End::#Numpad2
#PgDn::#Numpad6
#!Insert::Send {LWin down}{Numpad5}
#!Home::Send {LWin down}{Numpad7}
#!PgUp::Send {LWin down}{Numpad9}
#!End::Send {LWin down}{Numpad1}
#!PgDn::Send {LWin down}{Numpad3}
#Up::#Numpad8
#Down::#Numpad2
#Left::#Numpad4
#Right::#Numpad6
