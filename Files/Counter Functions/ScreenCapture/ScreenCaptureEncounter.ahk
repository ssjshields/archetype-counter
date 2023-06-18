; #####################################################
; #   ARCHETYPE COUNTER - ScreenCapture (PrintWindow) #
; #                 - For Encounters -                #
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
; -----------------------------------------------------
BattleWidth := Ceil((w - 15.999)*0.7)
if (BattleWidth < 760)
BattleWidth := 760
XCropValue := Floor((w - 15.999 - BattleWidth) / 2)
WCropValue := BattleWidth
; -----------------------------------------------------
pBitmap := Gdip_CropImage(pBitmap, XCropValue, 50, WCropValue, 300)
Gdip_SaveBitmapToFile(pBitmap, "Counter Functions\ImageMagick\ArchetypeScreenshotEncounter.png")
Gdip_DisposeImage(pBitmap)
Gdip_Shutdown(pToken)
; -----------------------------------------------------
Return