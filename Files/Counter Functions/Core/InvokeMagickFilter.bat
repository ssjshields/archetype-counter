<# : InvokeMagickFilter - Solution for Archetype Counter
@echo off
Setlocal
cd %~dp0
powershell -NoLogo -Noprofile -Executionpolicy Bypass -WindowStyle Hidden -Command "Invoke-Expression $([System.IO.File]::ReadAllText('%~f0'))"
Endlocal
goto:eof
#>

cmd.exe /c "magick ArchetypeScreenshotEncounter.bmp ^ ( +clone -colorspace HSL -channel S -separate -negate -fill black -fuzz 99.9% -opaque black ) ^ -alpha off -compose copy_opacity -composite ^ -background black -alpha remove -alpha off ArchetypeScreenshotMagick.bmp"
