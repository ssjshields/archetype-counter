![mainlogo](https://cdn.discordapp.com/attachments/894130957588766770/995035312592015420/archetype.png)

Archetype Counter is a PowerShell WinForm script for the online video game [PokeMMO](https://pokemmo.com/).

Automatically tracks encounters (Horde, Safari, etc.) and when you receive Eggs.
 
Does not hook into the PokeMMO or javaw process. Utilizes OCR technology. 

Useful for [shiny hunting](https://marriland.com/guides/shiny-pokemon/) or metrics lovers.

Feel like exploring? Give our [client theme](https://github.com/ssjshields/archetype#readme) a try.

&nbsp;
# Features
🚀 option to sync launch with the `PokeMMO.exe`

📝 multiple hunt profiles and count slots

🎨 includes x2 themes and x4 sprite sets

🎭 create custom themes and import sprites

🗳️ built-in backup system / manually amend counts

&nbsp;
# Compatibility
🖥️ multi-monitor support; borderless or windowed modes *only*

🔍 multi-interface support; requires OCR recognizable font for monster name definitions e.g., NotoSans

📚 multi-language support; reporting any localization error is always appreciated

&nbsp;
# Media
![main](https://user-images.githubusercontent.com/88489119/200941569-133fae7d-f711-4159-8061-b5ba3be102dd.png)
![deafult_theme](https://user-images.githubusercontent.com/88489119/200941623-10bde8cd-4472-4f3b-9862-43fad321284c.png)
![collapsed_default](https://user-images.githubusercontent.com/88489119/200942039-f270c6fb-8153-416d-854c-60001b35ef74.png)

![collapsed](https://user-images.githubusercontent.com/88489119/200942013-09503dc8-2470-47a7-9a53-9fa13bfa7095.png)
![egg_collapsed](https://user-images.githubusercontent.com/88489119/200942027-cd20dbff-8193-403d-8c7f-1573d9d76ca6.png)



&nbsp;
# Prerequisites

*Note: If your OS is up-to-date, you will already have PowerShell installed*

**Requires Windows 10+ and [PowerShell 5.1](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2)**

> PowerShell 7.0+ not currently supported, possible migration in future for Linux / Mac support

**Battle backgrounds must be turned off in-game**

> Script is unable to properly capture names when they are turned on

**In-game resolution must be high enough for Counter to scan**

> `1280x720` is the lowest we can officially support at this current time

**OCR detectable nameplate font**

> Count will be inconsistent or fail all together if typeface is not legible for conversion

> Counter automatically ensures your Default theme has these values

&nbsp;
# Expectations
> Counter must be in counting mode before "A wild `monster` appeared!" text displays

> Tracking occurs via battle nameplates, OCR will not capture properly if there is an in-game widget blocking them

&nbsp;
# Installation
**1.** Download the latest [counter](https://github.com/ssjshields/archetype/archive/refs/heads/counter.zip)

**2.** Extract into `PokeMMO\data\mods`

**3.** Run via executable, create shortcut if needed

&nbsp;
# Main Navigation
> right-click window title area to access the Counter menu

> right-click value to decrease count

> left-click value to increase count

> hover over monster sprite to display dex number and name 

&nbsp;
# Counter Menu Navigation
*Note: Some options cannot be modified while the `PokeMMO.exe` is running*

![counter_menu](https://user-images.githubusercontent.com/88489119/200962673-4fd3c8de-01eb-4523-95ae-0dd44f1b0ec2.png)

<details>
  <summary>Click here to learn more</summary>
&nbsp;

### Language
> Select PokeMMO client language for OCR to detect

### Theme Selector
> Choose Counter themes and or collapsed mode 

### Sprite Selector
> Choose between several different monster sprite sets

### Detection Selector
> Choose the amount of monsters to track at one given time

### Clear Individual Slot
> Clear seen monsters from specific slot or Egg count

### Counter Mode
> Choose between expanded (default), collapsed (encounters) or collapsed (Eggs)

### Screen Mode
> Choose between 720p, HD (default) or 4K

### Hunt Profiles
> Choose or rename up to 5 different Counter profiles

### Backup
> Save the Counter in its current state to avoid possible lost config data, daily backup is automatic

### Support
> Seek assistance or report a bug

### Settings

*Note: Stopping the Counter with launch sync enabled will relaunch PokeMMO if the `PokeMMO.exe` is not found*

> Start the `PokeMMO.exe` after launching the Counter

> Set whether the Counter retains priority over the PokeMMO window or not

> Ignore the Windows operating system language

### Total Current Counts
> Displays the count between all seen monsters for a total count 

### Debug Mode
> Outputs data in the form of `.png` and `.txt` files for error reporting

> Open the debug file directory
</details>
&nbsp;

# FAQ
### Does this work on mobile?
> Unfortunately, no- refer to the [Prerequisites](https://github.com/ssjshields/archetype/tree/counter#prerequisites) section

### Does this work with custom PokeMMO client themes?
> Yes- refer to the [Compatibility](https://github.com/ssjshields/archetype/tree/counter#compatibility) section

### Flagged as a virus?
> May scan as false positive, [VirusTotal results](https://www.virustotal.com/gui/file/f12be5dac0ba60f8556c45116105fc76c6db024487559abb6ef96f55d3016273?nocache=1)

> Script source viewable at `\.rsrc\RCDATA\` via zip archiver or decodable

> Compiled with [AutoHotKey](https://www.autohotkey.com/) Ahk2Exe v1.1.34.04

### What version of PowerShell do I have?
> Run `PowerShell` and execute `Get-Host | Select-Object Version`

> Alternatively, check `Current PowerShell Verson` under the Counter's Support submenu

### How are Eggs tracked?
> When the user retrieves them from the Day Care Man, not as they hatch

> Events / trades do not log towards count

### Why does the Counter flash sometimes?
> Due to how the script currently works, there's no way to import new sprites without refreshing the gui

### How can I report a bug?
> Join our [Discord server](https://discord.gg/rYg7ntqQRY) support channel

**1.** Ensure you have the latest [counter](https://github.com/ssjshields/archetype/archive/refs/heads/counter.zip)

**2.** Enable [Debug Mode](https://github.com/ssjshields/archetype/tree/counter#debug-mode), pause the Counter after the reoccurring issue

**3.** Attach the `.png` and `.txt` files (if they are generated.) at `Files\Captured Screenshot`
</details>

&nbsp;
# Contact and Support
[![discord](https://assets-global.website-files.com/6257adef93867e50d84d30e2/62594fddd654fc29fcc07359_cb48d2a8d4991281d7a6a95d2f58195e.svg)](https://discord.gg/rYg7ntqQRY)
