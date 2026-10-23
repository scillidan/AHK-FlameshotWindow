; FlameshotWindow.ahk - Capture the active window with Flameshot
; License: MIT (c) scillidan
;
; Wraps FlameshotWindow.sh (same folder): detects the foreground window
; bounds, then opens `flameshot gui --region WxH+X+Y` with the area
; pre-selected (Snipaste-like window capture).

#SingleInstance force

scriptDir := A_ScriptDir
iniPath := scriptDir . "\FlameshotWindow.ini"

if (!FileExist(iniPath)) {
    MsgBox, 0x10, Error, Configuration file not found:`n%iniPath%
    ExitApp
}

IniRead, captureHotkey, %iniPath%, FlameshotWindow, GlobalHotkey, ^+PrintScreen
; "bash.exe" alone resolves via PATH; absolute path is safer in startup contexts
IniRead, bashExe, %iniPath%, FlameshotWindow, BashPath, bash.exe

shortcutPath := A_StartMenu . "\Programs\Startup\FlameshotWindow.lnk"
isStartup := FileExist(shortcutPath)

if (captureHotkey != "")
    Hotkey, %captureHotkey%, CaptureWindow

Menu, Tray, NoStandard
Menu, Tray, Add, Start with Windows, ToggleStartup
if (isStartup)
    Menu, Tray, Check, Start with Windows
Menu, Tray, Add
Menu, Tray, Add, Edit Config, EditConfig
Menu, Tray, Add, Reload, ReloadScript
Menu, Tray, Add, Exit, ExitScript
UpdateTrayTip()
if (FileExist(scriptDir . "\assets\icon.ico"))
    Menu, Tray, Icon, % scriptDir . "\assets\icon.ico"
return

UpdateTrayTip() {
    global captureHotkey
    tip := "FlameshotWindow"
    if (captureHotkey != "")
        tip .= "`nCapture: " . captureHotkey
    Menu, Tray, Tip, %tip%
}

CaptureWindow:
    enginePath := A_ScriptDir . "\FlameshotWindow.sh"
    StringReplace, enginePath, enginePath, \, /, All
    Run, % """" . bashExe . """ """ . enginePath . """", , Hide
return

EditConfig:
    EnvGet, envEditor, EDITOR
    scriptEditor := (envEditor != "") ? envEditor : "notepad"
    Run, %scriptEditor% "%iniPath%"
return

ToggleStartup:
    if (FileExist(shortcutPath)) {
        FileDelete, %shortcutPath%
        Menu, Tray, Uncheck, Start with Windows
    } else {
        FileCreateShortcut, %A_ScriptFullPath%, %shortcutPath%, %A_ScriptDir%
        Menu, Tray, Check, Start with Windows
    }
return

ReloadScript:
    Reload
return

ExitScript:
    ExitApp
