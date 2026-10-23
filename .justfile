set shell := ["pwsh", "-NoLogo", "-Command"]

dist:
	Ahk2Exe /in "FlameshotWindow.ahk" /icon "assets/icon.ico" /out "FlameshotWindow.exe"

clean:
	rm FlameshotWindow.exe
