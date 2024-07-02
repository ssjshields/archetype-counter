<# :
@echo off
Setlocal
cd %~dp0
Powershell -NoLogo -Noprofile -Executionpolicy Bypass -WindowStyle Hidden -Command "Invoke-Expression $([System.IO.File]::ReadAllText('%~f0'))"
Endlocal
goto:eof
#>

######################################
# ---------------------------------- #
# --------- Archetype Team --------- #
# ---------------------------------- #
# -------- Archetype Counter ------- #
# -------- Version: 4.0.0.2 -------- #
# ---------------------------------- #
# ---------------------------------- #
#                                    #
# -------------                      #
# - Synopsis - | ------------------- #
# -------------                      #
#                                    #
# PowerShell WinForm script for the  #
# online video game PokeMMO.         #
#                                    #
# -----------------                  #
#  - Requirement - | --------------- #
# -----------------                  #
#                                    #
# OS:                                #
# • Windows 10 Version 1809 or later #
# • Windows 11                       #
#                                    #
# PowerShell:                        #
# • 5.1                              #
#                                    #
# .Net Framework:                    #
# • 4.7.2 or later                   #
#                                    #
# ---------------------              #
#  - Technology Used - | ----------- #
# ---------------------              #
#                                    #
# PowerShell & WinForms/WPF          #
# Tesseract OCR (Windows)            #
# ImageMagick                        #
# Pngquant                           #
# DarkNet                            #
# Ookii.Dialogs.Winforms             #
# BurntToast                         #
# VistaMenu                          #
#                                    #
# ---------------                    #
#  - Author(s) - | ----------------- #
# ---------------                    #
#                                    #
# @AnonymousPoke (Lead Dev)          #
# @realmadrid1809 (Advanced Logic)   #
# @nurver (Initial concepts)         #
#                                    #
# ---------------------------------- #
# ---------------------------------- #
# --------- Archetype Team --------- #
# ---------------------------------- #
######################################

###################################
# ------------------------------- #
# --- RUNNING SCRIPT LOCATION --- # 
# ------------------------------- #
###################################

# Grabs current working directory/location (For Archetype Counter)
$Global:CounterWorkingDir = $PWD

# Resets counter working directory to the PokeMMO main root directory & adds as variable
Set-Location ..\..; Set-Location ..\..; $PokeMMOWorkingDir = $PWD

# Resets the working directory back to the counter .bat file (Original location)
Set-Location $Global:CounterWorkingDir

#######################
# ------------------- #
# --- CONSOLE LOG --- # 
# ------------------- #
#######################

# Clears the console window (Anything before)
Clear

# Adds initial text header in console log
Write-Host '
  ###################################
  # ------------------------------- #
  # --- Archetype Counter Debug --- #
  # ------------------------------- #
  ###################################
'

############################
# ------------------------ #
# --- ERROR PREFERENCE --- # 
# ------------------------ #
############################

# Sets the error action for the entire script to 'Continue'
$ErrorActionPreference = 'Continue'

##########################
# ---------------------- #
# --- INITIAL CHECKS --- #
# ---------------------- #
##########################

# Closes any other PowerShell & CMD instance down (Just in case the counter has been launched more than once)
(Get-Process "Powershell", "cmd" | Where-Object { $_.ID -ne $PID } | Stop-Process -Force) 2>$null

# Unblock all files in the counter directory
$SetCounterFileBlockCheck = "$Global:CounterWorkingDir\stored\Config_Settings.txt"; $GetCounterFileBlockCheck = [IO.File]::ReadAllLines("$SetCounterFileBlockCheck"); $CounterFileBlockCheck = $GetCounterFileBlockCheck -match "Files_Unblocked="; $CounterFileBlockCheck = $CounterFileBlockCheck -replace "Files_Unblocked=", ""
if ($CounterFileBlockCheck -match "False") { Get-ChildItem $Global:CounterWorkingDir -recurse | Unblock-File; $GetCounterFileBlockCheck = $GetCounterFileBlockCheck -replace "Files_Unblocked=.*", "Files_Unblocked=True"; [System.IO.File]::WriteAllLines("$Global:CounterWorkingDir\stored\Config_Settings.txt", $GetCounterFileBlockCheck) }

# Check if there are any folders within the "Backup" directory
$CheckBackupFolders = Get-ChildItem -Path "$Global:CounterWorkingDir\stored\backup" -Directory
if (!($CheckBackupFolders.Count -gt 0)) { $CounterFirstTime = $true } else { $CounterFirstTime = $false }

##################################
# ------------------------------ #
# --- PERFORMANCE / CLEANING --- #
# ------------------------------ #
##################################

# Clears PowerShell console history file (Helps with performance)
(Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\*" -Recurse -Force) 2>$null

##########################
# ---------------------- #
# --- GITHUB CLEANUP --- #
# ---------------------- #
##########################

# Checks/Removes out "placeholder.txt" files needed for Github
$Placeholder1 = "$Global:CounterWorkingDir\debug\placeholder.txt"; $Placeholder2 = "$Global:CounterWorkingDir\stored\backup\placeholder.txt"; if ([System.IO.File]::Exists($Placeholder1)) { Remove-item $Placeholder1 }; if ([System.IO.File]::Exists($Placeholder2)) { Remove-item $Placeholder2 }

########################
# -------------------- #
# --- DAILY BACKUP --- #
# -------------------- #
########################

# Creates a daily backup (If one has not been created yet)
$TodaysDate = (Get-Date).ToString('MM-dd-yyyy')
if (!(Test-Path -Path "$Global:CounterWorkingDir\stored\backup\$TodaysDate")) { (New-Item -Path "$Global:CounterWorkingDir\stored\backup" -Type Directory -Name $TodaysDate) > $null; (Get-ChildItem "$Global:CounterWorkingDir\stored" -Directory | Where-Object { $_.Name -like '*Profile*' } | Copy-Item -Destination "$Global:CounterWorkingDir\stored\backup\$TodaysDate" -Recurse -Force) > $null }

###############################
# --------------------------- #
# --- REQUIRED ASSEMBLIES --- #
# --------------------------- #
###############################
 
# All assemblies loaded for counter script
Add-Type -AssemblyName System.Windows.Forms, System.Drawing, PresentationCore, Presentationframework, WindowsFormsIntegration, UIAutomationClient 2>$null
[Void][System.Windows.Forms.Application]::EnableVisualStyles()
[Void][System.Windows.Forms.Application]::SetCompatibleTextRenderingDefault($false)

################################
# ---------------------------- #
# --- SET COUNTER SHORTCUT --- #
# ---------------------------- #
################################

# Removes original Archetype shortcut & creates a new one (So users can pin to start menu or taskbar)
Set-Location ..\; $CurrentACDirectoryName = Split-Path -Path ($PWD) -Leaf; Set-Location $Global:CounterWorkingDir
$ShortcutFile = "$PokeMMOWorkingDir\data\mods\$CurrentACDirectoryName\Archetype Counter.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.WorkingDirectory = "$PokeMMOWorkingDir\data\mods\$CurrentACDirectoryName"
$Shortcut.IconLocation = "$PokeMMOWorkingDir\data\mods\$CurrentACDirectoryName\src\icons\Archetype.ico"
$Shortcut.Save()

########################################
# ------------------------------------ #
# --- C# PORTED CODE & DLL IMPORTS --- #
# ------------------------------------ #
########################################

# Adds/Loads the external libraries that help fuel the counter.
Add-Type -Path "$Global:CounterWorkingDir\lib\DarkNet-2.3.0\DarkNet.dll"
Add-Type -Path "$Global:CounterWorkingDir\lib\VistaMenu-1.9\VistaMenu.dll"
Add-Type -Path "$Global:CounterWorkingDir\lib\Ookii.Dialogs.Winforms-1.2.0\Ookii.Dialogs.WinForms.dll"
"$Global:CounterWorkingDir\lib\BurntToast-0.8.5\*" | gci -include '*.psm1','*.psd1' | Import-Module

# Adds/Loads port from user32.dll & kernel32.dll to work in PowerShell (DPI Awareness & Toggle Console)
Add-Type @'
using System;
using System.ComponentModel;
using System.Runtime.InteropServices;

// Allows ability to set application to be DPI Aware
public class DPIAware {
    public static readonly IntPtr UNAWARE              = (IntPtr) (-1);
    public static readonly IntPtr SYSTEM_AWARE         = (IntPtr) (-2);
    public static readonly IntPtr PER_MONITOR_AWARE    = (IntPtr) (-3);
    public static readonly IntPtr PER_MONITOR_AWARE_V2 = (IntPtr) (-4);
    public static readonly IntPtr UNAWARE_GDISCALED    = (IntPtr) (-5);

    [DllImport("user32.dll", EntryPoint = "SetProcessDpiAwarenessContext", SetLastError = true)]
    private static extern bool NativeSetProcessDpiAwarenessContext(IntPtr Value);

    public static void SetProcessDpiAwarenessContext(IntPtr Value) {
        if (!NativeSetProcessDpiAwarenessContext(Value)) {
            throw new Win32Exception();
        }
    }
}

// Allows ability to grab console window to be hidden or not
public class GrabConsole {
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
        
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
}
'@

# Adds/Loads port from user32.dll & kernel32.dll to work in PowerShell (Removing Cmd/PowerShell top-right standard butons)
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public static class WinAPI
{
    public const int GWL_STYLE = -16;
    public const int WS_SYSMENU = 0x00080000;

    [DllImport("user32.dll", SetLastError = true)]
    public static extern int GetWindowLong(IntPtr hWnd, int nIndex);

    [DllImport("user32.dll", SetLastError = true)]
    public static extern int SetWindowLong(IntPtr hWnd, int nIndex, int dwNewLong);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr GetConsoleWindow();
}
"@

# Sets current porcess to be DPI Aware - PER_MONITOR_AWARE_V2 (Introduced in Windows 10 version 1703)
[DPIAware]::SetProcessDpiAwarenessContext([DPIAware]::PER_MONITOR_AWARE_V2)

# Sets the "debug console" window by removing the standard window border buttons (top-right)
$consoleWindowHandle = [WinAPI]::GetConsoleWindow(); $currentStyle = [WinAPI]::GetWindowLong($consoleWindowHandle, [WinAPI]::GWL_STYLE); $newStyle = $currentStyle -band (-bnot [WinAPI]::WS_SYSMENU); [WinAPI]::SetWindowLong($consoleWindowHandle, [WinAPI]::GWL_STYLE, $newStyle) > $null

# Icon Size & Color from Icons8 (20x20 / #313131)

#################################################
# --------------------------------------------- #
# --- WINFORM SYSTRAY FUNCTIONS & VARIABLES --- #
# --------------------------------------------- #
#################################################

# Creates all variables for the script to function
Function LoadExternalVariables {

    # Loads hunt string from external source (Config_ProfileState) 
    $SetProfileState = "$Global:CounterWorkingDir\stored\Config_ProfileState.txt"
    $GetProfileState = [IO.File]::ReadAllLines("$SetProfileState")
    $GetCurrentProfile = $GetProfileState -match "Current_Hunt_Profile="; $GetCurrentProfile = $GetCurrentProfile -replace "Current_Hunt_Profile=", ""
    $GetProfile = $GetProfileState -match "Current_Hunt_Profile="; $GetProfile = $GetProfile -replace "Current_Hunt_Profile=", ""
    $CheckProfile1 = $GetProfileState -match "Hunt_Profile_1="; $CheckProfile1 = $CheckProfile1 -replace "Hunt_Profile_1=", ""
    $CheckProfile2 = $GetProfileState -match "Hunt_Profile_2="; $CheckProfile2 = $CheckProfile2 -replace "Hunt_Profile_2=", ""
    $CheckProfile3 = $GetProfileState -match "Hunt_Profile_3="; $CheckProfile3 = $CheckProfile3 -replace "Hunt_Profile_3=", ""
    $CheckProfile4 = $GetProfileState -match "Hunt_Profile_4="; $CheckProfile4 = $CheckProfile4 -replace "Hunt_Profile_4=", ""
    $CheckProfile5 = $GetProfileState -match "Hunt_Profile_5="; $CheckProfile5 = $CheckProfile5 -replace "Hunt_Profile_5=", ""
    $CheckProfile6 = $GetProfileState -match "Hunt_Profile_6="; $CheckProfile6 = $CheckProfile6 -replace "Hunt_Profile_6=", ""
    $CheckProfile7 = $GetProfileState -match "Hunt_Profile_7="; $CheckProfile7 = $CheckProfile7 -replace "Hunt_Profile_7=", ""
    $CheckProfile8 = $GetProfileState -match "Hunt_Profile_8="; $CheckProfile8 = $CheckProfile8 -replace "Hunt_Profile_8=", ""
    $CheckProfile9 = $GetProfileState -match "Hunt_Profile_9="; $CheckProfile9 = $CheckProfile9 -replace "Hunt_Profile_9=", ""
    $CheckProfile10 = $GetProfileState -match "Hunt_Profile_10="; $CheckProfile10 = $CheckProfile10 -replace "Hunt_Profile_10=", ""
    if ($GetProfile -match $CheckProfile1) { $GetProfile = 'Profile1' } elseif ($GetProfile -match $CheckProfile2) { $GetProfile = 'Profile2' } elseif ($GetProfile -match $CheckProfile3) { $GetProfile = 'Profile3' } elseif ($GetProfile -match $CheckProfile4) { $GetProfile = 'Profile4' } elseif ($GetProfile -match $CheckProfile5) { $GetProfile = 'Profile5' } elseif ($GetProfile -match $CheckProfile6) { $GetProfile = 'Profile6' } elseif ($GetProfile -match $CheckProfile7) { $GetProfile = 'Profile7' } elseif ($GetProfile -match $CheckProfile8) { $GetProfile = 'Profile8' } elseif ($GetProfile -match $CheckProfile9) { $GetProfile = 'Profile9' } elseif ($GetProfile -match $CheckProfile10) { $GetProfile = 'Profile10' } 

    # Loads values from external source (Config_Settings)
    $SetConfigSettings = "$Global:CounterWorkingDir\stored\Config_Settings.txt"
    $GetConfigSettings = [IO.File]::ReadAllLines("$SetConfigSettings")
    $PictureMode = $GetConfigSettings -match "Picture_Mode="; $PictureMode = $PictureMode -replace "Picture_Mode=", ""
    $ThemeMode = $GetConfigSettings -match "Theme_Mode="; $ThemeMode = $ThemeMode -replace "Theme_Mode=", ""
    $ChineseMode = $GetConfigSettings -match "Chinese_Mode="; $ChineseMode = $ChineseMode -replace "Chinese_Mode=", ""
    $NotifyMode = $GetConfigSettings -match "Notify_Mode="; $NotifyMode = $NotifyMode -replace "Notify_Mode=", ""
    $SpriteMode = $GetConfigSettings -match "Sprite_Mode="; $SpriteMode = $SpriteMode -replace "Sprite_Mode=", ""
    $SortingMode = $GetConfigSettings -match "Sorting_Mode="; $SortingMode = $SortingMode -replace "Sorting_Mode=", ""
    $OverlayMode = $GetConfigSettings -match "Overlay_Mode="; $OverlayMode = $OverlayMode -replace "Overlay_Mode=", ""
    $OverlayLeft = $GetConfigSettings -match "Overlay_Left="; $OverlayLeft = $OverlayLeft -replace "Overlay_Left=", ""
    $OverlayTop = $GetConfigSettings -match "Overlay_Top="; $OverlayTop = $OverlayTop -replace "Overlay_Top=", ""
    $NotifyMilestone = $GetConfigSettings -match "Notify_Milestone="; $NotifyMilestone = $NotifyMilestone -replace "Notify_Milestone=", ""; $NotifyMilestone = $NotifyMilestone -join '-'
    $OpenPokeMMO = $GetConfigSettings -match "Open_PokeMMO="; $OpenPokeMMO = $OpenPokeMMO -replace "Open_PokeMMO=", ""
    $ClosePokeMMO = $GetConfigSettings -match "Close_PokeMMO="; $ClosePokeMMO = $ClosePokeMMO -replace "Close_PokeMMO=", ""
    $ShowFailedScans = $GetConfigSettings -match "Show_Failed_Scans="; $ShowFailedScans = $ShowFailedScans -replace "Show_Failed_Scans=", ""
    $ToastNotificationDialog = $GetConfigSettings -match "Toast_Notification_Dialog="; $ToastNotificationDialog = $ToastNotificationDialog -replace "Toast_Notification_Dialog=", ""
    $ReShadeAlertDialog = $GetConfigSettings -match "ReShade_Alert_Dialog="; $ReShadeAlertDialog = $ReShadeAlertDialog -replace "ReShade_Alert_Dialog=", ""
    $ACTrayEncounterSymbol = $GetConfigSettings -match "Encounter_Symbol="; $ACTrayEncounterSymbol = $ACTrayEncounterSymbol -replace "Encounter_Symbol=", ""
    $ACTrayEggSymbol = $GetConfigSettings -match "Egg_Symbol="; $ACTrayEggSymbol = $ACTrayEggSymbol -replace "Egg_Symbol=", ""
    $ACTrayFossilSymbol = $GetConfigSettings -match "Fossil_Symbol="; $ACTrayFossilSymbol = $ACTrayFossilSymbol -replace "Fossil_Symbol=", ""

    # Loads values from external source (Config_Profile?)
    $SetConfigProfile = "$Global:CounterWorkingDir\stored\$GetProfile\Config_$GetProfile.txt"
    $GetConfigProfile  = [IO.File]::ReadAllLines("$SetConfigProfile")
    $EncounteredCount = $GetConfigProfile -match "Encountered_Count="; $EncounteredCount = $EncounteredCount -replace "Encountered_Count=", ""; $EncounteredCount = $EncounteredCount -join '-'
    $FossilCount = $GetConfigProfile -match "Fossil_Count="; $FossilCount = $FossilCount -replace "Fossil_Count=", ""; $FossilCount = $FossilCount -join '-'
    $EggCount = $GetConfigProfile -match "Egg_Count="; $EggCount = $EggCount -replace "Egg_Count=", ""; $EggCount = $EggCount -join '-'
    $AlphaCount = $GetConfigProfile -match "Alpha_Count="; $AlphaCount = $AlphaCount -replace "Alpha_Count=", ""; $AlphaCount = $AlphaCount -join '-'
    $LegendaryCount = $GetConfigProfile -match "Legendary_Count="; $LegendaryCount = $LegendaryCount -replace "Legendary_Count=", ""; $LegendaryCount = $LegendaryCount -join '-'
    $ShinyCount = $GetConfigProfile -match "Shiny_Count="; $ShinyCount = $ShinyCount -replace "Shiny_Count=", ""; $ShinyCount = $ShinyCount -join '-'
    $Global:SingleBattle = $GetConfigProfile -match "Single_Battle="; $Global:SingleBattle = $Global:SingleBattle -replace "Single_Battle=", ""; $Global:SingleBattle = $Global:SingleBattle -join '-'
    $Global:DoubleBattle = $GetConfigProfile -match "Double_Battle="; $Global:DoubleBattle = $Global:DoubleBattle -replace "Double_Battle=", ""; $Global:DoubleBattle = $Global:DoubleBattle -join '-'
    $Global:TripleBattle = $GetConfigProfile -match "Triple_Battle="; $Global:TripleBattle = $Global:TripleBattle -replace "Triple_Battle=", ""; $Global:TripleBattle = $Global:TripleBattle -join '-'
    $Global:HordeBattle = $GetConfigProfile -match "Horde_Battle="; $Global:HordeBattle = $Global:HordeBattle -replace "Horde_Battle=", ""; $Global:HordeBattle = $Global:HordeBattle -join '-'

    # Loads values from from external source (PokeMMO main properties file)
    $SetMainProperties = "$PokeMMOWorkingDir\config\main.properties"
    $GetMainProperties = [IO.File]::ReadAllLines("$SetMainProperties")

    # Loads values from from external source (Config_Profile?_Encountered)
    $EncounteredCurrentProfile = "$Global:CounterWorkingDir\stored\$GetProfile\Config_$($GetProfile)_Encountered.txt"

}

# Loads all of the stored variables for current profile and global settings of the counter
. LoadExternalVariables

# Check counter theme mode - Auto / Light / Dark (DarkNet for WinForms ContextMenu - 0 = Auto / 1 = Light / 2 = Dark)
if ($ThemeMode -match 'Auto') { if ([Dark.Net.DarkNet]::Instance.UserDefaultAppThemeIsDark -eq $true) { [Dark.Net.DarkNet]::Instance.SetCurrentProcessTheme(2); $ThemeMode = 'Dark'; $ThemeModeAuto = 'Auto' } else { [Dark.Net.DarkNet]::Instance.SetCurrentProcessTheme(1); $ThemeMode = 'Light'; $ThemeModeAuto = 'Auto' } } elseif ($ThemeMode -match 'Light') { [Dark.Net.DarkNet]::Instance.SetCurrentProcessTheme(1); $ThemeModeAuto = 'Light' } else { [Dark.Net.DarkNet]::Instance.SetCurrentProcessTheme(2); $ThemeModeAuto = 'Dark' }

# Properly write to settings Config & restarts counter - Function
Function CounterConfigRestart { Set-Location $Global:CounterWorkingDir; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings); $GetConfigSettings = $GetConfigSettings -replace "Overlay_Left=.*", "Overlay_Left=$($ArchetypeCounterOverlay.Left)" -replace "Overlay_Top=.*", "Overlay_Top=$($ArchetypeCounterOverlay.Top)"; $ArchetypeCounterSystray.Visible = $false; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings); [System.Threading.Thread]::Sleep(25); Start-Process "$Global:CounterWorkingDir\ArchetypeCounter.bat" -NoNewWindow -Wait }

# Properly write to profile Config & restarts counter - Function
Function CounterProfileRestart { Set-Location $Global:CounterWorkingDir; [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile); $GetConfigSettings = $GetConfigSettings -replace "Overlay_Left=.*", "Overlay_Left=$($ArchetypeCounterOverlay.Left)" -replace "Overlay_Top=.*", "Overlay_Top=$($ArchetypeCounterOverlay.Top)"; $ArchetypeCounterSystray.Visible = $false; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings); [System.Threading.Thread]::Sleep(25); Start-Process "$Global:CounterWorkingDir\ArchetypeCounter.bat" -NoNewWindow -Wait }

