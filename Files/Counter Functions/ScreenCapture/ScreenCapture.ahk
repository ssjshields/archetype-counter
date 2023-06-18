; #####################################################
; #   ARCHETYPE COUNTER - ScreenCapture (PrintWindow) #
; #####################################################
; -----------------------------------------------------
DetectHiddenWindows, On
; -----------------------------------------------------
PID:=DllCall("GetCurrentProcessId") 
for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where name = 'Autohotkey.exe' and processID  <> " PID )
   process, close, % process.ProcessId
; -----------------------------------------------------
#NoTrayIcon
#SingleInstance Ignore
#NoEnv
#include %A_ScriptDir%/Gdip_All.ahk
SetBatchLines, -1
; -----------------------------------------------------
pToken := Gdip_Startup()
hwnd := WinExist("ahk_class GLFW30")
pBitmap := Gdip_BitmapFromHWND(hwnd)
Gdip_GetDimensions(pBitmap, w, h)
pBitmap := Gdip_CropImage(pBitmap, x, y, w, h)
Gdip_SaveBitmapToFile(pBitmap, "Counter Functions\ImageMagick\ArchetypeScreenshot.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
; -----------------------------------------------------
Return



