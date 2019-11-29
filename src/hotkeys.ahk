; Hotkeys
; - Minimize active window
; - Set Windows Explorer view mode
; - Windows Explorer location clipboard
; - Total Commander location clipboard


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Minimize Windows, including Vivaldi, without disabling the Desktop Window Manager Session Manager
; Win+PageUp: Minimize active window to taskbar

; This script provides a hotkey (Win+PageUp) to minimize the active window.
; This is better than the built-in Windows shortcut of Win+Down because that also turns on screen edge snapping and other hotkeys which can't even be rebound
; This is better than WinSplit Revolution, which uses a different technique to minimize windows that causes Vivaldi to stop DWM
; This is better than UltraMon, which has a hotkey for maximizing but not minimizing a window
; sources:
;   https://www.autohotkey.com/docs/commands/WinMinimize.htm
;   https://www.autohotkey.com/docs/misc/WinTitle.htm

#NoTrayIcon

#PgUp::
;WinMinimize, A ; doesn't work, causes DWM to stop

PostMessage, 0x112, 0xF020,,, A
; This works. DWM keeps running.
; 0x112 = WM_SYSCOMMAND
; 0xF020 = SC_MINIMIZE
; A = currently active window
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer view modes
; Ctrl+1: Large Icons
; Ctrl+2: List
; Ctrl+2: Details

~^1::
SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vr{Enter}")
return

~^2::
SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vl")
return

~^3::
SendExplorerKeyboardShortcut("{Ctrl up}{Alt}vd")
return

SendExplorerKeyboardShortcut(shortcutSequence) {
	If (WinActive("ahk_class CabinetWClass")) {
		SendInput, %shortcutSequence%
	}
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Windows Explorer Location Clipboard
; Total Commander Location Clipboard
; Ctrl+Shift+C: Copy location to clipboard
; Ctrl+Shift+V: Paste location from clipboard

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