# Properly write to hunt profile Config & restarts counter - Function
Function CounterHuntRestart { Set-Location $Global:CounterWorkingDir; [IO.File]::WriteAllLines($SetProfileState, $GetProfileState); $GetConfigSettings = $GetConfigSettings -replace "Overlay_Left=.*", "Overlay_Left=$($ArchetypeCounterOverlay.Left)" -replace "Overlay_Top=.*", "Overlay_Top=$($ArchetypeCounterOverlay.Top)"; $ArchetypeCounterSystray.Visible = $false; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings); [System.Threading.Thread]::Sleep(25); Start-Process "$Global:CounterWorkingDir\ArchetypeCounter.bat" -NoNewWindow -Wait }

# Adds Pokemon dynamically to couner menu from encountered text file
Function AddDynamicPokemonList { Set-Location $Global:CounterWorkingDir; $SetEncounteredListItems = "$Global:CounterWorkingDir\stored\$GetProfile\Config_$($GetProfile)_Encountered.txt"; $GetEncounteredListItems = [IO.File]::ReadAllLines($SetEncounteredListItems) | Select-Object -First 25; $GetEncounteredListItems | ForEach-Object { $GetEncounteredListItem = New-Object System.Windows.Forms.MenuItem; $GetEncounteredListItem.Text = $_ -replace '\s',''; $EscapedSpecialChar = [regex]::Escape('('); $GetEncounteredName = $GetEncounteredListItem.Text; $PokemonImageID = $GetEncounteredName -replace "$escapedSpecialChar.*", "" -replace "[^0-9]", ""; New-Variable -Name ('MenuItem' + "_" + $GetEncounteredListItem.Text) -Value $GetEncounteredListItem; New-Variable -Name ('MenuImage' + "_" + $GetEncounteredListItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\sprites\$SpriteMode\$($SpriteMode)_EX\$PokemonImageID.png")); $MenuItem_GetEncounteredListItem = (Get-Variable -Name ('MenuItem' + '_' + $($GetEncounteredListItem.Text))).Value; $MenuImage_GetEncounteredListItem = (Get-Variable -Name ('MenuImage' + '_' + $($GetEncounteredListItem.Text))).Value; ((Get-Variable -Name ('MenuItem' + '_' + $($GetEncounteredListItem.Text))).Value).add_Click({ $PokemonMenuItemTextSelection = $this.Text; $PokemonMenuItemTextSelectionNumber = ([regex]::Matches($PokemonMenuItemTextSelection, "\((\d+)\)").Groups[1].Value) -join ''; $PokemonMenuItemTextSelectionTrim = $PokemonMenuItemTextSelection -replace '\(.*$', ''; $PokemonMenuItemTextSelectionTrim = $PokemonMenuItemTextSelectionTrim.TrimEnd(); $SetEncounteredCurrentProfile = "$Global:CounterWorkingDir\stored\$GetProfile\Config_$($GetProfile)_Encountered.txt"; $GetEncounteredCurrentProfile = [IO.File]::ReadAllLines("$SetEncounteredCurrentProfile"); . SetDialogTransparentBackground; $InputPokeMenuItemDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputPokeMenuItemDialog.WindowTitle = 'Archetype Counter'; $InputPokeMenuItemDialog.MainInstruction = 'Custom Pokémon Count'; $InputPokeMenuItemDialog.Content = "Enter the total number value count for $PokemonMenuItemTextSelectionTrim.`n`n- Example: 267"; $InputPokeMenuItemDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputPokeMenuItemDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInput = $InputPokeMenuItemDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInput -eq "") { $IDInput = '0' }; $GetEncounteredCurrentProfile = $GetEncounteredCurrentProfile -replace [regex]::escape("$PokemonMenuItemTextSelection"), "$PokemonMenuItemTextSelectionTrim ($IDInput)"; . RemoveDialogTransparentBackground; [IO.File]::WriteAllLines($SetEncounteredCurrentProfile, $GetEncounteredCurrentProfile); [System.Threading.Thread]::Sleep(25); Start-Process "$Global:CounterWorkingDir\ArchetypeCounter.bat" -NoNewWindow -Wait }; . RemoveDialogTransparentBackground }); $MenuItem_Encountered.MenuItems.Add($GetEncounteredListItem) 2>$null; $ArchetypeVistaMenu.SetImage($MenuItem_GetEncounteredListItem, $MenuImage_GetEncounteredListItem); $GetEncounteredListItem.Text = $_ } }

# Adds the 2 menuitems that allow adding custom pokemon and resetting encountered count
Function AddDynamicEncounteredButton { Set-Location $Global:CounterWorkingDir; $ACEncounteredItems = @("-", "Encountered Type Count", "-", "Add Custom Encountered Count", "Reset Encountered Count"); $ACEncounteredItems | ForEach-Object { $ACEncounteredItem = New-Object System.Windows.Forms.MenuItem; $ACEncounteredItem.Text = $_ -replace '\s',''; if ($ACEncounteredItem.Text -notmatch '-') { New-Variable -Name ('MenuItem' + "_" + $ACEncounteredItem.Text) -Value $ACEncounteredItem; New-Variable -Name ('MenuImage' + "_" + $ACEncounteredItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACEncounteredItem.Text).png")); $MenuItem_ACEncounteredItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACEncounteredItem.Text))).Value; $MenuImage_ACEncounteredItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACEncounteredItem.Text))).Value; }; $MenuItem_Encountered.MenuItems.Add($ACEncounteredItem) 2>$null; if ($ACEncounteredItem.Text -notmatch '-') { $ArchetypeVistaMenu.SetImage($MenuItem_ACEncounteredItem, $MenuImage_ACEncounteredItem) }; $ACEncounteredItem.Text = $_ }; $MenuItem_AddCustomEncounteredCount.Text = 'Change Encountered Count'; $MenuItem_ResetEncounteredCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogCurrentEncountered = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogCurrentEncountered.WindowTitle = "Archetype Counter"; $TaskDialogCurrentEncountered.ButtonStyle = 'CommandLinks'; $TaskDialogCurrentEncountered.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogCurrentEncountered.MainInstruction = "Reset Encountered Count"; $TaskDialogCurrentEncountered.Content = "Do you want to reset the current encountered count?"; $TaskDialogCurrentEncountered.Footer = "Current Hunt Profile: $GetCurrentProfile"; $TaskDialogCurrentEncountered.FooterIcon = 'Information'; $TaskDialogCurrentEncountered.AllowDialogCancellation = $true; $TaskDialogCurrentEncountered.Buttons.Add('Reset'); $TaskDialogCurrentEncountered.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentEncounteredResults = $TaskDialogCurrentEncountered.ShowDialog($ArchetypeCounterForm); If ($TDCurrentEncounteredResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Encountered_Count=.*", "Encountered_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground }); $MenuItem_AddCustomEncounteredCount.add_Click({ . SetDialogTransparentBackground; $InputEncounteredDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputEncounteredDialog.WindowTitle = 'Archetype Counter'; $InputEncounteredDialog.MainInstruction = 'Custom Encountered Count'; $InputEncounteredDialog.Content = "Enter the total number value for the encountered count.`n`n- Example: 10267"; $InputEncounteredDialog.Input = ''; $CheckDialogSelect = $InputEncounteredDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInput = $InputEncounteredDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInput -eq "") { $IDInput = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Encountered_Count=.*", "Encountered_Count=$IDInput"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; RemoveDialogTransparentBackground }); $ACEncounteredTypeItems = @("Single Battle", "Double Battle", "Triple Battle", "Horde Battle"); $ACEncounteredTypeItems | ForEach-Object { $ACEncounteredTypeItem = New-Object System.Windows.Forms.MenuItem; $ACEncounteredTypeItem.Text = $_ -replace '\s',''; if ($ACEncounteredTypeItem.Text -notmatch '-') { New-Variable -Name ('MenuItem' + "_" + $ACEncounteredTypeItem.Text) -Value $ACEncounteredTypeItem; New-Variable -Name ('MenuImage' + "_" + $ACEncounteredTypeItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACEncounteredTypeItem.Text).png")); $MenuItem_ACEncounteredTypeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACEncounteredTypeItem.Text))).Value; $MenuImage_ACEncounteredTypeItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACEncounteredTypeItem.Text))).Value }; $MenuItem_EncounteredTypeCount.MenuItems.Add($ACEncounteredTypeItem) 2>$null; $ACEncounteredTypeItem.Text = $_; $ArchetypeVistaMenu.SetImage($MenuItem_ACEncounteredTypeItem, $MenuImage_ACEncounteredTypeItem) }; $MenuItem_SingleBattle.Text = "Single Battle: $Global:SingleBattle"; $MenuItem_DoubleBattle.Text = "Double Battle: $Global:DoubleBattle"; $MenuItem_TripleBattle.Text = "Triple Battle: $Global:TripleBattle"; $MenuItem_HordeBattle.Text = "Horde Battle: $Global:HordeBattle" }

# Checks for PokeMMO Process (From UIAutomationClient)
Function CheckPokeMMOProcess { $AERootElement = [System.Windows.Automation.AutomationElement]::RootElement; $WindowAT = $AERootElement.FindFirst([System.Windows.Automation.TreeScope]::Children,(New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ClassNameProperty, "GLFW30"))); $Global:PokeMMO_hwnd = $WindowAT.Current.NativeWindowHandle }

# Define a custom sorting function - Based on digits by Pokdex number
Function CustomSortPokedexNumber { param ($line); $digitsMatch = [regex]::Match($line, '#\d{1,3}'); if ($digitsMatch.Success) { $digits = $digitsMatch.Value -replace '#', ''; $paddedDigits = $digits.PadLeft(3, '0'); return [int]$paddedDigits }; return 0 }

# Define a custom sorting function - Based on digits in pokemon count
Function CustomSortPokemonCount { param ($line); $digitsMatch = [regex]::Match($line, '\(\d{1,7}\)'); if ($digitsMatch.Success) { $digits = $digitsMatch.Value -replace '\(|\)', ''; $paddedDigits = $digits.PadLeft(7, '0'); return [int]$paddedDigits }; return 0 }

# Define a custom sorting function - Based pokemon name for alphabetical order
Function CustomSortPokemonName { param ($line); $cleanedLine = $line -replace '[^a-zA-Z]', ''; return $cleanedLine.ToLower() }

# Creates the fake UAC dialog background
Function SetDialogTransparentBackground { $ArchetypeCounterForm.Opacity = 0.6; $ArchetypeCounterForm.Visible = $true; $ArchetypeCounterForm.WindowState = 'Maximized' }

# Removes the fake UAC dialog background
Function RemoveDialogTransparentBackground { $ArchetypeCounterForm.WindowState = 'Minimized'; $ArchetypeCounterForm.Visible = $false; $ArchetypeCounterForm.Opacity = 0 }

# Registers the Archetype Counter into the registry as an official app so it can be used for Toast Notifications
Function Register-NotificationApp { [CmdletBinding()]Param([Parameter(Mandatory=$true)]$AppID,[Parameter(Mandatory=$true)]$AppDisplayName,[Parameter(Mandatory=$false)][int]$ShowInSettings=0,[Parameter(Mandatory=$false)]$IconPath)$CurrentUserRegPath="HKCU:\Software\Classes\AppUserModelId";If(!(Test-Path $CurrentUserRegPath)){New-Item -Path $CurrentUserRegPath -Force};$RegPath=Join-Path -Path $CurrentUserRegPath -ChildPath $AppID;If(!(Test-Path $RegPath)){$null=New-Item -Path $CurrentUserRegPath -Name $AppID -Force};$DisplayName=(Get-ItemProperty -Path $RegPath -Name DisplayName -ErrorAction SilentlyContinue).DisplayName;If($DisplayName -ne $AppDisplayName){$null=New-ItemProperty -Path $RegPath -Name DisplayName -Value $AppDisplayName -PropertyType String -Force};$ShowInSettingsValue=(Get-ItemProperty -Path $RegPath -Name ShowInSettings -ErrorAction SilentlyContinue).ShowInSettings;If($ShowInSettingsValue -ne $ShowInSettings){$null=New-ItemProperty -Path $RegPath -Name ShowInSettings -Value $ShowInSettings -PropertyType DWORD -Force};If($IconPath -and (Test-Path $IconPath -PathType Leaf)){$null=New-ItemProperty -Path $RegPath -Name IconUri -Value $IconPath -PropertyType String -Force} }

# Register Archetype Counter to current user registry hive for toast notifications (Path: HKCU:\Software\Classes\AppUserModelId)
Register-NotificationApp -AppID "Archetype.PokeMMO.ArchetypeCounter!App" -AppDisplayName "Archetype Counter" -IconPath "$Global:CounterWorkingDir\icons\Archetype.ico" 2>$null

# System Tray icons & Context Menu Images
$ArchetypeCounterSystrayIcon = New-Object System.Drawing.Icon ("$Global:CounterWorkingDir\icons\Archetype.ico")
$ArchetypeCounterSystrayIconStartup = New-Object System.Drawing.Icon ("$Global:CounterWorkingDir\icons\ArchetypeStartup.ico")
$ArchetypeCounterSystrayIconBusy = New-Object System.Drawing.Icon ("$Global:CounterWorkingDir\icons\ArchetypeBusy.ico")
$ArchetypeCounterSystrayIconIdle = New-Object System.Drawing.Icon ("$Global:CounterWorkingDir\icons\ArchetypeIdle.ico")
$ShinyDialogIcon = New-Object System.Drawing.Icon ("$Global:CounterWorkingDir\icons\Shiny.ico")
$MenuImage_RadioCheckEmpty = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\radiocheckempty.png")
$MenuImage_RadioCheckFilled = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\radiocheckfilled.png")
$MenuImage_ResetCurrentHunt = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\resetcurrenthunt.png")
$MenuImage_ResetAllHunts = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\resetallhunts.png")
$MenuImage_RenameCurrentHunt = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\renamecurrenthunt.png")
$MenuImage_SetNotifyMilestone = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\setnotifymilestone.png")
$MenuImage_OpenOverlaySettings = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\openoverlaysettings.png")
$MenuImage_Dot = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\dot.png")
$MenuImage_Add = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\add.png")
$MenuImage_Reset = [System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\reset.png")

# Counter & Context Menu variables
$OSName = (Get-WmiObject Win32_OperatingSystem).Caption; $OSName = $OSName -replace 'Microsoft ', ''
$PSVersionMajor = $PSVersionTable.PSVersion.Major; $PSVersionMinor = $PSVersionTable.PSVersion.Minor; $PSVersionInfo = "$PSVersionMajor" + '.' + "$PSVersionMinor"
$NetFrameworkVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full").Version
$WindowsVersion = (Get-WmiObject Win32_OperatingSystem).Caption
$IsToastNotificationEnabled = (Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications' -Name ToastEnabled).ToastEnabled 2>$null

###############################
# --------------------------- #
# --- WINFORM SYSTRAY GUI --- #
# --------------------------- #
###############################

# Create a fake invisible WinForm and launch counter via the "Add_Load" form event (This gives Windows Message Boxes the proper updated visual style)
$ArchetypeCounterForm = New-Object System.Windows.Forms.Form
$ArchetypeCounterForm.Icon = $ArchetypeCounterSystrayIcon
$ArchetypeCounterForm.Text = "Archetype Counter"
$ArchetypeCounterForm.Opacity = 0
$ArchetypeCounterForm.BackColor = 'Black'
$ArchetypeCounterForm.FormBorderStyle = 'None'
$ArchetypeCounterForm.ShowInTaskbar = $false
$ArchetypeCounterForm.TopMost = $true
$ArchetypeCounterForm.Visible = $false

# Execute System tray app through the WinForms "load"
$ArchetypeCounterForm.Add_Load({

    # Archetype Counter - Systray / NotifyIcon - Control
    $Script:ArchetypeCounterSystray = New-Object System.Windows.Forms.NotifyIcon
    $ArchetypeCounterSystray.Icon = $ArchetypeCounterSystrayIconStartup
    $ArchetypeCounterSystray.Text = "Archetype Counter`n$ACTrayEncounterSymbol $EncounteredCount / $ACTrayEggSymbol $EggCount / $ACTrayFossilSymbol $FossilCount"
    $ArchetypeCounterSystray.Visible = $True

    # Creates VistaMenu used for a Context Menu (To add images)
    $ArchetypeVistaMenu = New-Object wyDay.Controls.VistaMenu

    # Create a ContextMenu used for Notifyicon
    $ArchetypeContextMenu = New-Object System.Windows.Forms.ContextMenu
    $ArchetypecontextMenu.Name = 'Archetype Counter'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Main" MenuItems for ContextMenu
    $ACMenuMainItems = @("Archetype Counter", "-", "Encountered", "Egg", "Fossil", "-", "Alpha / Legendary / Shiny", "-", "Hunt", "Settings", "Support","-","Troubleshooting", "-", "Exit")
    $ACMenuMainItems | ForEach-Object { 

        # Creates MenuItem and properly filters out menu names
        $ACMenuMainItem = New-Object System.Windows.Forms.MenuItem;
        $ACMenuMainItem.Text = $_ -replace '\s','' -replace '/','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACMenuMainItem.Text -notmatch '-') { 

            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACMenuMainItem.Text) -Value $ACMenuMainItem
            New-Variable -Name ('MenuImage' + "_" + $ACMenuMainItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACMenuMainItem.Text).png"))
            $MenuItem_MainItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACMenuMainItem.Text))).Value
            $MenuImage_MainItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACMenuMainItem.Text))).Value

        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $ArchetypecontextMenu.MenuItems.Add($ACMenuMainItem) 2>$null;
        $ACMenuMainItem.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_MainItem, $MenuImage_MainItem)

    }

    # Adds additional parameters for this section of the Context Menu (Main Menu)
    $MenuItem_ArchetypeCounter.Enabled = $false
    $MenuItem_Encountered.Text = "Encountered ($EncounteredCount)"
    $MenuItem_Egg.Text = "Egg ($EggCount)"
    $MenuItem_Fossil.Text = "Fossil ($FossilCount)"
    $MenuItem_Hunt.Text = "Hunt ($GetCurrentProfile)"

    # ----------------------------------------------------------------------------------------

    # Loads functions for encountered menu within counter
    . AddDynamicPokemonList
    . AddDynamicEncounteredButton

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Egg" MenuItems for ContextMenu
    $ACEggItems = @("Add 1 Egg", "Add 30 Egg", "Add 60 Egg", "-", "Add Custom Egg Count", "Reset Egg Count")
    $ACEggItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACEggItem = New-Object System.Windows.Forms.MenuItem;
        $ACEggItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACEggItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACEggItem.Text) -Value $ACEggItem
            $MenuItem_ACEggItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACEggItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Egg.MenuItems.Add($ACEggItem) 2>$null;
        $ACEggItem.Text = $_

    }

    # Adds additional parameters for this section of the Context Menu (Egg)
    $MenuItem_Add1Egg.Text = 'Add +1'
    $MenuItem_Add30Egg.Text = 'Add +30'
    $MenuItem_Add60Egg.Text = 'Add +60'
    $MenuItem_AddCustomEggCount.Text = 'Change Egg Count'
    $ArchetypeVistaMenu.SetImage($MenuItem_Add1Egg, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_Add30Egg, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_Add60Egg, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_AddCustomEggCount, $MenuImage_Add)
    $ArchetypeVistaMenu.SetImage($MenuItem_ResetEggCount, $MenuImage_Reset)

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Fossil" MenuItems for ContextMenu
    $ACFossilItems = @("Add 1 Fossil", "Add 30 Fossil", "Add 60 Fossil", "-", "Add Custom Fossil Count", "Reset Fossil Count")
    $ACFossilItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACFossilItem = New-Object System.Windows.Forms.MenuItem;
        $ACFossilItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACFossilItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACFossilItem.Text) -Value $ACFossilItem
            $MenuItem_ACFossilItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACFossilItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Fossil.MenuItems.Add($ACFossilItem) 2>$null;
        $ACFossilItem.Text = $_

    }

    # Adds additional parameters for this section of the Context Menu (Egg)
    $MenuItem_Add1Fossil.Text = 'Add +1'
    $MenuItem_Add30Fossil.Text = 'Add +30'
    $MenuItem_Add60Fossil.Text = 'Add +60'
    $MenuItem_AddCustomFossilCount.Text = 'Change Fossil Count'
    $ArchetypeVistaMenu.SetImage($MenuItem_Add1Fossil, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_Add30Fossil, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_Add60Fossil, $MenuImage_Dot)
    $ArchetypeVistaMenu.SetImage($MenuItem_AddCustomFossilCount, $MenuImage_Add)
    $ArchetypeVistaMenu.SetImage($MenuItem_ResetFossilCount, $MenuImage_Reset)

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Alpha/Legendary/Shiny" MenuItems for ContextMenu
    $ACShinyAlphaLegendaryItems = @("Alpha Count: $AlphaCount", "Legendary Count: $LegendaryCount", "-", "Shiny Count: $ShinyCount")
    $ACShinyAlphaLegendaryItems | ForEach-Object { 
 
        # Creates MenuItem and properly filters out menu names
        $ACShinyAlphaLegendaryItem = New-Object System.Windows.Forms.MenuItem;
        $ACShinyAlphaLegendaryItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACShinyAlphaLegendaryItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACShinyAlphaLegendaryItem.Text) -Value $ACShinyAlphaLegendaryItem
            New-Variable -Name ('MenuImage' + "_" + $ACShinyAlphaLegendaryItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACShinyAlphaLegendaryItem.Text).png"))
            $MenuItem_ACShinyAlphaLegendaryItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACShinyAlphaLegendaryItem.Text))).Value
            $MenuImage_ACShinyAlphaLegendaryItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACShinyAlphaLegendaryItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_AlphaLegendaryShiny.MenuItems.Add($ACShinyAlphaLegendaryItem) 2>$null;
        $ACShinyAlphaLegendaryItem.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACShinyAlphaLegendaryItem, $MenuImage_ACShinyAlphaLegendaryItem)
    
    }

    # Adds additional parameters for this section of the Context Menu (Alpha / Legendary / Shiny)
    $MenuItem_AlphaCount.Text = "Alpha Count ($AlphaCount)"; $MenuItem_LegendaryCount.Text = "Legendary ($LegendaryCount)"; $MenuItem_ShinyCount.Text = "Shiny ($ShinyCount)"

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Troubleshooting" MenuItems for ContextMenu
    $ACTroubleshootItems = @("PowerShell: $PSVersionInfo", "OS: $OSName", "Language: $PSUICulture", "NET Framework: $NetFrameworkVersion", "-", "Open Debug Folder", "Open Name Fix File", "-", "Toggle Debug Window", "Test Toast Notification", "-","Counter Version: 4.0.0.2")
    $ACTroubleshootItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACTroubleshootItem = New-Object System.Windows.Forms.MenuItem;
        $ACTroubleshootItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACTroubleshootItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACTroubleshootItem.Text) -Value $ACTroubleshootItem
            New-Variable -Name ('MenuImage' + "_" + $ACTroubleshootItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACTroubleshootItem.Text).png"))
            $MenuItem_ACTroubleshootItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACTroubleshootItem.Text))).Value
            $MenuImage_ACTroubleshootItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACTroubleshootItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Troubleshooting.MenuItems.Add($ACTroubleshootItem) 2>$null;
        $ACTroubleshootItem.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACTroubleshootItem, $MenuImage_ACTroubleshootItem)
        $ACTroubleshootItem.Enabled = $false
    
    }

    # Adds additional parameters for this section of the Context Menu (Troubleshooting)
    $MenuItem_OpenDebugFolder.Enabled = $true; $MenuItem_OpenNameFixFile.Enabled = $true; $MenuItem_ToggleDebugWindow.Enabled = $true; $MenuItem_TestToastNotification.Enabled = $true

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Support" MenuItems for ContextMenu
    $ACSupportItems = @("Github Readme:", "Github Counter Link", "-", "Github Issues:", "Github Issues Link", "-", "Discord:", "Discord Link")
    $ACSupportItems | ForEach-Object {

        # Creates MenuItem and properly filters out menu names
        $ACSupportItem = New-Object System.Windows.Forms.MenuItem;
        $ACSupportItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACSupportItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACSupportItem.Text) -Value $ACSupportItem
            New-Variable -Name ('MenuImage' + "_" + $ACSupportItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACSupportItem.Text).png"))
            $MenuItem_ACSupportItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACSupportItem.Text))).Value
            $MenuImage_ACSupportItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACSupportItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Support.MenuItems.Add($ACSupportItem) 2>$null;
        $ACSupportItem.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACSupportItem, $MenuImage_ACSupportItem)

    }

    # Adds additional parameters for this section of the Context Menu (Support)
    $MenuItem_GithubReadMe.Enabled = $false; $MenuItem_GithubIssues.Enabled = $false; $MenuItem_Discord.Enabled = $false
    $MenuItem_GithubCounterLink.Text = 'github.com/ssjshields/archetype-counter'; $MenuItem_GithubIssuesLink.Text = 'github.com/ssjshields/archetype-counter/issues'; $MenuItem_DiscordLink.Text = 'discord.gg/rYg7ntqQRY'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Hunt Profiles" MenuItems for ContextMenu
    $ACHuntProfileItems = @("Profile1", "Profile2", "Profile3", "Profile4", "Profile5", "Profile6", "Profile7", "Profile8", "Profile9", "Profile10", "-", "Rename Current Hunt", "-","Reset Current Hunt", "Reset All Hunts")
    $ACHuntProfileItems | ForEach-Object { 
    

        # Creates MenuItem and properly filters out menu names
        $ACHuntProfileItem = New-Object System.Windows.Forms.MenuItem;
        $ACHuntProfileItem.Text = $_ -replace '\s','';

        # Check if menuitem name does not match "-"
        if ($ACHuntProfileItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACHuntProfileItem.Text) -Value $ACHuntProfileItem
            $MenuItem_ACHuntProfileItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACHuntProfileItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Hunt.MenuItems.Add($ACHuntProfileItem) 2>$null;
        if ($GetProfile -match "\b$($MenuItem_ACHuntProfileItem.Text)\b") { $ArchetypeVistaMenu.SetImage($MenuItem_ACHuntProfileItem, $MenuImage_RadioCheckFilled); $MenuItem_ACHuntProfileItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACHuntProfileItem , $MenuImage_RadioCheckEmpty) }
        $ACHuntProfileItem.Text = $_

    }

    # Adds additional parameters for this section of the Context Menu (Hunt Profiles)
    $MenuItem_Profile1.Text = $CheckProfile1; $MenuItem_Profile2.Text = $CheckProfile2; $MenuItem_Profile3.Text = $CheckProfile3; $MenuItem_Profile4.Text = $CheckProfile4; $MenuItem_Profile5.Text = $CheckProfile5; $MenuItem_Profile6.Text = $CheckProfile6; $MenuItem_Profile7.Text = $CheckProfile7; $MenuItem_Profile8.Text = $CheckProfile8; $MenuItem_Profile9.Text = $CheckProfile9; $MenuItem_Profile10.Text = $CheckProfile10
    $ArchetypeVistaMenu.SetImage($MenuItem_RenameCurrentHunt, $MenuImage_RenameCurrentHunt)
    $ArchetypeVistaMenu.SetImage($MenuItem_ResetCurrentHunt, $MenuImage_ResetCurrentHunt)
    $ArchetypeVistaMenu.SetImage($MenuItem_ResetAllHunts, $MenuImage_ResetAllHunts)

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Settings" MenuItems for ContextMenu
    $ACModesItems = @("Picture Mode", "Chinese Mode", "Theme Mode", "Sprite Mode", "Notify Mode", "Sorting Mode", "Overlay Mode", '-', "Open PokeMMO", "Close PokeMMO", "Show Failed Scans", '-', "Uninstall")
    $ACModesItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACModesItem = New-Object System.Windows.Forms.MenuItem;
        $ACModesItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACModesItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACModesItem.Text) -Value $ACModesItem
            New-Variable -Name ('MenuImage' + "_" + $ACModesItem.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACModesItem.Text).png"))
            $MenuItem_ACModesItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACModesItem.Text))).Value
            $MenuImage_ACModesItem = (Get-Variable -Name ('MenuImage' + '_' + $($ACModesItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_Settings.MenuItems.Add($ACModesItem) 2>$null;
        $ACModesItem.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACModesItem, $MenuImage_ACModesItem)

    }
    
    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Picture Mode" MenuItems for ContextMenu
    $ACPictureModesItems = @("Primary", "Alternate")
    $ACPictureModesItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACPictureModesItem = New-Object System.Windows.Forms.MenuItem;
        $ACPictureModesItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACPictureModesItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACPictureModesItem.Text) -Value $ACPictureModesItem
            $MenuItem_ACPictureModesItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACPictureModesItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_PictureMode.MenuItems.Add($ACPictureModesItem) 2>$null;
        if ($PictureMode -match $MenuItem_ACPictureModesItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACPictureModesItem, $MenuImage_RadioCheckFilled); $MenuItem_ACPictureModesItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACPictureModesItem, $MenuImage_RadioCheckEmpty) }
        $ACPictureModesItem.Text = $_

    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_Alternate.Text = 'Alternate (Debug)'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Chinese Mode" MenuItems for ContextMenu
    $ACChineseModeItems = @("Off", "Simplified", "Traditional")
    $ACChineseModeItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACChineseModeItem = New-Object System.Windows.Forms.MenuItem;
        $ACChineseModeItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACChineseModeItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACChineseModeItem.Text) -Value $ACChineseModeItem
            $MenuItem_ACChineseModeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACChineseModeItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_ChineseMode.MenuItems.Add($ACChineseModeItem) 2>$null;
        if ($ChineseMode -match $MenuItem_ACChineseModeItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACChineseModeItem, $MenuImage_RadioCheckFilled); $MenuItem_ACChineseModeItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACChineseModeItem, $MenuImage_RadioCheckEmpty) }
        $ACChineseModeItem.Text = $_

    }

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Theme Mode" MenuItems for ContextMenu
    $ACThemeModeItems = @("Auto", "Light", "Dark")
    $ACThemeModeItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACThemeModeItem = New-Object System.Windows.Forms.MenuItem;
        $ACThemeModeItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACThemeModeItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACThemeModeItem.Text) -Value $ACThemeModeItem
            $MenuItem_ACThemeModeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACThemeModeItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_ThemeMode.MenuItems.Add($ACThemeModeItem) 2>$null;
        if ($ThemeModeAuto -match $MenuItem_ACThemeModeItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACThemeModeItem, $MenuImage_RadioCheckFilled); $MenuItem_ACThemeModeItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACThemeModeItem, $MenuImage_RadioCheckEmpty) }
        $ACThemeModeItem.Text = $_
    
    }

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Notify Mode" MenuItems for ContextMenu
    $ACNotifyModesItems = @("Always", "Milestone Pokemon", "Milestone Total", "Never", "-", "Set Notify Milestone")
    $ACNotifyModesItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACNotifyModesItem = New-Object System.Windows.Forms.MenuItem;
        $ACNotifyModesItem.Text = $_ -replace '\s',''

        # Check if menuitem name does not match "-"
        if ($ACNotifyModesItem.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACNotifyModesItem.Text) -Value $ACNotifyModesItem #-Scope Script
            $MenuItem_ACThemeModeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACNotifyModesItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_NotifyMode.MenuItems.Add($ACNotifyModesItem) 2>$null;
        if ($NotifyMode -match $MenuItem_ACThemeModeItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACThemeModeItem, $MenuImage_RadioCheckFilled); $MenuItem_ACThemeModeItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACThemeModeItem, $MenuImage_RadioCheckEmpty) }
        $ACNotifyModesItem.Text = $_

    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_MilestonePokemon.Text = 'Milestone (Pokémon)'
    $MenuItem_MilestoneTotal.Text = 'Milestone (Total)'
    $ArchetypeVistaMenu.SetImage($MenuItem_SetNotifyMilestone, $MenuImage_SetNotifyMilestone)
	$MenuItem_SetNotifyMilestone.Text = "Set Milestone ($NotifyMilestone)"; 

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Notify Mode" MenuItems for ContextMenu
    $ACSpriteModesItems = @("Default", "3DS", "Gen 8", "Home", "Shuffle")
    $ACSpriteModesItems | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACSpriteModesItem = New-Object System.Windows.Forms.MenuItem;
        $ACSpriteModesItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACSpriteModesItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACSpriteModesItem.Text) -Value $ACSpriteModesItem
            $MenuItem_ACSpriteModesItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACSpriteModesItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_SpriteMode.MenuItems.Add($ACSpriteModesItem) 2>$null;
        if ($SpriteMode -match $MenuItem_ACSpriteModesItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACSpriteModesItem, $MenuImage_RadioCheckFilled); $MenuItem_ACSpriteModesItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACSpriteModesItem, $MenuImage_RadioCheckEmpty) }
        $ACSpriteModesItem.Text = $_
    
    }

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Open PokeMMO" MenuItems for ContextMenu
    $ACOpenPokeMMOItems = @("Yes Open", "No Open")
    $ACOpenPokeMMOItems | ForEach-Object { 

        # Creates MenuItem and properly filters out menu names
        $ACOpenPokeMMOItem = New-Object System.Windows.Forms.MenuItem;
        $ACOpenPokeMMOItem.Text = $_ -replace '\s','';

        # Check if menuitem name does not match "-"
        if ($ACOpenPokeMMOItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACOpenPokeMMOItem.Text) -Value $ACOpenPokeMMOItem
            $MenuItem_ACOpenPokeMMOItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACOpenPokeMMOItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_OpenPokeMMO.MenuItems.Add($ACOpenPokeMMOItem) 2>$null;
        if ($OpenPokeMMO -match $MenuItem_ACOpenPokeMMOItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACOpenPokeMMOItem, $MenuImage_RadioCheckFilled); $MenuItem_ACOpenPokeMMOItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACOpenPokeMMOItem, $MenuImage_RadioCheckEmpty) }
        $ACOpenPokeMMOItem.Text = $_
    
    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_YesOpen.Text = 'Yes'; $MenuItem_NoOpen.Text = 'No'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Close PokeMMO" MenuItems for ContextMenu
    $ACClosePokeMMOItems = @("Yes Close", "No Close")
    $ACClosePokeMMOItems | ForEach-Object {  
    

        # Creates MenuItem and properly filters out menu names
        $ACClosePokeMMOItem = New-Object System.Windows.Forms.MenuItem;
        $ACClosePokeMMOItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACClosePokeMMOItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACClosePokeMMOItem.Text) -Value $ACClosePokeMMOItem
            $MenuItem_ACClosePokeMMOItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACClosePokeMMOItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_ClosePokeMMO.MenuItems.Add($ACClosePokeMMOItem) 2>$null;
        if ($ClosePokeMMO -match $MenuItem_ACClosePokeMMOItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACClosePokeMMOItem, $MenuImage_RadioCheckFilled); $MenuItem_ACClosePokeMMOItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACClosePokeMMOItem, $MenuImage_RadioCheckEmpty) }
        $ACClosePokeMMOItem.Text = $_
    
    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_YesClose.Text = 'Yes'; $MenuItem_NoClose.Text = 'No'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Close PokeMMO" MenuItems for ContextMenu
    $ACShowFailedScansItems = @("Yes Scan", "No Scan")
    $ACShowFailedScansItems | ForEach-Object {  
    

        # Creates MenuItem and properly filters out menu names
        $ACShowFailedScansItem = New-Object System.Windows.Forms.MenuItem;
        $ACShowFailedScansItem.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACShowFailedScansItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACShowFailedScansItem.Text) -Value $ACShowFailedScansItem
            $MenuItem_ACShowFailedScansItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACShowFailedScansItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_ShowFailedScans.MenuItems.Add($ACShowFailedScansItem) 2>$null;
        if ($ShowFailedScans -match $MenuItem_ACShowFailedScansItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACShowFailedScansItem, $MenuImage_RadioCheckFilled); $MenuItem_ACShowFailedScansItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACShowFailedScansItem, $MenuImage_RadioCheckEmpty) }
        $ACShowFailedScansItem.Text = $_
    
    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_YesScan.Text = 'Yes'; $MenuItem_NoScan.Text = 'No'

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Close PokeMMO" MenuItems for ContextMenu
    $ACOverlayModeItems = @("OnOverlayPokemon", "OnOverlayTotal", "OffOverlay", "-", "Open Overlay Settings")
    $ACOverlayModeItems | ForEach-Object {  
    
        # Creates MenuItem and properly filters out menu names
        $ACOverlayModeItem = New-Object System.Windows.Forms.MenuItem;
        $ACOverlayModeItem.Text = $_ -replace '\s',''

        # Check if menuitem name does not match "-"
        if ($ACOverlayModeItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACOverlayModeItem.Text) -Value $ACOverlayModeItem
            $MenuItem_ACOverlayModeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACOverlayModeItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_OverlayMode.MenuItems.Add($ACOverlayModeItem) 2>$null;
        if ($OverlayMode -match $MenuItem_ACOverlayModeItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACOverlayModeItem, $MenuImage_RadioCheckFilled); $MenuItem_ACOverlayModeItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACOverlayModeItem, $MenuImage_RadioCheckEmpty) }
        $ACOverlayModeItem.Text = $_
    
    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_OnOverlayPokemon.Text = 'On (Pokémon)'; $MenuItem_OnOverlayTotal.Text = 'On (Total)'; $MenuItem_OffOverlay.Text = 'Off (System Tray)'
    $ArchetypeVistaMenu.SetImage($MenuItem_OpenOverlaySettings, $MenuImage_OpenOverlaySettings)

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Filter Mode" MenuItems for ContextMenu
    $ACSortingModeItems = @("EncounteredAscending", "EncounteredDescending", "-", "PokedexAscending", "PokedexDescending", "-", "PokemonAscending", "PokemonDescending", "PokemonLastSeen", "-", "None")
    $ACSortingModeItems | ForEach-Object {  
    
        # Creates MenuItem and properly filters out menu names
        $ACSortingModeItem = New-Object System.Windows.Forms.MenuItem;
        $ACSortingModeItem.Text = $_ -replace '\s',''

        # Check if menuitem name does not match "-"
        if ($ACSortingModeItem.Text -notmatch '-') { 
        
            New-Variable -Name ('MenuItem' + "_" + $ACSortingModeItem.Text) -Value $ACSortingModeItem
            $MenuItem_ACSortingModeItem = (Get-Variable -Name ('MenuItem' + '_' + $($ACSortingModeItem.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_SortingMode.MenuItems.Add($ACSortingModeItem) 2>$null;
        if ($SortingMode -match $MenuItem_ACSortingModeItem.Text) { $ArchetypeVistaMenu.SetImage($MenuItem_ACSortingModeItem, $MenuImage_RadioCheckFilled); $MenuItem_ACSortingModeItem.Enabled = $false } else { $ArchetypeVistaMenu.SetImage($MenuItem_ACSortingModeItem, $MenuImage_RadioCheckEmpty) }
        $ACSortingModeItem.Text = $_
    
    }

    # Additional changes for the MenuItems on Context Menu
    $MenuItem_EncounteredAscending.Text = "Encountered (Ascending)"
    $MenuItem_EncounteredDescending.Text = "Encountered (Descending)"
    $MenuItem_PokedexAscending.Text = "Pokédex (Ascending)"
    $MenuItem_PokedexDescending.Text = "Pokédex (Descending)"
    $MenuItem_PokemonAscending.Text = "Pokémon (Ascending)"
    $MenuItem_PokemonDescending.Text = "Pokémon (Descending)"
    $MenuItem_PokemonLastSeen.Text = "Pokémon (Last Seen)"

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Alpha Count" MenuItems for ContextMenu
    $ACModesAlphas = @("Add Custom Alpha Count", "Reset Alpha Count")
    $ACModesAlphas | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACModesAlpha = New-Object System.Windows.Forms.MenuItem;
        $ACModesAlpha.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACModesAlpha.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACModesAlpha.Text) -Value $ACModesAlpha #-Scope Script
            New-Variable -Name ('MenuImage' + "_" + $ACModesAlpha.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACModesAlpha.Text).png"))
            $MenuItem_ACModesAlpha = (Get-Variable -Name ('MenuItem' + '_' + $($ACModesAlpha.Text))).Value
            $MenuImage_ACModesAlpha = (Get-Variable -Name ('MenuImage' + '_' + $($ACModesAlpha.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_AlphaCount.MenuItems.Add($ACModesAlpha) 2>$null;
        $ACModesAlpha.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACModesAlpha, $MenuImage_ACModesAlpha)

        # Additional changes for the MenuItems on Context Menu
        $MenuItem_AddCustomAlphaCount.Text = 'Change Alpha Count'

    }

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Legendary Count" MenuItems for ContextMenu
    $ACModesLegendarys = @("Add Custom Legendary Count", "Reset Legendary Count")
    $ACModesLegendarys | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACModesLegendary = New-Object System.Windows.Forms.MenuItem;
        $ACModesLegendary.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACModesLegendary.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACModesLegendary.Text) -Value $ACModesLegendary #-Scope Script
            New-Variable -Name ('MenuImage' + "_" + $ACModesLegendary.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACModesLegendary.Text).png"))
            $MenuItem_ACModesLegendary = (Get-Variable -Name ('MenuItem' + '_' + $($ACModesLegendary.Text))).Value
            $MenuImage_ACModesLegendary = (Get-Variable -Name ('MenuImage' + '_' + $($ACModesLegendary.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_LegendaryCount.MenuItems.Add($ACModesLegendary) 2>$null;
        $ACModesLegendary.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACModesLegendary, $MenuImage_ACModesLegendary)

        # Additional changes for the MenuItems on Context Menu
        $MenuItem_AddCustomLegendaryCount.Text = 'Change Legendary Count'

    }

    # ----------------------------------------------------------------------------------------

    # Define and loop through array of stored "Shiny Count" MenuItems for ContextMenu
    $ACModesShinys = @("Add Custom Shiny Count", "Reset Shiny Count")
    $ACModesShinys | ForEach-Object { 
    
        # Creates MenuItem and properly filters out menu names
        $ACModesShiny = New-Object System.Windows.Forms.MenuItem;
        $ACModesShiny.Text = $_ -replace '\s','' -replace ":.*", "";

        # Check if menuitem name does not match "-"
        if ($ACModesShiny.Text -notmatch '-') { 
        
            # Create new MenuItem and MenuImage variables for context menu
            New-Variable -Name ('MenuItem' + "_" + $ACModesShiny.Text) -Value $ACModesShiny #-Scope Script
            New-Variable -Name ('MenuImage' + "_" + $ACModesShiny.Text) -Value $([System.Drawing.Image]::FromFile("$Global:CounterWorkingDir\icons\$ThemeMode\$($ACModesShiny.Text).png"))
            $MenuItem_ACModesShiny = (Get-Variable -Name ('MenuItem' + '_' + $($ACModesShiny.Text))).Value
            $MenuImage_ACModesShiny = (Get-Variable -Name ('MenuImage' + '_' + $($ACModesShiny.Text))).Value
        
        } 

        # Adds MenuItems on Context Menu and assigns images from VistaMenu.dll
        $MenuItem_ShinyCount.MenuItems.Add($ACModesShiny) 2>$null;
        $ACModesShiny.Text = $_
        $ArchetypeVistaMenu.SetImage($MenuItem_ACModesShiny, $MenuImage_ACModesShiny)

        # Additional changes for the MenuItems on Context Menu
        $MenuItem_AddCustomShinyCount.Text = 'Change Shiny Count'

    }

    # ----------------------------------------------------------------------------------------

    ######################################
    # ---------------------------------- #
    # --- WINFORM CONTROL PARAMETERS --- #
    # ---------------------------------- #
    ######################################
    
    # All add_click events for the counter right click menu
    $MenuItem_Add1Egg.add_Click({ . LoadExternalVariables; $EggCount = [int]$EggCount + 1; $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=$EggCount"; . CounterProfileRestart })
    $MenuItem_Add30Egg.add_Click({ . LoadExternalVariables; $EggCount = [int]$EggCount + 30; $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=$EggCount"; . CounterProfileRestart })
    $MenuItem_Add60Egg.add_Click({ . LoadExternalVariables; $EggCount = [int]$EggCount + 60; $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=$EggCount"; . CounterProfileRestart })
    $MenuItem_Add1Fossil.add_Click({ . LoadExternalVariables; $FossilCount = [int]$FossilCount + 1; $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=$FossilCount"; . CounterProfileRestart })
    $MenuItem_Add30Fossil.add_Click({ . LoadExternalVariables; $FossilCount = [int]$FossilCount + 30; $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=$FossilCount"; . CounterProfileRestart })
    $MenuItem_Add60Fossil.add_Click({ . LoadExternalVariables; $FossilCount = [int]$FossilCount + 60; $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=$FossilCount"; . CounterProfileRestart })
    $MenuItem_ResetAlphaCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogResetAlpha = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogResetAlpha.WindowTitle = "Archetype Counter"; $TaskDialogResetAlpha.ButtonStyle = 'CommandLinks'; $TaskDialogResetAlpha.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogResetAlpha.MainInstruction = "Reset Alpha Count"; $TaskDialogResetAlpha.Content = "Do you want to reset the alpha count?"; $TaskDialogResetAlpha.Footer = "Current Alpha Count: $AlphaCount"; $TaskDialogResetAlpha.FooterIcon = 'Information'; $TaskDialogResetAlpha.AllowDialogCancellation = $true; $TaskDialogResetAlpha.Buttons.Add('Reset'); $TaskDialogResetAlpha.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentAlphaResults = $TaskDialogResetAlpha.ShowDialog($ArchetypeCounterForm); If ($TDCurrentAlphaResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Alpha_Count=.*", "Alpha_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetLegendaryCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogResetLegendary = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogResetLegendary.WindowTitle = "Archetype Counter"; $TaskDialogResetLegendary.ButtonStyle = 'CommandLinks'; $TaskDialogResetLegendary.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogResetLegendary.MainInstruction = "Reset Legendary Count"; $TaskDialogResetLegendary.Content = "Do you want to reset the legendary count?"; $TaskDialogResetLegendary.Footer = "Current Legendary Count: $LegendaryCount"; $TaskDialogResetLegendary.FooterIcon = 'Information'; $TaskDialogResetLegendary.AllowDialogCancellation = $true; $TaskDialogResetLegendary.Buttons.Add('Reset'); $TaskDialogResetLegendary.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentLegendaryResults = $TaskDialogResetLegendary.ShowDialog($ArchetypeCounterForm); If ($TDCurrentLegendaryResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Legendary_Count=.*", "Legendary_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetShinyCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogResetShiny = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogResetShiny.WindowTitle = "Archetype Counter"; $TaskDialogResetShiny.ButtonStyle = 'CommandLinks'; $TaskDialogResetShiny.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogResetShiny.MainInstruction = "Reset Shiny Count"; $TaskDialogResetShiny.Content = "Do you want to reset the shiny count?"; $TaskDialogResetShiny.Footer = "Current Shiny Count: $ShinyCount"; $TaskDialogResetShiny.FooterIcon = 'Information'; $TaskDialogResetShiny.AllowDialogCancellation = $true; $TaskDialogResetShiny.Buttons.Add('Reset'); $TaskDialogResetShiny.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentShinyResults = $TaskDialogResetShiny.ShowDialog($ArchetypeCounterForm); If ($TDCurrentShinyResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Shiny_Count=.*", "Shiny_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetFossilCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogResetFossil = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogResetFossil.WindowTitle = "Archetype Counter"; $TaskDialogResetFossil.ButtonStyle = 'CommandLinks'; $TaskDialogResetFossil.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogResetFossil.MainInstruction = "Reset Fossil Count"; $TaskDialogResetFossil.Content = "Do you want to reset the fossil count?"; $TaskDialogResetFossil.Footer = "Current Fossil Count: $FossilCount"; $TaskDialogResetFossil.FooterIcon = 'Information'; $TaskDialogResetFossil.AllowDialogCancellation = $true; $TaskDialogResetFossil.Buttons.Add('Reset'); $TaskDialogResetFossil.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentFossilResults = $TaskDialogResetFossil.ShowDialog($ArchetypeCounterForm); If ($TDCurrentFossilResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetEggCount.add_Click({ . SetDialogTransparentBackground; $TaskDialogResetEgg = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogResetEgg.WindowTitle = "Archetype Counter"; $TaskDialogResetEgg.ButtonStyle = 'CommandLinks'; $TaskDialogResetEgg.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogResetEgg.MainInstruction = "Reset Egg Count"; $TaskDialogResetEgg.Content = "Do you want to reset the egg count?"; $TaskDialogResetEgg.Footer = "Current Egg Count: $EggCount"; $TaskDialogResetEgg.FooterIcon = 'Information'; $TaskDialogResetEgg.AllowDialogCancellation = $true; $TaskDialogResetEgg.Buttons.Add('Reset'); $TaskDialogResetEgg.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentEggResults = $TaskDialogResetEgg.ShowDialog($ArchetypeCounterForm); If ($TDCurrentEggResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=0"; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_Profile1.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile1"; . CounterHuntRestart })
    $MenuItem_Profile2.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile2"; . CounterHuntRestart })
    $MenuItem_Profile3.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile3"; . CounterHuntRestart })
    $MenuItem_Profile4.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile4"; . CounterHuntRestart })
    $MenuItem_Profile5.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile5"; . CounterHuntRestart })
    $MenuItem_Profile6.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile6"; . CounterHuntRestart })
    $MenuItem_Profile7.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile7"; . CounterHuntRestart })
    $MenuItem_Profile8.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile8"; . CounterHuntRestart })
    $MenuItem_Profile9.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile9"; . CounterHuntRestart })
    $MenuItem_Profile10.add_Click({ $GetProfileState = $GetProfileState -replace "Current_Hunt_Profile=.*", "Current_Hunt_Profile=$CheckProfile10"; . CounterHuntRestart })
    $MenuItem_Primary.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Picture_Mode=.*", "Picture_Mode=Primary"; . CounterConfigRestart })
    $MenuItem_Alternate.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Picture_Mode=.*", "Picture_Mode=Alternate"; . CounterConfigRestart })
    $MenuItem_Off.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Chinese_Mode=.*", "Chinese_Mode=Off"; . CounterConfigRestart })
    $MenuItem_Simplified.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Chinese_Mode=.*", "Chinese_Mode=Simplified"; . CounterConfigRestart })
    $MenuItem_Traditional.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Chinese_Mode=.*", "Chinese_Mode=Traditional"; . CounterConfigRestart })
    $MenuItem_Auto.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Theme_Mode=.*", "Theme_Mode=Auto"; . CounterConfigRestart })
    $MenuItem_Light.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Theme_Mode=.*", "Theme_Mode=Light"; . CounterConfigRestart })
    $MenuItem_Dark.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Theme_Mode=.*", "Theme_Mode=Dark"; . CounterConfigRestart })
    $MenuItem_Default.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sprite_Mode=.*", "Sprite_Mode=Default"; . CounterConfigRestart })
    $MenuItem_3Ds.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sprite_Mode=.*", "Sprite_Mode=3DS"; . CounterConfigRestart })
    $MenuItem_Gen8.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sprite_Mode=.*", "Sprite_Mode=Gen8"; . CounterConfigRestart })
    $MenuItem_Home.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sprite_Mode=.*", "Sprite_Mode=Home"; . CounterConfigRestart })
    $MenuItem_Shuffle.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sprite_Mode=.*", "Sprite_Mode=Shuffle"; . CounterConfigRestart })
    $MenuItem_Never.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Notify_Mode=.*", "Notify_Mode=Never"; . CounterConfigRestart })
    $MenuItem_MilestonePokemon.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Notify_Mode=.*", "Notify_Mode=MilestonePokemon"; . CounterConfigRestart })
    $MenuItem_MilestoneTotal.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Notify_Mode=.*", "Notify_Mode=MilestoneTotal"; . CounterConfigRestart })
    $MenuItem_Always.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Notify_Mode=.*", "Notify_Mode=Always"; . CounterConfigRestart })
    $MenuItem_SetNotifyMilestone.add_Click({ . SetDialogTransparentBackground; $InputEncounteredDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputEncounteredDialog.WindowTitle = 'Archetype Counter'; $InputEncounteredDialog.MainInstruction = 'Set Notify Milestone'; $InputEncounteredDialog.Content = "Enter the total number value for the Milestone Notifications to appear.`n`n- Example: 500"; $InputEncounteredDialog.Input = ''; $CheckDialogSelect = $InputEncounteredDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInput = $InputEncounteredDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInput -eq "") { $IDInput = '0' }; $GetConfigSettings = $GetConfigSettings -replace "Notify_Milestone=.*", "Notify_Milestone=$IDInput"; . RemoveDialogTransparentBackground; . CounterConfigRestart }; RemoveDialogTransparentBackground })
    $MenuItem_EncounteredAscending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=EncounteredAscending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonCount $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList); . CounterConfigRestart })
    $MenuItem_EncounteredDescending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=EncounteredDescending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonCount $_ } -Descending; [System.Threading.Thread]::Sleep(100); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList);. CounterConfigRestart })
    $MenuItem_PokedexAscending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=PokedexAscending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokedexNumber $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList); . CounterConfigRestart })
    $MenuItem_PokedexDescending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=PokedexDescending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokedexNumber $_ } -Descending; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList); . CounterConfigRestart })
    $MenuItem_PokemonAscending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=PokemonAscending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonName $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList); . CounterConfigRestart })
    $MenuItem_PokemonDescending.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=PokemonDescending"; $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonName $_ } -Descending; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList); . CounterConfigRestart })
    $MenuItem_PokemonLastSeen.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=PokemonLastSeen"; . CounterConfigRestart })
    $MenuItem_None.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Sorting_Mode=.*", "Sorting_Mode=None"; . CounterConfigRestart })
    $MenuItem_YesOpen.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Open_PokeMMO=.*", "Open_PokeMMO=YesOpen"; . CounterConfigRestart })
    $MenuItem_NoOpen.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Open_PokeMMO=.*", "Open_PokeMMO=NoOpen"; . CounterConfigRestart })
    $MenuItem_YesClose.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Close_PokeMMO=.*", "Close_PokeMMO=YesClose"; . CounterConfigRestart })
    $MenuItem_NoClose.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Close_PokeMMO=.*", "Close_PokeMMO=NoClose"; . CounterConfigRestart })
    $MenuItem_YesScan.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Show_Failed_Scans=.*", "Show_Failed_Scans=YesScan"; . CounterConfigRestart })
    $MenuItem_NoScan.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Show_Failed_Scans=.*", "Show_Failed_Scans=NoScan"; . CounterConfigRestart })
    $MenuItem_OpenNameFixFile.add_Click({ Explorer .\stored\Config_PokemonNameFix.txt })
    $MenuItem_OpenDebugFolder.add_Click({ Explorer .\debug })
    $MenuItem_OnOverlayPokemon.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Overlay_Mode=.*", "Overlay_Mode=OnOverlayPokemon"; . CounterConfigRestart })
    $MenuItem_OnOverlayTotal.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Overlay_Mode=.*", "Overlay_Mode=OnOverlayTotal"; . CounterConfigRestart })
    $MenuItem_OffOverlay.add_Click({ $GetConfigSettings = $GetConfigSettings -replace "Overlay_Mode=.*", "Overlay_Mode=OffOverlay"; . CounterConfigRestart })
    $MenuItem_OpenOverlaySettings.add_Click({ Explorer .\stored\Config_OverlaySettings.txt })
    $MenuItem_TestToastNotification.add_Click({ . LoadExternalVariables; $PokemonToastNotify = "$Global:CounterWorkingDir\icons\sprites\$SpriteMode\25.png"; if (Test-Path "HKCU:\Software\Classes\AppUserModelId\Archetype.PokeMMO.ArchetypeCounter!App") { $ToastAppID = 'Archetype.PokeMMO.ArchetypeCounter!App'; $ToastAppTitle = "Encountered Total: N/A" } else { $ToastAppID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'; $ToastAppTitle = "Archetype Counter (Encountered: N/A)" }; $BT_Header = New-BTHeader -Id 'Archetype Counter' -Title "$ToastAppTitle"; New-BurntToastNotification -Silent -AppId "$ToastAppID" -AppLogo $PokemonToastNotify -Text "#25 Pikachu (Test Notification)", "Current Count: N/A" -Header $BT_Header })
    $MenuItem_AddCustomEggCount.add_Click({ . SetDialogTransparentBackground; $InputEggDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputEggDialog.WindowTitle = 'Archetype Counter'; $InputEggDialog.MainInstruction = 'Custom Egg Count'; $InputEggDialog.Content = "Enter the total number value for the egg count.`n`n- Example: 267"; $InputEggDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputEggDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInputEgg = $InputEggDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInputEgg -eq "") { $IDInputEgg = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=$IDInputEgg"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_AddCustomFossilCount.add_Click({ . SetDialogTransparentBackground; $InputFossilDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputFossilDialog.WindowTitle = 'Archetype Counter'; $InputFossilDialog.MainInstruction = 'Custom Fossil Count'; $InputFossilDialog.Content = "Enter the total number value for the fossil count.`n`n- Example: 267"; $InputFossilDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputFossilDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInputFossil = $InputFossilDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInputFossil -eq "") { $IDInputFossil = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=$IDInputFossil"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_AddCustomAlphaCount.add_Click({ . SetDialogTransparentBackground; $InputAlphaDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputAlphaDialog.WindowTitle = 'Archetype Counter'; $InputAlphaDialog.MainInstruction = 'Custom Alpha Count'; $InputAlphaDialog.Content = "Enter the total number value for the alpha count.`n`n- Example: 267"; $InputAlphaDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputAlphaDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInputAlpha = $InputAlphaDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInputAlpha -eq "") { $IDInputAlpha = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Alpha_Count=.*", "Alpha_Count=$IDInputAlpha"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_AddCustomLegendaryCount.add_Click({ . SetDialogTransparentBackground; $InputLegendaryDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputLegendaryDialog.WindowTitle = 'Archetype Counter'; $InputLegendaryDialog.MainInstruction = 'Custom Legendary Count'; $InputLegendaryDialog.Content = "Enter the total number value for the legendary count.`n`n- Example: 267"; $InputLegendaryDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputLegendaryDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInputLegendary = $InputLegendaryDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInputLegendary -eq "") { $IDInputLegendary = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Legendary_Count=.*", "Legendary_Count=$IDInputLegendary"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_AddCustomShinyCount.add_Click({ . SetDialogTransparentBackground; $InputShinyDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputShinyDialog.WindowTitle = 'Archetype Counter'; $InputShinyDialog.MainInstruction = 'Custom Shiny Count'; $InputShinyDialog.Content = "Enter the total number value for the shiny count.`n`n- Example: 267"; $InputShinyDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputShinyDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInputShiny = $InputShinyDialog.Input -replace '[^\d]', '' -replace '\s+', ''; if ($IDInputShiny -eq "") { $IDInputShiny = '0' }; $GetConfigProfile = $GetConfigProfile -replace "Shiny_Count=.*", "Shiny_Count=$IDInputShiny"; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_RenameCurrentHunt.add_Click({ . SetDialogTransparentBackground; $InputDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputDialog.WindowTitle = 'Archetype Counter'; $InputDialog.MainInstruction = 'Rename Current Hunt'; $InputDialog.Content = "Change the current hunt profile name.`n`n- Example: Hordes"; $InputDialog.Input = ''; [System.Media.SystemSounds]::Exclamation.Play(); $CheckDialogSelect = $InputDialog.ShowDialog($ArchetypeCounterForm); if ($CheckDialogSelect -match 'OK') { $IDInput = $InputDialog.Input; if (!([string]::IsNullOrWhiteSpace($IDInput))) { $GetProfileState = $GetProfileState -replace "\b$GetCurrentProfile\b", "$IDInput" ; . RemoveDialogTransparentBackground; . CounterHuntRestart } }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetCurrentHunt.add_Click({ . SetDialogTransparentBackground; $TaskDialogCurrentHunt = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogCurrentHunt.WindowTitle = "Archetype Counter"; $TaskDialogCurrentHunt.ButtonStyle = 'CommandLinks'; $TaskDialogCurrentHunt.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogCurrentHunt.MainInstruction = "Reset Current Hunt"; $TaskDialogCurrentHunt.Content = "Do you want to reset the current hunt?"; $TaskDialogCurrentHunt.Footer = "Current Hunt Profile: $GetCurrentProfile"; $TaskDialogCurrentHunt.FooterIcon = 'Information'; $TaskDialogCurrentHunt.AllowDialogCancellation = $true; $TaskDialogCurrentHunt.Buttons.Add('Reset'); $TaskDialogCurrentHunt.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDCurrentHuntResults = $TaskDialogCurrentHunt.ShowDialog($ArchetypeCounterForm); If ($TDCurrentHuntResults.Text -match "Reset") { $GetConfigProfile = $GetConfigProfile -replace "Egg_Count=.*", "Egg_Count=0";  $GetConfigProfile = $GetConfigProfile -replace "Fossil_Count=.*", "Fossil_Count=0"; $GetConfigProfile = $GetConfigProfile -replace "Encountered_Count=.*", "Encountered_Count=0"; $GetConfigProfile = $GetConfigProfile -replace "Alpha_Count=.*", "Alpha_Count=0"; $GetConfigProfile = $GetConfigProfile -replace "Legendary_Count=.*", "Legendary_Count=0"; $GetConfigProfile = $GetConfigProfile -replace "Shiny_Count=.*", "Shiny_Count=0"; $GetConfigProfile = $GetConfigProfile -replace "Single_Battle=.*", "Single_Battle=0"; $GetConfigProfile = $GetConfigProfile -replace "Double_Battle=.*", "Double_Battle=0"; $GetConfigProfile = $GetConfigProfile -replace "Triple_Battle=.*", "Triple_Battle=0"; $GetConfigProfile = $GetConfigProfile -replace "Horde_Battle=.*", "Horde_Battle=0"; [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile); Clear-Content -Path $EncounteredCurrentProfile; . RemoveDialogTransparentBackground; . CounterProfileRestart }; . RemoveDialogTransparentBackground })
    $MenuItem_ResetAllHunts.add_Click({ . SetDialogTransparentBackground; $TaskDialogAllHunt = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogAllHunt.WindowTitle = "Archetype Counter"; $TaskDialogAllHunt.ButtonStyle = 'CommandLinks'; $TaskDialogAllHunt.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialogAllHunt.MainInstruction = "Reset All Hunts"; $TaskDialogAllHunt.Content = "Do you want to reset all hunt profiles?"; $TaskDialogAllHunt.AllowDialogCancellation = $true; $TaskDialogAllHunt.Buttons.Add('Reset'); $TaskDialogAllHunt.Buttons.Add('No'); [System.Media.SystemSounds]::Exclamation.Play(); $TDAllHuntResults = $TaskDialogAllHunt.ShowDialog($ArchetypeCounterForm); If ($TDAllHuntResults.Text -match "Reset") { $ACAllHuntProfiles = @("Profile1", "Profile2", "Profile3", "Profile4", "Profile5", "Profile6", "Profile7", "Profile8", "Profile9", "Profile10"); $ACAllHuntProfiles | ForEach-Object { $ACAllHuntProfile = $_; $GetAllHuntProfilesPath = "$Global:CounterWorkingDir\stored\$ACAllHuntProfile\Config_$ACAllHuntProfile.txt"; $GetAllHuntProfiles = [IO.File]::ReadAllLines($GetAllHuntProfilesPath); $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Egg_Count=.*", "Egg_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Fossil_Count=.*", "Fossil_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Encountered_Count=.*", "Encountered_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Alpha_Count=.*", "Alpha_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Legendary_Count=.*", "Legendary_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Shiny_Count=.*", "Shiny_Count=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Single_Battle=.*", "Single_Battle=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Double_Battle=.*", "Double_Battle=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Triple_Battle=.*", "Triple_Battle=0"; $GetAllHuntProfiles = $GetAllHuntProfiles -replace "Horde_Battle=.*", "Horde_Battle=0"; [IO.File]::WriteAllLines($GetAllHuntProfilesPath, $GetAllHuntProfiles); Clear-Content -Path "$Global:CounterWorkingDir\stored\$ACAllHuntProfile\Config_$($ACAllHuntProfile)_Encountered.txt"; . RemoveDialogTransparentBackground; [System.Threading.Thread]::Sleep(25); Start-Process "$Global:CounterWorkingDir\ArchetypeCounter.bat" -NoNewWindow -Wait } }; . RemoveDialogTransparentBackground })
    $MenuItem_ToggleDebugWindow.add_Click({ $SW_HIDE = 0; $SW_SHOW = 9; $hWndConsole = [GrabConsole]::GetConsoleWindow(); $isConsoleVisible = [GrabConsole]::ShowWindow($hWndConsole, $SW_HIDE); if (-not $isConsoleVisible) { [GrabConsole]::ShowWindow($hWndConsole, $SW_SHOW) } else { [GrabConsole]::ShowWindow($hWndConsole, $SW_HIDE) } })
    $MenuItem_Uninstall.add_Click({ . SetDialogTransparentBackground; $ClickableLink = "https://github.com/ssjshields/archetype-counter"; $GithubHyperLink = "<a href=""$ClickableLink"">Github</a>"; $TaskDialog = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialog.WindowTitle = "Archetype Counter"; $TaskDialog.ButtonStyle = 'CommandLinks'; $TaskDialog.CustomMainIcon = $ArchetypeCounterSystrayIcon; $TaskDialog.MainInstruction = "Do you want to Uninstall?"; $TaskDialog.Content = "Hope you enjoyed using the Counter :)"; $TaskDialog.EnableHyperlinks = $true; $TaskDialog.Footer = "Please visit the official $GithubHyperLink if you are having issues."; $TaskDialog.FooterIcon = 'Information'; $TaskDialogUninstall = [Ookii.Dialogs.WinForms.TaskDialogButton]::new(); $TaskDialogUninstall.Text = 'Uninstall'; $TaskDialogUninstall.CommandLinkNote = 'Perform removing the Counter.'; $TaskDialogNo = [Ookii.Dialogs.WinForms.TaskDialogButton]::new(); $TaskDialogNo.Text = 'No'; $TaskDialogNo.CommandLinkNote = 'Cancel removing the Counter.'; $TaskDialog.AllowDialogCancellation = $true; $TaskDialog.Buttons.Add($TaskDialogUninstall); $TaskDialog.Buttons.Add($TaskDialogNo); $TaskDialog.Add_HyperlinkClicked({ Start-Process $ClickableLink }); [System.Media.SystemSounds]::Exclamation.Play(); $UninstallACDialog = $TaskDialog.ShowDialog($ArchetypeCounterForm); if ($UninstallACDialog.Text -match "Uninstall") { [System.Windows.MessageBox]::Show("Thank you for using Archetype Counter!","Archetype Counter","OK","Asterisk"); $GetThemeItems = Get-ChildItem -Path "$PokeMMOWorkingDir\data\themes"; $GetThemeItems = $GetThemeItems | Where-Object { $_.PSIsContainer }; $ThemeNames = $GetThemeItems| Select-Object -ExpandProperty Name; Get-Process -Name javaw | Stop-Process -Force; foreach ($ThemeName in $ThemeNames) { $SetThemeConfig = "$PokeMMOWorkingDir\data\themes\$ThemeName\theme.xml"; $GetThemeConfig = [IO.File]::ReadAllLines("$SetThemeConfig"); Remove-Item "$PokeMMOWorkingDir\data\themes\$ThemeName\AC" -Recurse -Force; $GetThemeConfig = $GetThemeConfig -replace '<include filename="AC/1.0_Scaling.xml"/>',''; [System.Threading.Thread]::Sleep(10); [IO.File]::WriteAllLines($SetThemeConfig, $GetThemeConfig) }; Remove-Item -Path "HKCU:\Software\Classes\AppUserModelId\Archetype.PokeMMO.ArchetypeCounter!App" -Force -Recurse; Start-Process -WindowStyle hidden "$Global:CounterWorkingDir\lib\Uninstaller\Uninstaller.bat"; . RemoveDialogTransparentBackground; [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force }; . RemoveDialogTransparentBackground })

    # Captures a click event on the counter notifyicon in system tray on taskbar
    $ArchetypeCounterSystray.add_MouseDown({  

        # Checks if right mouse click is used
        if ($_.Button -eq [System.Windows.Forms.MouseButtons]::Right) {

            # Clears all menuitems from the "Encountered" selection
            $MenuItem_Encountered.MenuItems.Clear()

            # Re-loads the encountered values into counter menu
            . AddDynamicPokemonList
            . AddDynamicEncounteredButton

        }
    
    })

    # Mouse move event for the system tray app/icon
    $ArchetypeCounterSystray.add_MouseMove({

        # Re-loads all variables
        . LoadExternalVariables

        # Re-sets the counter hover text
        $ArchetypeCounterSystray.Text = "Archetype Counter`r$ACTrayEncounterSymbol $EncounteredCount / $ACTrayEggSymbol $EggCount / $ACTrayFossilSymbol $FossilCount"

        # Re-sets the counter tracked values
        $MenuItem_Encountered.Text = "Encountered ($EncounteredCount)"
        $MenuItem_Egg.Text = "Egg ($EggCount)"
        $MenuItem_Fossil.Text = "Fossil ($FossilCount)"
        $MenuItem_AlphaCount.Text = "Alpha ($AlphaCount)"
        $MenuItem_LegendaryCount.Text = "Legendary ($LegendaryCount)"
        $MenuItem_ShinyCount.Text = "Shiny ($ShinyCount)"

    })

    # Adds click to "Exit" Counter selection
    $MenuItem_Exit.add_Click({  

        # Checks for PokeMMO process and if it needs to be closed or not
        . CheckPokeMMOProcess
        if ($ClosePokeMMO -match 'YesClose') { if ($Global:PokeMMO_hwnd -ne $null) { $GrabPokeMMOID = (Get-Process | Where-Object {$_.MainWindowHandle -eq $Global:PokeMMO_hwnd}).Id; Stop-Process -Id $GrabPokeMMOID -Force; [System.Threading.Thread]::Sleep(25) } }

        # Removes fake UAC dialog background
        . RemoveDialogTransparentBackground

        # Sets current overlay location when launching/restarting counter
        $GetConfigSettings = $GetConfigSettings -replace "Overlay_Left=.*", "Overlay_Left=$($ArchetypeCounterOverlay.Left)" -replace "Overlay_Top=.*", "Overlay_Top=$($ArchetypeCounterOverlay.Top)"; $ArchetypeCounterSystray.Visible = $false; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings); [System.Threading.Thread]::Sleep(25)

        # Removes Toast notification for only AC (Ensures the notification is cleared)
        ([Windows.UI.Notifications.ToastNotificationManager]::History).Clear('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'); ([Windows.UI.Notifications.ToastNotificationManager]::History).Clear('Archetype.PokeMMO.ArchetypeCounter!App')

        # Ensures System tray icon is hidden before application closes
        $ArchetypeCounterSystray.Visible = $false; $ArchetypeCounterSystray.Dispose()

        # This exits the application (Winform) properly 
        [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force

    })

    ##############################
    # -------------------------- #
    # --- WPF OVERLAY WINDOW --- #
    # -------------------------- #
    ##############################

    # Loads values from external source (Config_OverlaySettings) 
    $SetConfigOverlay = "$Global:CounterWorkingDir\stored\Config_OverlaySettings.txt"
    $GetConfigOverlay = [IO.File]::ReadAllLines("$SetConfigOverlay")
    $AC_NormalSymbol = $GetConfigOverlay -match "Normal_Symbol="; $AC_NormalSymbol = $AC_NormalSymbol -replace "Normal_Symbol=", ""
    $AC_BusySymbol = $GetConfigOverlay -match "Busy_Symbol="; $AC_BusySymbol = $AC_BusySymbol -replace "Busy_Symbol=", ""
    $AC_WithSymbol = $GetConfigOverlay -match "With_Symbol="; $AC_WithSymbol = $AC_WithSymbol -replace "With_Symbol=", ""
    $AC_FontType = $GetConfigOverlay -match "Font_Type="; $AC_FontType = $AC_FontType -replace "Font_Type=", ""
    $AC_FontColor = $GetConfigOverlay -match "Font_Color="; $AC_FontColor = $AC_FontColor -replace "Font_Color=", ""
    $AC_FontPadding = $GetConfigOverlay -match "Font_Padding="; $AC_FontPadding = $AC_FontPadding -replace "Font_Padding=", ""
    $AC_FontSize = $GetConfigOverlay -match "Font_Size="; $AC_FontSize = $AC_FontSize -replace "Font_Size=", ""
    $AC_FontStyle = $GetConfigOverlay -match "Font_Style="; $AC_FontStyle = $AC_FontStyle -replace "Font_Style=", ""
    $AC_FontWeight = $GetConfigOverlay -match "Font_Weight="; $AC_FontWeight = $AC_FontWeight -replace "Font_Weight=", ""
    $AC_FontSmoothing = $GetConfigOverlay -match "Font_Smoothing="; $AC_FontWeight = $AC_FontWeight -replace "Font_Smoothing=", ""
    $AC_FontOpacity = $GetConfigOverlay -match "Font_Opacity="; $AC_FontOpacity = $AC_FontOpacity -replace "Font_Opacity=", ""; $AC_FontOpacity = $AC_FontOpacity -join '-'
    $AC_FontBGColor = $GetConfigOverlay -match "Font_Background_Color="; $AC_FontBGColor = $AC_FontBGColor -replace "Font_Background_Color=", ""
    $AC_FontBGOpacity = $GetConfigOverlay -match "Font_Background_Opacity="; $AC_FontBGOpacity = $AC_FontBGOpacity -replace "Font_Background_Opacity=", ""; $AC_FontBGOpacity = $AC_FontBGOpacity -join '-'
    $AC_Multiline = $GetConfigOverlay -match "Multiline="; $AC_Multiline = $AC_Multiline -replace "Multiline=", ""
    $AC_MultilineCount = $GetConfigOverlay -match "Multiline_Count="; $AC_MultilineCount = $AC_MultilineCount -replace "Multiline_Count=", ""; $AC_MultilineCount = $AC_MultilineCount -join '-'; $AC_MultilineCount = [int]$AC_MultilineCount

    # Archetype Counter Overlay (WPF Form/Window)
    $ArchetypeCounterOverlay = New-Object Windows.Window
    $ArchetypeCounterOverlay.Icon = [System.Windows.Media.Imaging.BitmapFrame]::Create([System.Uri]::new("$Global:CounterWorkingDir\icons\Archetype.ico"))
    $ArchetypeCounterOverlay.Title = 'Archetype Counter GUI Overlay'
    $ArchetypeCounterOverlay.WindowStyle = 'None'
    $ArchetypeCounterOverlay.ResizeMode = 'NoResize'
    $ArchetypeCounterOverlay.AllowsTransparency = $true 
    $ArchetypeCounterOverlay.Background = [Windows.Media.Brushes]::Transparent
    $ArchetypeCounterOverlay.SizeToContent = "WidthAndHeight"
    $ArchetypeCounterOverlay.Topmost = $true
    $ArchetypeCounterOverlay.ShowInTaskbar = $false
    if ($OverlayLeft -match "-123" -and $OverlayTop -match "-123") { $ArchetypeCounterOverlay.WindowStartupLocation = "CenterScreen" } else { $ArchetypeCounterOverlay.WindowStartupLocation = "Manual" }
    $ArchetypeCounterOverlay.Left = "$OverlayLeft"
    $ArchetypeCounterOverlay.Top = "$OverlayTop"
    $ArchetypeCounterOverlay.add_MouseLeftButtonDown({ $ArchetypeCounterOverlay.DragMove() })
    $ArchetypeCounterOverlayText = New-Object Windows.Controls.TextBlock
    $SetConfigProfileEncounteredOverlay = "$Global:CounterWorkingDir\stored\$GetProfile\Config_$($GetProfile)_Encountered.txt"; $GetConfigProfileEncounteredOverlay = [IO.File]::ReadAllLines($SetConfigProfileEncounteredOverlay) | Select-Object -First $AC_MultilineCount
    if ($AC_Multiline -match "True" -and $OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay -replace "#", "`n#" } elseif ($AC_Multiline -match "False" -and $OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay[0] }
    if ($OverlayMode -match "OnOverlayTotal" -and $AC_WithSymbol -match "True") { $OverlayDisplayText = "$AC_NormalSymbol $EncounteredCount" } elseif ($OverlayMode -match "OnOverlayTotal" -and $AC_WithSymbol -match "False") { $OverlayDisplayText = "$EncounteredCount" } 
    if ($OverlayMode -match "OnOverlayPokemon" -and $AC_Multiline -match "True" -and $AC_WithSymbol -match "True") { $OverlayDisplayText = "$AC_NormalSymbol $GetCurrentProfile ($EncounteredCount)$GetConfigProfileEncounteredOverlay" } elseif ($OverlayMode -match "OnOverlayPokemon" -and $AC_Multiline -match "False" -and $AC_WithSymbol -match "True") { $OverlayDisplayText = "$AC_NormalSymbol $GetConfigProfileEncounteredOverlay" } elseif ($OverlayMode -match "OnOverlayPokemon" -and $AC_Multiline -match "True" -and $AC_WithSymbol -match "False") { $OverlayDisplayText = "- $GetCurrentProfile ($EncounteredCount) -$GetConfigProfileEncounteredOverlay" } elseif ($OverlayMode -match "OnOverlayPokemon" -and $AC_Multiline -match "False" -and $AC_WithSymbol -match "False") { $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
    $ArchetypeCounterOverlayText.Text = "$OverlayDisplayText"
    $ArchetypeCounterOverlayText.HorizontalAlignment = 'Center'
    $ArchetypeCounterOverlayText.VerticalAlignment = 'Center'
    if ($AC_FontType -match "System") { } else { $ArchetypeCounterOverlayText.FontFamily = "$AC_FontType" }
    $ArchetypeCounterOverlayText.FontSize = "$AC_FontSize"
    $ArchetypeCounterOverlayText.Padding = "$AC_FontPadding"
    $ArchetypeCounterOverlayText.Foreground = "$AC_FontColor"
    $ArchetypeCounterOverlayText.Opacity = [double]$AC_FontOpacity
    $ArchetypeCounterOverlayText.FontWeight = "$AC_FontWeight"
    $ArchetypeCounterOverlayText.FontStyle = "$AC_FontStyle"
    $textBlockBGColor = "$AC_FontBGColor"
    $textBlockBGOpacity = [double]$AC_FontBGOpacity
    $textBlockBGCombined = [System.Windows.Media.Color]::FromArgb([int]($textBlockBGOpacity * 255), [byte]::Parse($textBlockBGColor.Substring(1,2), 'Hex'), [byte]::Parse($textBlockBGColor.Substring(3,2), 'Hex'), [byte]::Parse($textBlockBGColor.Substring(5,2), 'Hex'))
    $ArchetypeCounterOverlayText.Background = New-Object Windows.Media.SolidColorBrush $textBlockBGCombined
    $ArchetypeCounterOverlay.Content = $ArchetypeCounterOverlayText
    $ArchetypeCounterOverlay.Width = $ArchetypeCounterOverlayText.ActualWidth
    $ArchetypeCounterOverlay.Height = $ArchetypeCounterOverlayText.ActualHeight
    if ($OverlayMode -match 'On') { $ArchetypeCounterOverlay.Show() > $null }
    
    ################################
    # ---------------------------- #
    # --- FINAL CODE EXECUTION --- #
    # ---------------------------- #
    ################################

    # Manual call for placing images on menuitems (VistaMenu)
    $ArchetypeVistaMenu.EndInit()

    # Properly closes Archetype Counter process if closed outside of normal application exit/close
    $null = Register-EngineEvent PowerShell.Exiting –Action { . RemoveDialogTransparentBackground; $ArchetypeCounterSystray.Visible = $false; $ArchetypeCounterSystray.Dispose(); [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force }

    # Resets the working directory back to the counter .bat file (Original location)
    Set-Location $Global:CounterWorkingDir

    # Sets every possible created variable as -scope of "Script" (This will attempt to override system variables - we just ignore)
    Get-Variable | ForEach-Object { Set-Variable -Name $_.Name -Scope Script -Value $_.Value -ErrorAction SilentlyContinue }

})

# Runs the active scanning loop (Main screen capture area - loop / Also do initial counter requirement checks to ensure user can utilize)
$ArchetypeCounterForm.Add_Shown({

    # Checks for PokeMMO process and if it needs to be closed or not
    . CheckPokeMMOProcess
    if ($OpenPokeMMO -match 'YesOpen') { if (!($Global:PokeMMO_hwnd -ne $null)) { Start-Process "$PokeMMOWorkingDir\PokeMMO.exe"; [System.Threading.Thread]::Sleep(1200) } }

    # Changes icon back to original icon
    $ArchetypeCounterSystray.Icon = $ArchetypeCounterSystrayIcon

    # Assigns created context menu into counter system tray (We do this once the entire Winform has been loaded)
    $ArchetypeCounterSystray.ContextMenu = $ArchetypecontextMenu

    # Checks if this is a counter first time usage (Initial Archetype Counter greeting)
    if ($CounterFirstTime -eq $true) { if (Test-Path "HKCU:\Software\Classes\AppUserModelId\Archetype.PokeMMO.ArchetypeCounter!App") { $ToastAppID = 'Archetype.PokeMMO.ArchetypeCounter!App' } else { $ToastAppID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe' }; New-BurntToastNotification -Silent -AppId "$ToastAppID" -AppLogo "$Global:CounterWorkingDir\icons\Success.png" -Text "Archetype Counter has been setup!", "You can access the Counter menu from the task tray. For further information, please review the README." }

    ###############################
    # --------------------------- #
    # --- PREREQUISITE CHECKS --- #
    # --------------------------- #
    ###############################

    # Checks if Windows OS is 64-bit (for Tesseract OCR)
    if ([Environment]::Is64BitOperatingSystem -match $false) { . SetDialogTransparentBackground; $TaskDialog64Bit = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialog64Bit.WindowTitle = "Archetype Counter"; $TaskDialog64Bit.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialog64Bit.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Error; $TaskDialog64Bit.MainInstruction = "Unsupported OS Architecture"; $TaskDialog64Bit.Content = "Please install the Counter on a 64-bit system."; $TaskDialog64Bit.AllowDialogCancellation = $true; $TaskDialog64Bit.Buttons.Add('Ok'); $TaskDialog64Bit.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground; [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force  }

    # Checks if Windows Version is either Windows 1o or 11.
    if ($WindowsVersion -match "Windows 10" -or $WindowsVersion -match "Windows 11") { } else { . SetDialogTransparentBackground; $TaskDialogOSVersion = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogOSVersion.WindowTitle = "Archetype Counter"; $TaskDialogOSVersion.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialogOSVersion.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Error; $TaskDialogOSVersion.MainInstruction = "Unsupported Windows Version"; $TaskDialogOSVersion.Content = "Please install the Counter on Windows 10/11."; $TaskDialogOSVersion.AllowDialogCancellation = $true; $TaskDialogOSVersion.Buttons.Add('Ok'); $TaskDialogOSVersion.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground; [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force }

    # Checks if counter is in the "mods" folder of PokeMMO
    Set-Location ..\..
    $CurrentACDirectory = Split-Path -Path ($PWD) -Leaf; if (!($CurrentACDirectory -match "mods")) { . SetDialogTransparentBackground; $TaskDialogIncorrectInstall = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogIncorrectInstall.WindowTitle = "Archetype Counter"; $TaskDialogIncorrectInstall.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Error; $TaskDialogIncorrectInstall.ButtonStyle = 'CommandLinks'; $TaskDialogIncorrectInstall.MainInstruction = "Incorrect Install Detection"; $TaskDialogIncorrectInstall.Content = "Archetype Counter is not installed properly.`n`nExtract counter to the correct location.`n- Path: PokeMMO\data\mods"; $TaskDialogIncorrectInstall.AllowDialogCancellation = $true; $TaskDialogIncorrectInstall.Buttons.Add('Ok');$TaskDialogIncorrectInstall.Footer = "Current location: $CurrentACDirectory"; $TaskDialogIncorrectInstall.FooterIcon = 'Information'; $TaskDialogIncorrectInstall.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground  }
    Set-Location $Global:CounterWorkingDir

    # Checks if user had Fullscreen mode in PokeMMO - If matches the counter will not do anything
    if ($GetMainProperties | Where-Object { $_ -match '\bclient.graphics.display_mode=1\b' }) { . SetDialogTransparentBackground; $TaskDialogFullscreen = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogFullscreen.WindowTitle = "Archetype Counter"; $TaskDialogFullscreen.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialogFullscreen.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Error; $TaskDialogFullscreen.MainInstruction = "PokeMMO Fullscreen Detection"; $TaskDialogFullscreen.Content = "The Counter requires PokeMMO to be in either Windowed or Borderless mode in order to function properly."; $TaskDialogFullscreen.AllowDialogCancellation = $true; $TaskDialogFullscreen.Buttons.Add('Ok'); $TaskDialogFullscreen.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground; [System.Windows.Forms.Application]::Exit(); Stop-Process $PID -Force}

    # Checks if Toast Notifications are ON or OFF in Windows Action Center
    if ($ToastNotificationDialog -match "Show") { if ($IsToastNotificationEnabled -match "0") { . SetDialogTransparentBackground; $TaskDialogToastNotify = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogToastNotify.WindowTitle = "Archetype Counter"; $TaskDialogToastNotify.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialogToastNotify.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Warning; $TaskDialogToastNotify.MainInstruction = "Toast Notification Detection"; $TaskDialogToastNotify.Content = "Please turn notifications ON in the Windows Action Center to avoid limited functionality."; $TaskDialogToastNotify.VerificationText = 'Do not show this message again'; $TaskDialogToastNotify.AllowDialogCancellation = $true; $TaskDialogToastNotify.Buttons.Add('Ok'); $TaskDialogToastNotify.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground; if ($TaskDialogToastNotify.IsVerificationChecked -eq $true) { $GetConfigSettings = $GetConfigSettings -replace "Toast_Notification_Dialog=.*", "Toast_Notification_Dialog=Ignore"; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings) } } }

    # Checks if ReShade is being used with PokeMMO
    if ($ReShadeAlertDialog -match "Show") { $ReShadeinPokeMMO = ''; if (Test-Path "$PokeMMOWorkingDir\ReShade.ini") { $ReShadeinPokeMMO = '(ReShade being used)'; . SetDialogTransparentBackground; $TaskDialogReShade = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogReShade.WindowTitle = "Archetype Counter"; $TaskDialogReShade.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialogReShade.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Warning; $TaskDialogReShade.MainInstruction = "ReShade Detection"; $TaskDialogReShade.Content = "Using post processing filters like ReShade can produce inaccurate count results. Please disable ReShade before reporting any bugs."; $TaskDialogReShade.VerificationText = 'Do not show this message again'; $TaskDialogReShade.AllowDialogCancellation = $true; $TaskDialogReShade.Buttons.Add('Ok'); $TaskDialogReShade.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground }; if ($TaskDialogReShade.IsVerificationChecked -eq $true) { $GetConfigSettings = $GetConfigSettings -replace "ReShade_Alert_Dialog=.*", "ReShade_Alert_Dialog=Ignore"; [IO.File]::WriteAllLines($SetConfigSettings, $GetConfigSettings) } }

    # Checks if "AC" folder has been added into current theme
    $CurrentTheme = $GetMainProperties -match "client.ui.theme="; $CurrentTheme = $CurrentTheme -replace 'client.ui.theme=', ''
    $ThemeXMLCheck = "$PokeMMOWorkingDir\data\themes\$CurrentTheme\theme.xml"
    $ReadThemeXMLCheck = [IO.File]::ReadAllLines("$ThemeXMLCheck"); if ($ReadThemeXMLCheck -match '<include filename="AC/1.0_Scaling.xml"/>') { $MatchThemeXML = "True" } else { $MatchThemeXML = "False" }   
    if ((Test-Path -Path "$PokeMMOWorkingDir\data\themes\$CurrentTheme\AC") -and ($MatchThemeXML -match "True")) { } else { $InsertInThemePath = "$PokeMMOWorkingDir\data\themes\$CurrentTheme\theme.xml"; $InsertInTheme = [IO.File]::ReadAllLines("$InsertInThemePath"); $InsertInTheme = $InsertInTheme -replace '</themes>', '    <include filename="AC/1.0_Scaling.xml"/>       
</themes>'; [IO.File]::WriteAllLines($InsertInThemePath, $InsertInTheme); Copy-Item "$Global:CounterWorkingDir\lib\AC" -Destination "$PokeMMOWorkingDir\data\themes\$CurrentTheme" -Recurse -Force; . SetDialogTransparentBackground; $TaskDialogTheme = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogTheme.WindowTitle = "Archetype Counter"; $TaskDialogTheme.WindowIcon = $ArchetypeCounterSystrayIcon; $TaskDialogTheme.MainIcon = [Ookii.Dialogs.WinForms.TaskDialogIcon]::Information; $TaskDialogTheme.MainInstruction = "Archetype Theme Modifier"; $TaskDialogTheme.Content = "Current Theme: $CurrentTheme`n`nValues in the current PokeMMO theme interface will be modified so it can support OCR detection."; $TaskDialogTheme.CollapsedControlText = 'Learn More'; $TaskDialogTheme.ExpandedInformation = "These are slight adjustments to the font used for Pokémon names in battle. The amount they are changed is almost unnoticeable to the eye. You may revert these modifications at any time by repairing your client.`n`nTechnical mumbo-jumbo: OCR detection will not trigger without a readable font def and inset because letters such as; g, j, p, y, etc. hang over the HP bars."; $TaskDialogTheme.AllowDialogCancellation = $true; $TaskDialogTheme.Buttons.Add('Ok'); $TaskDialogTheme.ShowDialog($ArchetypeCounterForm); . RemoveDialogTransparentBackground; $PokeMMOProcess = Get-Process | where {$_.mainWindowTItle } | where {$_.Name -like "javaw" }; if ($PokeMMOProcess -eq $null) { } else { Stop-Process -Name "PokeMMO" -Force; Stop-Process -Name "javaw" -Force; Start-Process "$PokeMMOWorkingDir\PokeMMO.exe" } }

    # Force the "AC" folder to be placed everytime (For future build/releases)
    Copy-Item "$Global:CounterWorkingDir\lib\AC" -Destination "$PokeMMOWorkingDir\data\themes\$CurrentTheme" -ErrorAction SilentlyContinue -Recurse -Force

    # Forces a slight "tint" on the main.png atlas file (This ensures the sleep icon is never an issue)
    Set-Location "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29"
    $CheckImageComment = ./magick.exe identify "$PokeMMOWorkingDir\data\sprites\atlas\main.png" -verbose "$PokeMMOWorkingDir\data\sprites\atlas\main.png"
    if (!($CheckImageComment -match "Archetype Counter")) { ./magick.exe "$PokeMMOWorkingDir\data\sprites\atlas\main.png" -set comment "Archetype Counter" "$PokeMMOWorkingDir\data\sprites\atlas\main.png"; ./magick.exe "$PokeMMOWorkingDir\data\sprites\atlas\main.png" -channel B -evaluate Multiply 1.1 "$PokeMMOWorkingDir\data\sprites\atlas\main.png" }
    Set-Location $Global:CounterWorkingDir

    # Sets every possible created variable as -scope of "Script" (This will attempt to override system variables - we just ignore)
    Get-Variable | ForEach-Object { Set-Variable -Name $_.Name -Scope Script -Value $_.Value -ErrorAction SilentlyContinue }

    ###############################
    # --------------------------- #
    # --- RUNSPACE PROCESSING --- #
    # --------------------------- #
    ###############################

    # Created HashTable to pass winform controls to new runspace and back
    $Script:SyncHashTable = [Hashtable]::Synchronized(@{})
    $Script:SyncHashTable.ArchetypeCounterForm = $ArchetypeCounterForm
    $Script:SyncHashTable.ArchetypeCounterSystray = $Script:ArchetypeCounterSystray
    $Script:SyncHashTable.ArchetypeContextMenu = $ArchetypeContextMenu
    $Script:SyncHashTable.GetProfile = $GetProfile
    $Script:SyncHashTable.GetCurrentProfile = $GetCurrentProfile
    $Script:SyncHashTable.EncounteredCount = $EncounteredCount
    $Script:SyncHashTable.PictureMode = $PictureMode
    $Script:SyncHashTable.ChineseMode = $ChineseMode
    $Script:SyncHashTable.SortingMode = $SortingMode
    $Script:SyncHashTable.SpriteMode = $SpriteMode
    $Script:SyncHashTable.NotifyMode = $NotifyMode
    $Script:SyncHashTable.NotifyMilestone = $NotifyMilestone
    $Script:SyncHashTable.OverlayMode = $OverlayMode
    $Script:SyncHashTable.OpenPokeMMO = $OpenPokeMMO
    $Script:SyncHashTable.ShowFailedScans = $ShowFailedScans
    $Script:SyncHashTable.ShinyDialogIcon = $ShinyDialogIcon
    $Script:SyncHashTable.ArchetypeCounterSystrayIcon = $ArchetypeCounterSystrayIcon
    $Script:SyncHashTable.ArchetypeCounterSystrayIconBusy = $ArchetypeCounterSystrayIconBusy
    $Script:SyncHashTable.ArchetypeCounterSystrayIconIdle = $ArchetypeCounterSystrayIconIdle
    $Script:SyncHashTable.GetMainProperties = $GetMainProperties
    $Script:SyncHashTable.GetConfigProfile = $GetConfigProfile
    $Script:SyncHashTable.SetConfigProfile = $SetConfigProfile
    $Script:SyncHashTable.GetConfigSettings = $GetConfigSettings
    $Script:SyncHashTable.SetConfigSettings = $SetConfigSettings
    $Script:SyncHashTable.ReShadeinPokeMMO = $ReShadeinPokeMMO
    $Script:SyncHashTable.MenuItem_Encountered = $MenuItem_Encountered
    $Script:SyncHashTable.MenuItem_Egg = $MenuItem_Egg
    $Script:SyncHashTable.MenuItem_Fossil = $MenuItem_Fossil
    $Script:SyncHashTable.MenuItem_AlphaCount = $MenuItem_AlphaCount
    $Script:SyncHashTable.MenuItem_LegendaryCount = $MenuItem_LegendaryCount
    $Script:SyncHashTable.MenuItem_ShinyCount = $MenuItem_ShinyCount
    $Script:SyncHashTable.MenuItem_Hunt = $MenuItem_Hunt
    $Script:SyncHashTable.MenuItem_Settings = $MenuItem_Settings
    $Script:SyncHashTable.MenuItem_TestToastNotification = $MenuItem_TestToastNotification
    $Script:SyncHashTable.ArchetypeCounterOverlay = $ArchetypeCounterOverlay
    $Script:SyncHashTable.ArchetypeCounterOverlayText = $ArchetypeCounterOverlayText
    $Script:SyncHashTable.AC_NormalSymbol = $AC_NormalSymbol
    $Script:SyncHashTable.AC_BusySymbol = $AC_BusySymbol
    $Script:SyncHashTable.AC_WithSymbol = $AC_WithSymbol
    $Script:SyncHashTable.AC_Multiline = $AC_Multiline
    $Script:SyncHashTable.AC_MultilineCount = $AC_MultilineCount
    
    # Creates a Runspace to run in a separate thread
    $Script:RunSpace = [Management.Automation.Runspaces.RunspaceFactory]::CreateRunspace()
    $Script:RunSpace.ApartmentState = "STA"
    $Script:RunSpace.ThreadOptions = "ReuseThread"
    $Script:RunSpace.Open()
    $Script:RunSpace.SessionStateProxy.SetVariable("SyncHashTable",$Script:SyncHashTable)
    $PowerShellCmd = [Management.Automation.PowerShell]::Create().AddScript({

        ###################################
        # ------------------------------- #
        # --- RUNNING SCRIPT LOCATION --- # 
        # ------------------------------- #
        ###################################

        # Grabs current working directory/location (For Archetype Counter)
        $Global:CounterWorkingDir = $PWD

        # Resets counter working directory to the PokeMMO main root directory & adds as variable
        Set-Location ..\..; Set-Location ..\..; $PokeMMOWorkingDir = $PWD

        # Resets the working directory back to the counter .bat file (Original location)
        Set-Location $Global:CounterWorkingDir

        ###############################
        # --------------------------- #
        # --- REQUIRED ASSEMBLIES --- #
        # --------------------------- #
        ###############################

        # All assemblies needed for counter loop (Re-loading due to PowerShell Runspace)
        Add-Type -AssemblyName System.Windows.Forms, System.Drawing, PresentationCore, Presentationframework, WindowsFormsIntegration, UIAutomationClient 2>$null
        [Void][System.Windows.Forms.Application]::EnableVisualStyles()
        [Void][System.Windows.Forms.Application]::SetCompatibleTextRenderingDefault($false)

        ########################################
        # ------------------------------------ #
        # --- C# PORTED CODE & DLL IMPORTS --- #
        # ------------------------------------ #
        ########################################

        # Adds/Loads the external libraries that help fuel the counter.
        Add-Type -Path "$Global:CounterWorkingDir\lib\Tesseract-OCR-5.3.2x64\bin\tesseract.dll"
        Add-Type -Path "$Global:CounterWorkingDir\lib\PrintWindowStream-1.0\PrintWindowStream.dll"
        Add-Type -Path "$Global:CounterWorkingDir\lib\Ookii.Dialogs.Winforms-1.2.0\Ookii.Dialogs.WinForms.dll"
        "$Global:CounterWorkingDir\lib\BurntToast-0.8.5\*" | gci -include '*.psm1','*.psd1' | Import-Module

        # Adds/Loads "GetWindowRect" to go after PokeMMO window size & location on screen (For ScreenShot - Not PrintWindow)
        Add-Type @'
        using System;
        using System.Runtime.InteropServices;

        public class Window {
            [DllImport("user32.dll")]
            [return: MarshalAs(UnmanagedType.Bool)]
            public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
        }

        public struct RECT
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }
'@

        ################################
        # ---------------------------- #
        # --- PRE-PROCESSING LOGIC --- #
        # ---------------------------- #
        ################################
        
        # Take screenshot of PokeMMO (PrintWindow) - Function
        Function PokeMMOPrintWindow { if ([string]::IsNullOrEmpty($ScreenCapture) -match $true) { $ScreenCapture = [ScreenCapture]::new() }; $ScreenshotStreamBitmap = [System.Drawing.Image]::FromStream($ScreenCapture.PrintWindow($Global:PokeMMO_hwnd)) }

        # Take screenshot of PokeMMO (PrintScreen) - Function
        Function PokeMMOScreenShot { $WindowRect = New-Object RECT; $GotWindowRect = [Window]::GetWindowRect($Global:PokeMMO_hwnd, [ref]$WindowRect); $GetPokeMMO_X = ConvertTo-Json($WindowRect)."Left"; $GetPokeMMO_Y = ConvertTo-Json($WindowRect)."Top"; $GetPokeMMO_Width = ConvertTo-Json($WindowRect)."Right"; $GetPokeMMO_Height = ConvertTo-Json($WindowRect)."Bottom"; $Screen = [System.Windows.Forms.Screen]::FromHandle($Global:PokeMMO_hwnd).Bounds; $Width = ([int]$GetPokeMMO_Width - [int]$GetPokeMMO_X) - 16; $Height = ([int]$GetPokeMMO_Height - [int]$GetPokeMMO_Y) - 39; $Left = [int]$GetPokeMMO_X + 8; $Top = [int]$GetPokeMMO_Y + 31; $ScreenshotStreamBitmap = New-Object System.Drawing.Bitmap $Width, $Height; $BuiltGraphic = [System.Drawing.Graphics]::FromImage($ScreenshotStreamBitmap); $BuiltGraphic.CopyFromScreen($Left, $Top, 0, 0, $ScreenshotStreamBitmap.Size); $BuiltGraphic.Dispose() }

        # Checks for top left pixel to see if in battle (or not)
        Function CheckPixelIndicator { $BitMapAC = $ScreenshotStreamBitmap; $ACtable = @{}; foreach($h in 1..25) { foreach($w in 1..25) { $ACtable[$BitMapAC.GetPixel($w - 1,$h - 1)] = $true } }; $BitMapAC.Dispose(); $GetPixelColorTable = $ACtable.Keys; $GetPixelColor = $GetPixelColorTable.Name }

        # Checks if currently still in battle
        Function CheckForBattleEnd { While (($GetPixelColor -match '\b('+($PixelMatchArray -join '|')+')\b')) { [System.Threading.Thread]::Sleep(185); if ($Script:SyncHashTable.PictureMode -match "Primary") { . PokeMMOPrintWindow } else { . PokeMMOScreenShot }; $BitMapAC = $ScreenshotStreamBitmap; $ACtable = @{}; foreach($h in 1..25) { foreach($w in 1..25) { $ACtable[$BitMapAC.GetPixel($w - 1,$h - 1)] = $true } }; $GetPixelColorTable = $ACtable.Keys; $GetPixelColor = $GetPixelColorTable.Name; $BitMapAC.Dispose() } }

        # Triggers a Toast Notification indicating the total current count and count for the specific Pokemon - Image dimensions are 48x48 pixels at 100% scaling (Need to make PokeMMO icons this image dimension)
        Function ToastCounterNotify { if ([string]::IsNullOrEmpty($OCRCaptureEncounteredNumber)) { $OCRCaptureEncounteredNumber = [int]1 }; $PokemonToastNotify = "$Global:CounterWorkingDir\icons\sprites\$($Script:SyncHashTable.SpriteMode)\$CapturedPokemonID.png"; if (Test-Path "HKCU:\Software\Classes\AppUserModelId\Archetype.PokeMMO.ArchetypeCounter!App") { $ToastAppID = 'Archetype.PokeMMO.ArchetypeCounter!App'; $ToastAppTitle = "Encountered Total: $OCRCapturedTotal" } else { $ToastAppID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'; $ToastAppTitle = "Archetype Counter (Encountered: $OCRCapturedTotal)" }; $BT_Header = New-BTHeader -Id 'Archetype Counter' -Title "$ToastAppTitle"; if ($OCRCapturedLines -eq 2 -and $OCRCaptured[0] -ne $OCRCaptured[1]) { New-BurntToastNotification -Silent -AppId "$ToastAppID" -AppLogo $PokemonToastNotify -Text "$($OCRCaptured[1]) (x1) / $($OCRCaptured[0]) (x1)", "Current Count: $($EncounterNumberDBArray[1]) / $($EncounterNumberDBArray[0])" -Header $BT_Header } else { New-BurntToastNotification -Silent -AppId "$ToastAppID" -AppLogo $PokemonToastNotify -Text "#$CapturedPokemonID $CapturedPokemonName (x$OCRCapturedLines)", "Current Count: $OCRCaptureEncounteredNumber" -Header $BT_Header }; Clear-Variable -Name OCRCaptureEncounteredNumber; $ToastBool = $false }

        # Removes Toast notification for only AC (Ensures the notification is cleared in Windows Notification area)
        Function ClearToastNotifyForCounter { ([Windows.UI.Notifications.ToastNotificationManager]::History).Clear('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'); ([Windows.UI.Notifications.ToastNotificationManager]::History).Clear('Archetype.PokeMMO.ArchetypeCounter!App') }

        # Define a custom sorting function - Based on digits by Pokdex number
        Function CustomSortPokedexNumber { param ($line); $digitsMatch = [regex]::Match($line, '#\d{1,3}'); if ($digitsMatch.Success) { $digits = $digitsMatch.Value -replace '#', ''; $paddedDigits = $digits.PadLeft(3, '0'); return [int]$paddedDigits }; return 0 }

        # Define a custom sorting function - Based on digits in pokemon count
        Function CustomSortPokemonCount { param ($line); $digitsMatch = [regex]::Match($line, '\(\d{1,7}\)'); if ($digitsMatch.Success) { $digits = $digitsMatch.Value -replace '\(|\)', ''; $paddedDigits = $digits.PadLeft(7, '0'); return [int]$paddedDigits }; return 0 }

        # Define a custom sorting function - Based pokemon name for alphabetical order
        Function CustomSortPokemonName { param ($line); $cleanedLine = $line -replace '[^a-zA-Z]', ''; return $cleanedLine.ToLower() }

        # Creates the fake UAC dialog background
        Function SetDialogTransparentBackground { $Script:SyncHashTable.ArchetypeCounterForm.Opacity = 0.6; $Script:SyncHashTable.ArchetypeCounterForm.Visible = $true; $Script:SyncHashTable.ArchetypeCounterForm.WindowState = 'Maximized' }

        # Removes the fake UAC dialog background
        Function RemoveDialogTransparentBackground { $Script:SyncHashTable.ArchetypeCounterForm.WindowState = 'Minimized'; $Script:SyncHashTable.ArchetypeCounterForm.Visible = $false; $Script:SyncHashTable.ArchetypeCounterForm.Opacity = 0 }

        # Shiny/Egg/Fossil/Pixel detection "words/numbers" - Array(s)
        $ShinyMatchArray = @("Shiny","Variocolor","Chromatique","Cromatico","Schillernde","Brilhante","빛나는",'闪亮的','光沢のある')
        $AlphaMatchArray = @("Alpha","Alfa","알파포켓몬","우두머리")
        $LegendaryMatchArray = @('Suicune','スイクン','스이쿤','水君','Raikou','ライコウ','라이코','雷公','Entei','エンテイ','앤테이','炎帝','Articuno','Artikodin','Arktos','フリーザー','프리져','急冻鸟','急凍鳥','Zapdos','Électhor','サンダー','썬더','闪电鸟','閃電鳥','Moltres','Sulfura','Lavados','ファイヤー','파이어','火焰鸟','火焰鳥','Mewtwo','Mewtu','ミュウツー','뮤츠','超梦','超夢','Rayquaza','レックウザ','레쿠쟈','烈空坐','烈空坐','Keldeo','ケルディオ','케르디오','凯路迪欧','凱路迪歐','Arceus','アルセウス','아르세우스','阿尔宙斯','阿爾宙斯','Shaymin','シェイミ','쉐이미','谢米','謝米','Lugia','ルギア','루기아','洛奇亚','洛奇亞')
        $PixelMatchArray = @("fffb00fb","fd00fdff","f900f9ff","fb00fbff","fff900f9","fffd00fd")

        # Grabs PokeMMO console log to determine which Black/White ROM is being used
        $GetMainPokeMMOLog = Get-Content "$PokeMMOWorkingDir\log\console.log" -raw; if ($GetMainPokeMMOLog -match 'IRBO' -or $GetMainPokeMMOLog -match 'IRAO') { $GameLanguage = 'English'; $OCRLanguage ='eng' } elseif ($GetMainPokeMMOLog -match 'IRBS' -or $GetMainPokeMMOLog -match 'IRAS') { $GameLanguage = 'English'; $OCRLanguage ='eng' } elseif ($GetMainPokeMMOLog -match 'IRBF' -or $GetMainPokeMMOLog -match 'IRAF') { $GameLanguage = 'French'; $OCRLanguage ='fra' } elseif ($GetMainPokeMMOLog -match 'IRBD' -or $GetMainPokeMMOLog -match 'IRAD') { $GameLanguage = 'German'; $OCRLanguage ='deu' } elseif ($GetMainPokeMMOLog -match 'IRBJ' -or $GetMainPokeMMOLog -match 'IRAJ') { $GameLanguage = 'Japanese'; $OCRLanguage ='jpn' } elseif ($GetMainPokeMMOLog -match 'IRBK' -or $GetMainPokeMMOLog -match 'IRAK') { $GameLanguage = 'Korean'; $OCRLanguage ='kor' } else { $OCRLanguage = 'English' }; if ($Script:SyncHashTable.ChineseMode -match "Simplified") { $GameLanguage = 'ChineseSimplified'; $OCRLanguage ='chi_sim' } elseif ($Script:SyncHashTable.ChineseMode -match "Traditional") { $GameLanguage = 'ChineseTraditional'; $OCRLanguage ='chi_tra' } 
 
        # Grabs and loads + compares to the captures OCR text
        $SetPokeConfig = "$Global:CounterWorkingDir\stored\Config_PokemonNamesWithID_$GameLanguage.txt"
        $GetPokeConfig = [IO.File]::ReadAllLines($SetPokeConfig)

        # Loads values from from external source (Config_Profile?_Encountered)
        $EncounteredCurrentProfile = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile)_Encountered.txt"

        # PokeMMO GUI Scale (UI Scaling) / 1.0 = 1 / 1.25x = 0.8 / 1.5x = 0.6666667
        $GetMainPokeMMOScale = $Script:SyncHashTable.GetMainProperties -match "client.gui.scale.guiscale="; $GetMainPokeMMOScale = $GetMainPokeMMOScale -replace "client.gui.scale.guiscale=", ""

        # PokeMMO Battle Size / 100 = Default
        $GetMainPokeMMOBattleSize = $Script:SyncHashTable.GetMainProperties -match "client.graphics.battle.size="; $GetMainPokeMMOBattleSize = $GetMainPokeMMOBattleSize -replace "client.graphics.battle.size=", ""; $GetMainPokeMMOBattleSize = $GetMainPokeMMOBattleSize -join '-'

        # Sets every possible created variable as -scope of "Script" (This will attempt to override system variables - we just ignore)
        Get-Variable | ForEach-Object { Set-Variable -Name $_.Name -Scope Script -Value $_.Value -ErrorAction SilentlyContinue }

        ##################################################
        # ---------------------------------------------- #
        # --- COUNTER LOOP (WHERE THE MAGIC HAPPENS) --- #
        # ---------------------------------------------- #
        ##################################################

        # Do loop for the play functionality of the counter
        Do {

            # Small delay (To give the CPU a breathing moment - helps with CPU Usage)
            [System.Threading.Thread]::Sleep(185)

            # Resets back to counter working directory
            Set-Location $Global:CounterWorkingDir

            # Set the specific menuitems to be enabled = $true (Plus ensures System Tray icon stays "Visible" and does not hide.)
            $Script:SyncHashTable.ArchetypeCounterSystray.Visible = $true; $Script:SyncHashTable.MenuItem_Encountered.Enabled = $true; $Script:SyncHashTable.MenuItem_Egg.Enabled = $true; $Script:SyncHashTable.MenuItem_Fossil.Enabled = $true; $Script:SyncHashTable.MenuItem_AlphaCount.Enabled = $true; $Script:SyncHashTable.MenuItem_LegendaryCount.Enabled = $true; $Script:SyncHashTable.MenuItem_ShinyCount.Enabled = $true; $Script:SyncHashTable.MenuItem_Hunt.Enabled = $true; $Script:SyncHashTable.MenuItem_Settings.Enabled = $true; $Script:SyncHashTable.MenuItem_TestToastNotification.Enabled = $true

            # Grabs the PokeMMO window handle based on class name - GLFW30
            $AERootElement = [System.Windows.Automation.AutomationElement]::RootElement
            $WindowAT = $AERootElement.FindFirst([System.Windows.Automation.TreeScope]::Children,(New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ClassNameProperty, "GLFW30")))
            $Global:PokeMMO_hwnd = $WindowAT.Current.NativeWindowHandle

            # Grabs the current window state (Normal / Maximized / Minimized) of PokeMMO
            $WindowAE = [System.Windows.Automation.AutomationElement]::FromHandle($Global:PokeMMO_hwnd)
            $WindowAEPatternState = $WindowAE.GetCurrentPattern([System.Windows.Automation.WindowPatternIdentifiers]::Pattern)
            $PokeMMOWindowState = $WindowAEPatternState.Current.WindowVisualState

            # Checks if PokeMMO is active window
            if ($Global:PokeMMO_hwnd -ne $null -and $PokeMMOWindowState -notmatch 'Minimized') {

                # Debugging Loop Speed (WHEN NEEDED)
                # $GetLoopSpeed = Get-Date -Format HH:mm:ss.fff; $GetLoopSpeed = "$GetLoopSpeed`n"; [IO.File]::AppendAllText("$Global:CounterWorkingDir\LoopSpeed.txt", "$GetLoopSpeed")

                # Checks if Overlay Mode is "Off" (To prevent running overlay GUI dispatcher invoke)
                if ($Script:SyncHashTable.OverlayMode -notmatch "OffOverlay") { if (!($Script:SyncHashTable.ArchetypeCounterOverlay.IsVisible)) { $Script:SyncHashTable.ArchetypeCounterOverlayText.Dispatcher.Invoke([Action]{ $Script:SyncHashTable.ArchetypeCounterOverlay.Show() }, [Windows.Threading.DispatcherPriority]::Send) } }

                # Sets AC icon indicating counter is in "Normal" mode
                $Script:SyncHashTable.ArchetypeCounterSystray.Icon = $Script:SyncHashTable.ArchetypeCounterSystrayIcon

                # Checks/ensures counter memory usage does not exceed over set MB amount (Additional memory leak check)
                Clear-Variable -name ACProcessMemoryUsageMB -ErrorAction SilentlyContinue; $ACProcessMemoryUsageMB = [Math]::Round((Get-Process "Powershell" | Where-Object { $_.ID -eq $PID } | Select-Object Name,@{Name='MemoryUsage';Expression={($_.WorkingSet/1MB)}}).MemoryUsage); if ($ACProcessMemoryUsageMB -ge 650) { [System.GC]::Collect(); [System.GC]::WaitForPendingFinalizers() }

                # Clears/Reset specific variables (For loop)
                Clear-Variable -Name ScreenshotStreamBitmap, OCRCaptured, GetPixelColor, NotifyEncounterCount -ErrorAction SilentlyContinue

                # Loads values from external sources (Config_Profile?)
                $SetConfigProfile = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile).txt"
                $GetConfigProfile = [IO.File]::ReadAllLines("$SetConfigProfile")
                $EncounteredCount = $GetConfigProfile -match "Encountered_Count="; $EncounteredCount = $EncounteredCount -replace "Encountered_Count=", ""; $EncounteredCount = $EncounteredCount -join '-'
                $FossilCount = $GetConfigProfile -match "Fossil_Count="; $FossilCount = $FossilCount -replace "Fossil_Count=", ""; $FossilCount = $FossilCount -join '-'
                $EggCount = $GetConfigProfile -match "Egg_Count="; $EggCount = $EggCount -replace "Egg_Count=", ""; $EggCount = $EggCount -join '-'
                $AlphaCount = $GetConfigProfile -match "Alpha_Count="; $AlphaCount = $AlphaCount -replace "Alpha_Count=", ""; $AlphaCount = $AlphaCount -join '-'
                $LegendaryCount = $GetConfigProfile -match "Legendary_Count="; $LegendaryCount = $LegendaryCount -replace "Legendary_Count=", ""; $LegendaryCount = $LegendaryCount -join '-'
                $ShinyCount = $GetConfigProfile -match "Shiny_Count="; $ShinyCount = $ShinyCount -replace "Shiny_Count=", ""; $ShinyCount = $ShinyCount -join '-'
                $SingleBattle = $GetConfigProfile -match "Single_Battle="; $SingleBattle = $SingleBattle -replace "Single_Battle=", ""; $SingleBattle = $SingleBattle -join '-'
                $DoubleBattle = $GetConfigProfile -match "Double_Battle="; $DoubleBattle = $DoubleBattle -replace "Double_Battle=", ""; $DoubleBattle = $DoubleBattle -join '-'
                $TripleBattle = $GetConfigProfile -match "Triple_Battle="; $TripleBattle = $TripleBattle -replace "Triple_Battle=", ""; $TripleBattle = $TripleBattle -join '-'
                $HordeBattle = $GetConfigProfile -match "Horde_Battle="; $HordeBattle = $HordeBattle -replace "Horde_Battle=", ""; $HordeBattle = $HordeBattle -join '-'

                # Take/request screenshot of PokeMMO window
                if ($Script:SyncHashTable.PictureMode -match "Primary") { . PokeMMOPrintWindow } else { . PokeMMOScreenShot } # Add dots before function to expand the scope variable

                # Checks for pixel indicator in the top left screen (Outputs multiple pixel colors)
                . CheckPixelIndicator

                ######################################
                # ---------------------------------- #
                # --- BATTLE ENCOUNTER TRIGGERED --- #
                # ---------------------------------- #
                ######################################
              
                # Checks if pixel indicator matches (Start processing main logic)
                if ($GetPixelColor -match '\b('+($PixelMatchArray -join '|')+')\b') { 

                    # Clears all toast notifications generated by the counter
                    . ClearToastNotifyForCounter

                    # Checks if Overlay Mode is "Off" (To prevent running overlay GUI dispatcher invoke)
                    if ($Script:SyncHashTable.OverlayMode -notmatch "OffOverlay") {  

                        # Pushes GUI update (Dispatcher.Invoke) to WPF overlay window
                        $SetConfigProfileEncounteredOverlay = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile)_Encountered.txt"; $GetConfigProfileEncounteredOverlay = [IO.File]::ReadAllLines($SetConfigProfileEncounteredOverlay) | Select-Object -First $Script:SyncHashTable.AC_MultilineCount
                        if ($Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay -replace "#", "`n#" } elseif ($Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay[0]; $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $EncounteredCount" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $EncounteredCount } 
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $($Script:SyncHashTable.GetCurrentProfile) ($EncounteredCount)$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = "- $($Script:SyncHashTable.GetCurrentProfile) ($EncounteredCount) -$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        $Script:SyncHashTable.ArchetypeCounterOverlayText.Dispatcher.Invoke([Action]{ $Script:SyncHashTable.ArchetypeCounterOverlayText.Text = "$OverlayDisplayText" }, [Windows.Threading.DispatcherPriority]::Normal)

                    }

                    # Sets AC icon indicating counter is in "Busy" mode
                    $Script:SyncHashTable.ArchetypeCounterSystray.Icon = $Script:SyncHashTable.ArchetypeCounterSystrayIconBusy

                    # Set the specific menuitems to be enabled = $false
                    $Script:SyncHashTable.MenuItem_Encountered.Enabled = $false; $Script:SyncHashTable.MenuItem_Egg.Enabled = $false; $Script:SyncHashTable.MenuItem_Fossil.Enabled = $false; $Script:SyncHashTable.MenuItem_AlphaCount.Enabled = $false; $Script:SyncHashTable.MenuItem_LegendaryCount.Enabled = $false; $Script:SyncHashTable.MenuItem_ShinyCount.Enabled = $false; $Script:SyncHashTable.MenuItem_Hunt.Enabled = $false; $Script:SyncHashTable.MenuItem_Settings.Enabled = $false; $Script:SyncHashTable.MenuItem_TestToastNotification.Enabled = $false

                    # Re-show the ContextMenu (Off Screen) to simulate a refresh while having the counter menu opened when going into BUSY mode
                    $Script:SyncHashTable.ArchetypeContextMenu.Show($Script:SyncHashTable.ArchetypeCounterForm, [System.Drawing.Point]::new(-1000, -1000))

                    # Wait (For Pokemon name in battle - OCR scan)
                    [System.Threading.Thread]::Sleep(3890)
                
                    # Take/request screenshot of PokeMMO window
                    if ($Script:SyncHashTable.PictureMode -match "Primary") { . PokeMMOPrintWindow } else { . PokeMMOScreenShot }

                    # Sets current working directory to run ImageMagick processing without an issue
                    Set-Location "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29"

                    # Saves the "stored" image to location for ImageMagick filtering/cropping & then dispose
                    $ScreenshotStreamBitmap.Save("$PWD\ArchetypeScreenshot.tif"); $ScreenshotStreamBitmap.Disose()

                    # Pre-processing to ensure ArchetypeScreenshot image has no transparency or whitespaces
                    cmd.exe /c "magick ArchetypeScreenshot.tif -trim +repage ArchetypeScreenshot.tif"

                    # Pre-Cropping of the Battle Screen before ImageMagick filtering
                    $ArchetypeScreenshotEncounter = New-Object System.Drawing.Bitmap("$PWD\ArchetypeScreenshot.tif"); $GameWidth = $ArchetypeScreenshotEncounter.Width; $GameHeight = $ArchetypeScreenshotEncounter.Height; $BattleWidth = [math]::Ceiling(($GameWidth - 15.999)*0.7*(0.005725*$GetMainPokeMMOBattleSize+0.4275)); if ($BattleWidth -le "760") { $BattleWidth = "760" }; $XCropValue = [Math]::Floor(($GameWidth - 15.999 - $BattleWidth) / 2); $WCropValue = $BattleWidth; $RectImageEncounter = New-Object System.Drawing.Rectangle($XCropValue,50,$WCropValue,300); $CropSliceEncounter = $ArchetypeScreenshotEncounter.Clone($RectImageEncounter, $ArchetypeScreenshotEncounter.PixelFormat); $CropSliceEncounter.save("$PWD\ArchetypeScreenshotEncounter.tif"); $ArchetypeScreenshotEncounter.dispose(); $RectImageEncounter.Dispose()
                    
                    # Cropping calculations for ImageMagick filtering on Archetype Screenshot for OCR
                    # ---------------------------------------------------------
                    $ACImage = New-Object System.Drawing.Bitmap "$PWD\ArchetypeScreenshotEncounter.tif"; $ACImageWidth = $ACImage.Width; $ACImageWidth = [int]$ACImageWidth; $ACImage.Dispose()
                    # -- Crop 1 -----------------------------------------------
                    $crop1width = 260/"$GetMainPokeMMOScale"
                    $crop1height = 63/"$GetMainPokeMMOScale"
                    $crop1offsetX = 50/"$GetMainPokeMMOScale"
                    $crop1offsetY = 107/"$GetMainPokeMMOScale"-52
                    # -- Crop 2 -----------------------------------------------
                    $crop2width = 780/"$GetMainPokeMMOScale"
                    $crop2height = 21/"$GetMainPokeMMOScale" + 2
                    $crop2offsetX = $ACImageWidth/2-350/"$GetMainPokeMMOScale"
                    $crop2offsetY = 78/"$GetMainPokeMMOScale"-52
                    # -- Crop 3 -----------------------------------------------
                    $crop3offsetY= 118/"$GetMainPokeMMOScale"-52
                    # -- Crop 4 -----------------------------------------------
                    $crop4offsetX = $ACImageWidth/2+170/"$GetMainPokeMMOScale"
                    # -- Crop Final -------------------------------------------
                    $Crop1 = "$crop1width" + "x" + "$crop1height" + "+" + "$crop1offsetX" + "+" + "$crop1offsetY"
                    $Crop2 = "$crop2width" + "x" + "$crop2height" + "+" + "$crop2offsetX" + "+" + "$crop2offsetY"
                    $Crop3 = "$crop1width" + "x" + "$crop2height" + "+" + "$crop2offsetX" + "+" + "$crop3offsetY"
                    $Crop4 = "$crop1width" + "x" + "$crop2height" + "+" + "$crop4offsetX" + "+" + "$crop3offsetY"

                    # Properly filters out Archetype screenshot and isolates the Poke Name plates for OCR (Advanced Logic Filtering)
                    cmd.exe /c "magick ArchetypeScreenshotEncounter.tif ^ ( -clone 0 -crop $Crop1 ) ^ ( -clone 0 -crop $Crop2 ) ^ ( -clone 0 -crop $Crop3 ) ^ ( -clone 0 -crop $Crop4 ) ^ -delete 0 -background #000000 -flatten ArchetypeScreenshotEncounter.tif"
                    cmd.exe /c 'magick ArchetypeScreenshotEncounter.tif ^ ( +clone -colorspace HSL -channel S -separate -negate -fill black -fuzz 99.9% -opaque black ) ^ -alpha off -compose copy_opacity -composite ^ -background black -alpha remove -alpha off -colorspace Gray -despeckle -contrast -resize 200%x200% -density 300 -units pixelsperinch -threshold 55% ArchetypeScreenshotMagick.tif'

                    # Resets back to counter working directory
                    Set-Location $Global:CounterWorkingDir

                    # (DEBUG OUTPUT) *
                    [IO.File]::WriteAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "#######################################`n# ----------------------------------- #`n# --- ARCHETYPE COUNTER OCR DEBUG --- #`n# ----------------------------------- #`n#######################################`n`n")

                    # Sets working counter directory to Tesseract OCR
                    Set-Location "$Global:CounterWorkingDir\lib\Tesseract-OCR-5.3.2x64\bin"

                    # Run Tesseract OCR with correct language and parameters
                    if ($GameLanguage -match "English" -or $GameLanguage -match "French" -or $GameLanguage -match "German") { ./tesseract.exe "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29\ArchetypeScreenshotMagick.tif" ArchetypeCounterOCR -l $OCRLanguage --psm 6 } elseif ($GameLanguage -match "Korean") { ./tesseract.exe "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29\ArchetypeScreenshotMagick.tif" ArchetypeCounterOCR -l $OCRLanguage --psm 6 -c preserve_interword_spaces=1 } elseif ($GameLanguage -match "Japanese" -or $GameLanguage -match "ChineseSimplified" -or $GameLanguage -match "ChineseTraditional") { ./tesseract.exe "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29\ArchetypeScreenshotMagick.tif" ArchetypeCounterOCR -l $OCRLanguage --psm 6 -c chop_enable=T -c use_new_state_cost=F -c segment_segcost_rating=F -c enable_new_segsearch=0 -c language_model_ngram_on=0 -c textord_force_make_prop_words=F -c edges_max_children_per_outline=40 }

                    # Resets back to counter working directory
                    Set-Location $Global:CounterWorkingDir

                    # Grabs current OCR scanned text from "ArchetypeCounterOCR" text file
                    $OCRSetConfig = "$Global:CounterWorkingDir\lib\Tesseract-OCR-5.3.2x64\bin\ArchetypeCounterOCR.txt"; $OCRGetConfig = [IO.File]::ReadAllLines("$OCRSetConfig"); $OCRCaptured = $OCRGetConfig; Remove-Item $OCRSetConfig -Force

                    # (DEBUG OUTPUT) *
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "-------------------`n| Before Cleanup: |`n-------------------`n`n$OCRCaptured`n`n")

                    # Stores 'OCRCaptured' into a variable to check later (For Shiny Pokemon)
                    if (($OCRCaptured -match '\b('+($ShinyMatchArray -join '|')+')\b')) { $OCRCapturedShiny = $true } else { $OCRCapturedShiny = $false }

                    # Stores 'OCRCaptured' into a variable to check later (For Alpha Pokemon)
                    if (($OCRCaptured -match '\b('+($AlphaMatchArray -join '|')+')\b')) { $OCRCapturedAlpha = $true } else { $OCRCapturedAlpha = $false }

                    # Stores 'OCRCaptured' into a variable to check later (For Legendary Pokemon) 
                    if (($OCRCaptured -match '\b('+($LegendaryMatchArray -join '|')+')\b')) { $OCRCapturedLegendary = $true } else { $OCRCapturedLegendary = $false }

                    # Checks if OCRCapturedAlpha variable matches true
                    if ($OCRCapturedAlpha -match $true) {

                        # Adds value into counter menu (For Alpha)
                        $GetPokeAlphaCount = $AlphaCount; $SetPokeAlphaCount = [int]$GetPokeAlphaCount + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Alpha_Count=.*", "Alpha_Count=$SetPokeAlphaCount"; [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile)
                        
                    # Checks if OCRCapturedLegendary variable matches true
                    } elseif ($OCRCapturedLegendary -match $true) {

                        # Processes Legendary dialog and adding value into counter menu (For Legendary)
                        . SetDialogTransparentBackground; $TaskDialogLegendary = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogLegendary.WindowTitle = "Archtype Counter"; $TaskDialogLegendary.ButtonStyle = 'CommandLinks'; $TaskDialogLegendary.CustomMainIcon = $Script:SyncHashTable.ArchetypeCounterSystrayIcon; $TaskDialogLegendary.MainInstruction = "PokeMMO Legendary Detection"; $TaskDialogLegendary.Content = "You have found a LEGENDARY Pokémon!"; $TaskDialogLegendaryOk = [Ookii.Dialogs.WinForms.TaskDialogButton]::new(); $TaskDialogLegendaryOk.Text = 'Ok'; $TaskDialogLegendary.Footer = "Current Encountered Count: $EncounteredCount"; $TaskDialogLegendary.FooterIcon = 'Information'; $TaskDialogLegendary.AllowDialogCancellation = $true; $TaskDialogLegendary.Buttons.Add($TaskDialogLegendaryOk); $TaskDialogLegendary.ShowDialog($Script:SyncHashTable.ArchetypeCounterForm); . RemoveDialogTransparentBackground; $GetPokeLegendaryCount = $LegendaryCount; $SetPokeLegendaryCount = [int]$GetPokeLegendaryCount + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Legendary_Count=.*", "Legendary_Count=$SetPokeLegendaryCount"; [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile)

                    # Checks if OCRCapturedShiny variable matches true
                    } elseif ($OCRCapturedShiny -match $true) {

                        # Processes Shiny dialog and adding value into counter menu (For Shiny)
                        . SetDialogTransparentBackground; $TaskDialogShiny = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $TaskDialogShiny.WindowTitle = "Archtype Counter"; $TaskDialogShiny.ButtonStyle = 'CommandLinks'; $TaskDialogShiny.CustomMainIcon = $Script:SyncHashTable.ShinyDialogIcon; $TaskDialogShiny.MainInstruction = "PokeMMO Shiny Detection"; $TaskDialogShiny.Content = "You have found a SHINY Pokémon!"; $TaskDialogShinyOk = [Ookii.Dialogs.WinForms.TaskDialogButton]::new(); $TaskDialogShinyOk.Text = 'Ok'; $TaskDialogShinyOk.CommandLinkNote = 'Congratulations from the Archetype Team.'; $TaskDialogShiny.Footer = "Current Encountered Count: $EncounteredCount"; $TaskDialogShiny.FooterIcon = 'Information'; $TaskDialogShiny.AllowDialogCancellation = $true; $TaskDialogShiny.Buttons.Add($TaskDialogShinyOk); $TaskDialogShiny.ShowDialog($Script:SyncHashTable.ArchetypeCounterForm);  . RemoveDialogTransparentBackground; $GetPokeShinyCount = $ShinyCount; $SetPokeShinyCount = [int]$GetPokeShinyCount + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Shiny_Count=.*", "Shiny_Count=$SetPokeShinyCount"; [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile)

                    }

                    # Take existing debug images and combine into one png image file
                    Set-Location "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29"
                    cmd.exe /c "magick montage ArchetypeScreenshot.tif ArchetypeScreenshotEncounter.tif ArchetypeScreenshotMagick.tif -tile 1x3 -geometry +10+10 -bordercolor red -border 2 -background none AC_Debug_Screenshot.png" 
                    Set-Location $Global:CounterWorkingDir
                    Move-Item -Path "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29\*.png" -Destination "$Global:CounterWorkingDir\debug" -Force
                    
                    # Cleanup the ImageMagick library folder (.tif image files)
                    Remove-Item "$Global:CounterWorkingDir\lib\ImageMagick-7.1.1-29\*.tif" -Force

                    # Normal Pokemon Name logic processing (The main logic to properly filter the OCR Pokemon name - Cleaning up as much as possible)
                    # zh-Hant = Chinese Traditional / zh = Chinese Simplified
                    if ($GameLanguage -match "Korean") { if ($OCRCaptured -match '레벨') { $OCRCaptured = $OCRCaptured -replace '레벨',','; $OCRCaptured = $OCRCaptured -replace '[0-9]','' } else { $OCRCaptured = $OCRCaptured -replace '[0-9]',',' } } else { $OCRCaptured = $OCRCaptured -replace '[0-9]','' }; $OCRCaptured = $OCRCaptured -replace [regex]::escape('lv.'),',' -replace [regex]::escape('lvl.'),',' -replace [regex]::escape('Lv'),',' -replace [regex]::escape('Lvy.'),',' -replace [regex]::escape('Ly.'),',' -replace [regex]::escape('nv.'),',' -replace [regex]::escape('niv.'),',' -replace [regex]::escape('Lv,'),',' -replace [regex]::escape('Ly,'),',' -replace '[[\]{}+-]' -replace [regex]::escape('Ｌ'),'' -replace [regex]::escape('ㄴ'),'' -replace [regex]::escape('\'),'' -replace [regex]::escape('/'),'' -replace [regex]::escape('|'),'' -replace '\s',''; $OCRCaptured = $OCRCaptured -split ","; $OCRCaptured = $OCRCaptured | where { $_ -ne "" }; $OCRCaptured = $OCRCaptured.trim(); 0..7 | % { if ($OCRCaptured[$_].Length -eq 1) { $OCRCaptured[$_] = ''; $OCRCaptured = $OCRCaptured | where { $_ -ne "" } } }; if ($GameLanguage -match "Korean" -or $GameLanguage -match "Japanese" -or $GameLanguage -match "ChineseTraditional" -or $GameLanguage -match "ChineseSimplified") { $OCRCaptured = $OCRCaptured -replace '[a-zA-Z]','' -replace '[[\]{}''"+-]' -replace [regex]::escape('#'),'' }

                    # Special checks for symbols/characters in front of Pokemon names + last corrections
                    $OCRCaptured = $OCRCaptured.Replace('@','').Replace('®','').Replace('&','').Replace('?','').Replace('回','').Replace('园','').Replace('圖','').Replace('图','').Replace('其','').Replace('較','').Replace("(", "").Replace(")", "").Replace('니드런우','니드런').Replace('니드런?','니드런').Replace('ㅇ','');
                    $OCRCaptured = $OCRCaptured -replace [regex]::escape("Mr.Mime"),"Mr. Mime" -replace [regex]::escape("M.Mime"),"M. Mime" -replace [regex]::escape("Mr Mime"),"Mr. Mime" -replace [regex]::escape("M Mime"),"M. Mime" -replace [regex]::escape("MimeJr."),"Mime Jr." -replace [regex]::escape("Farfetch'd"),"Farfetch’d" -replace [regex]::escape("Farfetchd"),"Farfetch’d" -replace [regex]::escape("IHlumise"),"Illumise" -replace [regex]::escape("IHHlumise"),"Illumise"
                    if ($OCRCaptured -match 'Nidoran') { $OCRCaptured = $OCRCaptured -replace '[^a-zA-Z]', '' -replace 'Nidorand', 'Nidoran' -replace 'Nidoranod', 'Nidoran' }
                    if ($GameLanguage -match "Chinese") { $OCRCaptured = $OCRCaptured -replace '[\W]', '' -replace [regex]::escape("_"),"" -replace '[a-zA-Z0-9]', '' -replace '邙', '' }
                    if ($GameLanguage -match "Japanese" -or $GameLanguage -match "Korean") { $OCRCaptured = $OCRCaptured -replace '[\W]', ''; $OCRCaptured = $OCRCaptured.Replace("ニドランマ","ニドラン").Replace("ニドランキ","ニドラン").Replace("ニドランネ","ニドラン").Replace("ニドランそ","ニドラン").Replace("ニドランネィ","ニドラン").Replace("ニドランャ","ニドラン").Replace('ニドランウ','ニドラン').Replace('ニドランツウツ','ニドラン').Replace('バパバラス','パラス').Replace('ニニドラン','ニドラン').Replace('ペルシアゲアン','ペルシアン').Replace('キャタビ','キャタピ') }

                    # Pokemon name fix - Special check for Pokemon that are not name tracked properly through OCR (Resolved through text file)
                    $PokemonNameFixConfig = "$Global:CounterWorkingDir\stored\Config_PokemonNameFix.txt"; $GetPokemonNameFixConfig = [IO.File]::ReadAllLines("$PokemonNameFixConfig")       
                    $NameFixLines = $GetPokemonNameFixConfig.Count; 12..$NameFixLines | % { $CompareBadName = $GetPokemonNameFixConfig[$_] -replace ';.+',''; $CompareGoodName = $GetPokemonNameFixConfig[$_] -replace '^[^;]+;', ''; $CompareGoodName = $CompareGoodName.trimstart(); $EscapedBadName = [regex]::Escape($CompareBadName); $OCRCaptured = $OCRCaptured -replace "\b$EscapedBadName\b","$CompareGoodName" }; $OCRCaptured = $OCRCaptured -Replace 'Blank',''

                    # Increments Pokemon seen count by correct value (FOR TOTAL ENCOUNTERED POKEMON) - Part 1
                    $OCRCapturedLines = ($OCRCaptured | Measure-Object -Line).Lines

                    # Isolated name fixes (For edge case scenarios)
                    if ($OCRCaptured -match 'Kakuna' -and $OCRCapturedLines -match '4') { $OCRCaptured = $OCRCaptured + "Kakuna" }

                    # Ensures that any empty line is removed out of the OCR variable array
                    $OCRCaptured = $OCRCaptured | ? {$_.trim() -ne "" }

                    # Increments Pokemon seen count by correct value (FOR TOTAL ENCOUNTERED POKEMON) - Part 2
                    $OCRCapturedLines = ($OCRCaptured | Measure-Object -Line).Lines
                    $OCRCapturedTotal = [int]$EncounteredCount + [int]$OCRCapturedLines
                    $GetConfigProfile = $GetConfigProfile -replace "Encountered_Count=.*", "Encountered_Count=$OCRCapturedTotal"

                    # Adds count from the specific encountered type (Single/Double/Triple/Horde)
                    if ($OCRCapturedLines -match '1') { $SingleBattleTotal = [int]$SingleBattle + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Single_Battle=.*", "Single_Battle=$SingleBattleTotal" }
                    if ($OCRCapturedLines -match '2') { $DoubleBattleTotal = [int]$DoubleBattle + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Double_Battle=.*", "Double_Battle=$DoubleBattleTotal" }
                    if ($OCRCapturedLines -match '3') { $TripleBattleTotal = [int]$TripleBattle + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Triple_Battle=.*", "Triple_Battle=$TripleBattleTotal" }
                    if ($OCRCapturedLines -match '4' -or $OCRCapturedLines -match '5') { $HordeBattleTotal = [int]$HordeBattle + [int]1; $GetConfigProfile = $GetConfigProfile -replace "Horde_Battle=.*", "Horde_Battle=$HordeBattleTotal" }

                    # Sets all changes back into the Config file (for total count encountered)
                    [IO.File]::WriteAllLines($SetConfigProfile, $GetConfigProfile)

                    # (DEBUG OUTPUT) *
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "------------------`n| After Cleanup: |`n------------------`n`n$OCRCaptured`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "----------------`n| Horde Count: |`n----------------`n`n$OCRCapturedLines`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "-----------------`n| Current Hunt: |`n-----------------`n`n$($Script:SyncHashTable.GetCurrentProfile)`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "-----------------`n| Picture Mode: |`n-----------------`n`n$($Script:SyncHashTable.PictureMode) $($Script:SyncHashTable.ReShadeinPokeMMO)`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "-----------------`n| OCR Language: |`n-----------------`n`n$GameLanguage`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "--------------------`n| Counter Version: |`n--------------------`n`n4.0.0.2`n`n")
                    [IO.File]::AppendAllText("$Global:CounterWorkingDir\debug\AC_Debug_Output.txt", "#######################################`n# --------------- END --------------- #`n#######################################")

                    # Sets the variables to be used in the foreach loop
                    $CaptureLineIndex = 0; $ScanErrorRecieved = 0; $EncounterNumberDBArray = ''

                    # Does a proper loop in the OCRCaptured variable to add pokemon names into counter individually
                    foreach ($OCRCapture in $OCRCaptured) {

                        # Adds additional number value on each loop
                        $CaptureLineIndex++

                        # Pre-check to ensure captured Pokemon name is not "whitespaces" or "empty"
                        if ($OCRCapture -notmatch "\S") { $OCRCapture = 'EmptyPokeName' }

                        # Reads/loads encountered config file to properly reallocate later in script
                        $SetConfigProfileEncountered = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile)_Encountered.txt"; $GetConfigProfileEncountered = [IO.File]::ReadAllLines($SetConfigProfileEncountered); $CapturedPokemon = $GetPokeConfig | Where-Object { $_ -match "\b$OCRCapture\b" } | Select -First 1; $CapturedPokemonID = $CapturedPokemon -Replace '[^0-9]','' -Replace ' ', ''; $CapturedPokemonName = $CapturedPokemon -Replace '[0-9]','' -Replace '-', '' -Replace ' ', ''

                        # Checks if scanned pokemon name is null or empty
                        if (!([string]::IsNullOrEmpty($CapturedPokemon)) -or !([string]::IsNullOrWhitespace($CapturedPokemon))) { 
                        
                            # Clears all toast notifications generated by the counter
                            . ClearToastNotifyForCounter

                            # Clears specific variables being used to avoid any issues
                            Clear-Variable -Name OCRCaptureEncountered, OCRCaptureEncounteredNumber, NotifyEncounterCount

                            # Checks if the encountered profile file matches the scanned pokemon
                            if ($GetConfigProfileEncountered | Where-Object { $_ -match "\b$OCRCapture\b" }) {

                                # Sets pokemon in encountered profile file
                                $OCRCaptureEncountered = $GetConfigProfileEncountered | Where-Object { $_ -match "\b$OCRCapture\b" }; $OCRCaptureEncounteredNumber = ([regex]::Matches($OCRCaptureEncountered, "\((\d+)\)").Groups[1].Value) -join ''; $OCRCaptureEncounteredNumber = [int]$OCRCaptureEncounteredNumber + [int]1; $GetConfigProfileEncountered = $GetConfigProfileEncountered | ForEach-Object { if ($_ -match "\b$OCRCapture\b") { "#$CapturedPokemonID - $OCRCapture ($OCRCaptureEncounteredNumber)" } else { $_ } }; [IO.File]::WriteAllLines($SetConfigProfileEncountered, $GetConfigProfileEncountered)

                                # Checks if Filter mode matches (PokemonLastSeen)
                                if ($Script:SyncHashTable.SortingMode -match 'PokemonLastSeen') { $GetConfigProfileEncountered = $GetConfigProfileEncountered -replace [regex]::escape("#$CapturedPokemonID - $OCRCapture ($OCRCaptureEncounteredNumber)"),""; $GetConfigProfileEncountered = "#$CapturedPokemonID - $OCRCapture ($OCRCaptureEncounteredNumber)" + "`n" + ($GetConfigProfileEncountered -join "`n"); [IO.File]::WriteAllLines($SetConfigProfileEncountered, $GetConfigProfileEncountered); [System.Threading.Thread]::Sleep(10); $GetConfigProfileEncountered = [IO.File]::ReadAllLines($SetConfigProfileEncountered); $GetConfigProfileEncountered = $GetConfigProfileEncountered | Where-Object { $_ -ne "" }; [IO.File]::WriteAllLines($SetConfigProfileEncountered, $GetConfigProfileEncountered) }

                                # Checks if encountered line count equals 2 (Double Battle)
                                if ($OCRCapturedLines -eq 2) { $EncounterNumberDBArray += $OCRCaptureEncounteredNumber }

                            } else { 
                            
                                # Checks if Filter mode matches (PokemonLastSeen)
                                if ($Script:SyncHashTable.SortingMode -match 'PokemonLastSeen') { $GetConfigProfileEncountered = "#$CapturedPokemonID - $OCRCapture (1)" + "`n" + ($GetConfigProfileEncountered -join "`n"); [IO.File]::WriteAllLines($SetConfigProfileEncountered, $GetConfigProfileEncountered) } else { [IO.File]::AppendAllText($SetConfigProfileEncountered, "#$CapturedPokemonID - $OCRCapture (1)`n") }

                            }

                            # Checks if Notify mode matches (Milestone - Total)
                            if ($Script:SyncHashTable.NotifyMode -match 'MilestoneTotal') {

                                # Display toast notification based on encountered total count
                                if (([int]$EncounteredCount + [int]$CaptureLineIndex) % [int]$Script:SyncHashTable.NotifyMilestone -eq 0) { [bool]$ToastBool = $true }
                                                                 
                            # Checks if Notify mode matches (Milestone - Pokemon)
                            } elseif ($Script:SyncHashTable.NotifyMode -match 'MilestonePokemon') {

                                # Display toast notification based on individal pokemon total count
                                if ([int]$OCRCaptureEncounteredNumber % [int]$Script:SyncHashTable.NotifyMilestone -eq 0) { [bool]$ToastBool = $true }
                            
                            # Checks if Notify mode matches (Always)
                            } elseif ($Script:SyncHashTable.NotifyMode -match 'Always') { [bool]$ToastBool = $true }
                               
                            # Checks if at the last line in the loop encountered count
                            if ($CaptureLineIndex -eq $OCRCaptured.Count -and $ToastBool -eq $true) { . ToastCounterNotify }

                        } else { 

                            # Checks whether the encounter is an Alpha/Legendary/Shiny or normal encounter
                            if ($OCRCapturedAlpha -match $false -and $OCRCapturedLegendary -match $false -and $OCRCapturedShiny -match $false) {

                                # Creates Scan error loop count
                                $ScanErrorRecieved++; $ToastBool = $false

                                # Check if the scan error loop equals 1
                                if ($ScanErrorRecieved -match '1') {

                                    # Checks the config to verify is the failed scan dialog should appear
                                    if ($Script:SyncHashTable.ShowFailedScans -match 'YesScan') {

                                        # Show fake UAC dialog background
                                        . SetDialogTransparentBackground

                                        # Creates/Shows for failed PokeMMO scan
                                        $ClickableLink = "https://github.com/ssjshields/archetype-counter"; $GithubHyperLink = "<a href=""$ClickableLink"">Github</a>"; $UnableToScanDialog = [Ookii.Dialogs.WinForms.TaskDialog]::new(); $UnableToScanDialog.WindowTitle = "Archetype Counter"; $UnableToScanDialog.CustomMainIcon = $Script:SyncHashTable.ArchetypeCounterSystrayIcon; $UnableToScanDialog.MainInstruction = "PokeMMO Failed Scan"; $UnableToScanDialog.Content = "Unable to scan Pokémon.`n`nThis can occur when the counter fails on scanning properly. Please visit the official $GithubHyperLink if you are having issues."; $UnableToScanDialog.VerificationText = 'Do not show this message again'; $UnableToScanDialog.EnableHyperlinks = $true; $UnableToScanDialog.AllowDialogCancellation = $true; $UnableToScanDialog.Buttons.Add('Auto Fix'); $UnableToScanDialog.Buttons.Add('Ignore'); $UnableToScanDialog.Add_HyperlinkClicked({ Start-Process $ClickableLink }); [System.Media.SystemSounds]::Exclamation.Play(); $UnableToScanDialogResults = $UnableToScanDialog.ShowDialog($Script:SyncHashTable.ArchetypeCounterForm)

                                        # Checks if the Auto Fix button was selected
                                        if ($UnableToScanDialogResults.Text -match 'Auto Fix') { $InputDialog = [Ookii.Dialogs.WinForms.InputDialog]::new(); $InputDialog.WindowTitle = 'Archetype Counter'; $InputDialog.MainInstruction = 'PokeMMO Failed Scan'; $InputDialog.Content = "Enter the correct Pokémon name to fix this error:`n`n- Incorrect name: $OCRCapture"; $InputDialog.Input =''; $InputDialogErrorScanResults = $InputDialog.ShowDialog($Script:SyncHashTable.ArchetypeCounterForm); if ($InputDialogErrorScanResults -match 'Ok') { $SetConfigNameFix = "$Global:CounterWorkingDir\stored\Config_PokemonNameFix.txt"; $GetConfigNameFix = [IO.File]::ReadAllLines($SetConfigNameFix); $NameFixInsert = "$OCRCapture; $($InputDialog.Input)`n"; [System.IO.File]::AppendAllText($SetConfigNameFix, $NameFixInsert) } }

                                        # Checks if checkbox has been checked to no longer show dialog
                                        if ($UnableToScanDialog.IsVerificationChecked -eq $true) { $Script:SyncHashTable.GetConfigSettings = $Script:SyncHashTable.GetConfigSettings -replace "Show_Failed_Scans=.*", "Show_Failed_Scans=NoScan"; [IO.File]::WriteAllLines($Script:SyncHashTable.SetConfigSettings, $Script:SyncHashTable.GetConfigSettings) }

                                        # Removes fake UAC dialog background
                                        . RemoveDialogTransparentBackground

                                    }

                                }

                            }
                        
                        }

                    }
                    
                    # Checks if Overlay Mode is "Off" (To prevent running overlay GUI dispatcher invoke)
                    if ($Script:SyncHashTable.OverlayMode -notmatch "OffOverlay") {  

                        # Pushes GUI update (Dispatcher.Invoke) to WPF overlay window
                        $SetConfigProfileEncounteredOverlay = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile)_Encountered.txt"; $GetConfigProfileEncounteredOverlay = [IO.File]::ReadAllLines($SetConfigProfileEncounteredOverlay) | Select-Object -First $Script:SyncHashTable.AC_MultilineCount
                        if ($Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay -replace "#", "`n#" } elseif ($Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay[0]; $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $OCRCapturedTotal" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $OCRCapturedTotal } 
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $($Script:SyncHashTable.GetCurrentProfile) ($OCRCapturedTotal)$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_BusySymbol) $GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = "- $($Script:SyncHashTable.GetCurrentProfile) ($OCRCapturedTotal) -$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        $Script:SyncHashTable.ArchetypeCounterOverlayText.Dispatcher.Invoke([Action]{ $Script:SyncHashTable.ArchetypeCounterOverlayText.Text = "$OverlayDisplayText" }, [Windows.Threading.DispatcherPriority]::Normal)

                    }
                    
                    # Checks the filter mode and sorts accordingly
                    if ($Script:SyncHashTable.SortingMode -match "EncounteredAscending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonCount $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) } elseif ($Script:SyncHashTable.SortingMode -match "EncounteredDescending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonCount $_ } -Descending; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) } elseif ($Script:SyncHashTable.SortingMode -match "PokedexAscending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokedexNumber $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) } elseif ($Script:SyncHashTable.SortingMode -match "PokedexDescending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokedexNumber $_ } -Descending; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) } elseif ($Script:SyncHashTable.SortingMode -match "PokemonAscending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonName $_ }; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) } elseif ($Script:SyncHashTable.SortingMode -match "PokemonDescending") { $SortEncounteredList = [System.IO.File]::ReadAllLines($EncounteredCurrentProfile); $SetSortEncounteredList = $SortEncounteredList | Sort-Object { . CustomSortPokemonName $_ } -Descending; [System.Threading.Thread]::Sleep(10); [System.IO.File]::WriteAllLines($EncounteredCurrentProfile, $SetSortEncounteredList) }

                    # Compress .png debug file (Easier file share with reduced file size)
                    $ExecutePngquant = { . """$PWD\lib\Pngquant-3.0.3\pngquant.exe""" --skip-if-larger --strip --force --speed 5 --ext=.png """$PWD\debug\AC_Debug_Screenshot.png""" }
                    Start-Process Powershell -NoNewWindow -ArgumentList "-Command $ExecutePngquant"

                    # Re-show the ContextMenu (Off Screen) to simulate a refresh while having the counter menu opened when going into BUSY mode
                    $Script:SyncHashTable.ArchetypeContextMenu.Show($Script:SyncHashTable.ArchetypeCounterForm, [System.Drawing.Point]::new(-1000, -1000))

                    # Waits until battle has ended
                    . CheckForBattleEnd

                    # Resets counter icon back to original
                    $Script:SyncHashTable.ArchetypeCounterSystray.Icon = $Script:SyncHashTable.ArchetypeCounterSystrayIcon
                    
                    # Checks if Overlay Mode is "Off" (To prevent running overlay GUI dispatcher invoke)
                    if ($Script:SyncHashTable.OverlayMode -notmatch "OffOverlay") {  

                        # Pushes GUI update (Dispatcher.Invoke) to WPF overlay window
                        $SetConfigProfileEncounteredOverlay = "$Global:CounterWorkingDir\stored\$($Script:SyncHashTable.GetProfile)\Config_$($Script:SyncHashTable.GetProfile)_Encountered.txt"; $GetConfigProfileEncounteredOverlay = [IO.File]::ReadAllLines($SetConfigProfileEncounteredOverlay) | Select-Object -First $Script:SyncHashTable.AC_MultilineCount
                        if ($Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay -replace "#", "`n#" } elseif ($Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon") { $GetConfigProfileEncounteredOverlay = $GetConfigProfileEncounteredOverlay[0]; $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_NormalSymbol) $OCRCapturedTotal" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayTotal" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $OCRCapturedTotal } 
                        if ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_NormalSymbol) $($Script:SyncHashTable.GetCurrentProfile) ($OCRCapturedTotal)$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "True") { $OverlayDisplayText = "$($Script:SyncHashTable.AC_NormalSymbol) $GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "True" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = "- $($Script:SyncHashTable.GetCurrentProfile) ($OCRCapturedTotal) -$GetConfigProfileEncounteredOverlay" } elseif ($Script:SyncHashTable.OverlayMode -match "OnOverlayPokemon" -and $Script:SyncHashTable.AC_Multiline -match "False" -and $Script:SyncHashTable.AC_WithSymbol -match "False") { $OverlayDisplayText = $GetConfigProfileEncounteredOverlay }
                        $Script:SyncHashTable.ArchetypeCounterOverlayText.Dispatcher.Invoke([Action]{ $Script:SyncHashTable.ArchetypeCounterOverlayText.Text = "$OverlayDisplayText" }, [Windows.Threading.DispatcherPriority]::Normal)

                    }
                    
                }

            } else {

                # Checks if Overlay Mode is "Off" (To prevent running overlay GUI dispatcher invoke)
                if ($Script:SyncHashTable.OverlayMode -notmatch "OffOverlay") { if ($Script:SyncHashTable.ArchetypeCounterOverlay.IsVisible) { $Script:SyncHashTable.ArchetypeCounterOverlayText.Dispatcher.Invoke([Action]{ $Script:SyncHashTable.ArchetypeCounterOverlay.Hide() }, [Windows.Threading.DispatcherPriority]::Send) } }

                # Set the specific menuitem to be enabled = $true
                $Script:SyncHashTable.ArchetypeCounterSystray.Visible = $true; $Script:SyncHashTable.MenuItem_Encountered.Enabled = $true; $Script:SyncHashTable.MenuItem_Egg.Enabled = $true; $Script:SyncHashTable.MenuItem_Fossil.Enabled = $true; $Script:SyncHashTable.MenuItem_AlphaCount.Enabled = $true; $Script:SyncHashTable.MenuItem_LegendaryCount.Enabled = $true; $Script:SyncHashTable.MenuItem_ShinyCount.Enabled = $true; $Script:SyncHashTable.MenuItem_Hunt.Enabled = $true; $Script:SyncHashTable.MenuItem_Settings.Enabled = $true; $Script:SyncHashTable.MenuItem_TestToastNotification.Enabled = $true

                # Sets AC icon indicating counter is in "Idle" mode
                $Script:SyncHashTable.ArchetypeCounterSystray.Icon = $Script:SyncHashTable.ArchetypeCounterSystrayIconIdle

                # Re-show the ContextMenu (Off Screen) to simulate a refresh while having the counter menu opened when going into BUSY mode
                $Script:SyncHashTable.ArchetypeContextMenu.Show($Script:SyncHashTable.ArchetypeCounterForm, [System.Drawing.Point]::new(-1000, -1000))

                # Small delay (To give the CPU a breathing moment for Idle state - helps with CPU Usage)
                [System.Threading.Thread]::Sleep(750)

            }
        
        # Loops forever (Until the counter is closed)
        } Until ($nothing)
        
    })
    
    # This section is needed for the PowerShell runspace invoke
    $PowerShellCmd.Runspace = $Script:RunSpace
    $PSAsyncObject = $PowerShellCmd.BeginInvoke()

})

#######################################################
# --------------------------------------------------- #
# --- APPLICATION CONTEXT (BETTER RESPONSIVENESS) --- #
# --------------------------------------------------- #
#######################################################

# Show the ArchetypeForm & Creates an application context (Helps with responsivness and threading)
$ArchetypeCounterForm.Show()
$ArchetypeAppContext = New-Object System.Windows.Forms.ApplicationContext 
[System.Windows.Forms.Application]::Run($ArchetypeAppContext)