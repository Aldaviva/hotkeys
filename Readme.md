hotkeys
===

This is an AutoHotkey script that adds useful keyboards.

<!-- MarkdownTOC autolink="true" bracket="round" autoanchor="true" levels="1,2,3" -->

- [Keyboard shortcuts](#keyboard-shortcuts)
    - [Set Windows Explorer view mode](#set-windows-explorer-view-mode)
    - [Location clipboard](#location-clipboard)
    - [Type different characters](#type-different-characters)
    - [Send reserved hotkeys to other applications](#send-reserved-hotkeys-to-other-applications)
    - [Minimize active window](#minimize-active-window)

<!-- /MarkdownTOC -->


<a id="keyboard-shortcuts"></a>
## Keyboard shortcuts

<a id="set-windows-explorer-view-mode"></a>
### Set Windows Explorer view mode

|Shortcut|Action|
|---|---|
|`Ctrl`+`1`|Medium Icons|
|`Ctrl`+`2`|List|
|`Ctrl`+`3`|Details|

Change the view of a Windows Explorer directory list UI. This applies to Explorer folder windows as well as dialogs whose titles start with "Open," "Save," and "Browse."

<a id="location-clipboard"></a>
### Location clipboard

|Shortcut|Action|
|---|---|
|`Ctrl`+`Shift`+`C`|Copy location from Windows Explorer|
|`Ctrl`+`Shift`+`V`|Paste location into Windows Explorer or Total Commander|

Total Commander has its own copy location command (`cm_CopySrcPathToClip`), so that functionality is not duplicated here.

<a id="type-different-characters"></a>
### Type different characters

|Shortcut|Example|Action|
|---|---|---|
|`Win`+`-`               |`–`|Type en dash (for ranges)|
|`Win`+`Shift`+`-`       |`—`|Type em dash (like a colon)|
|`Win`+`Shift`+`,`       |`‹`|Type left single angle quotation mark|
|`Win`+`Shift`+`.`       |`›`|Type right single angle quotation mark|
|`Win`+`Ctrl`+`Shift`+`,`|`«`|Type left double angle quotation mark|
|`Win`+`Ctrl`+`Shift`+`.`|`»`|Type right double angle quotation mark|
|`Win`+`Ctrl`+`Alt`+`,`  |`≤`|Type less than or equal to|
|`Win`+`Ctrl`+`Alt`+`.`  |`≥`|Type greater than or equal to|
|`Win`+`8`               |`×`|Type multiplication sign|
|`Win`+`0`               |`°`|Type degree sign|
|`Win`+`Alt`+`↑`         |`↑`|Type up arrow|
|`Win`+`Alt`+`→`         |`→`|Type right arrow|
|`Win`+`Alt`+`↓`         |`↓`|Type down arrow|
|`Win`+`Alt`+`←`         |`←`|Type left arrow|
|`Win`+`Alt`+`.`         |`…`|Type ellipsis|

<a id="send-reserved-hotkeys-to-other-applications"></a>
### Send reserved hotkeys to other applications

|Shortcut|Action|
|---|---|
|`Win`+`Alt`+`T`|Type `Win`+`Ctrl`+`Alt`+`T`|

This is used to make `Win`+`Alt`+`T` show the [PS Tray Factory](https://www.pssoftlab.com/pstf_info.phtml) menu.

Normally, this shortcut conflicts with Windows Explorer, which reserves `Win`+`T` for cycling through taskbar buttons. This is useless to me because I use `Alt`+`Tab` to switch windows and have no other use for interacting with taskbar buttons with the keyboard.

To make this work with PS Tray Factory, you have to set "Show the system tray menu" to `Win`+`Ctrl`+`Alt`+`T` in PS Tray Factory › Options › System Tray Icons List.

<a id="minimize-active-window"></a>
### Minimize active window

|Shortcut|Action|
|---|---|
|`Win`+`PgUp`|Minimize active window|

This is only necessary and available on Windows ≤ 7. It's here to work around a bug with DWM and Vivaldi where minimizing Vivaldi would disable DWM compositing. Windows 8 and later can't disable DWM and therefore don't have this problem, so you can use your favorite window manager helper like [WindowSizeGuard](https://github.com/Aldaviva/WindowSizeGuard) or [WinSplit Revolution](https://www.majorgeeks.com/files/details/winsplit_revolution.html) to minimize the active window instead.
