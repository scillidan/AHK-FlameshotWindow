<div align="center">
  <img src="assets/icon.png" alt="icon" width="32" />
</div>

# AHK-FlameshotWindow

Capture a specific window with [Flameshot](https://github.com/flameshot-org/flameshot): detect the window bounds, then open `flameshot gui --region WxH+X+Y` with that area pre-selected (Snipaste-like window capture).

Authors: Kimi-K2.7-Code🧙‍♂️, scillidan🤡

The icon is a placeholder and will be replaced.

## Requirements

- [AutoHotkey v1](https://www.autohotkey.com)
- [uv](https://docs.astral.sh/uv/)
- git-bash (`bash.exe`)

## Usage

1. Edit `FlameshotWindow.ini` (hotkey, bash path)
2. Run `autohotkeyu64 FlameshotWindow.ahk`, or `just dist` for `FlameshotWindow.exe`
3. Press the hotkey (default `Ctrl+Shift+PrintScreen`): the active window's region is handed to Flameshot, pre-selected and ready to annotate

`FlameshotWindow.sh` also runs standalone (Linux/X11 included):

```sh
FlameshotWindow.sh --select   # pick the window with the mouse
FlameshotWindow.sh --delay 2  # grab the active window after 2s
```

## Roadmap

- v1.0.0: scroll-wheel element picker (HWND hierarchy + UI Automation), Snipaste Pro style

## Third-party Libraries

None. The capture engine (`FlameshotWindow.sh`) uses only the Python standard library.
