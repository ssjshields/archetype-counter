![mainlogo](https://cdn.discordapp.com/attachments/894130957588766770/995035312592015420/archetype.png)

Archetype Counter is a PowerShell WinForm script for the online video game [PokeMMO](https://pokemmo.com/).

Automatically tracks encounters (Horde, Safari, etc.) and when you receive Eggs or Fossils.
 
Does not hook into the PokeMMO or javaw process. Utilizes Imagemagick and OCR technology.

Useful for [shiny hunting](https://pokemondb.net/pokedex/shiny) or metrics lovers. Feel like exploring? Give our [client theme](https://github.com/ssjshields/archetype#readme) a try.

&nbsp;
# Features
🚀 opens PokeMMO if not found

📝 multiple hunt profiles and count slots

🎨 includes x2 themes and x5 sprite sets

🎭 create custom themes and import new sprites

🗳️ built-in backup system / manually amend counts

&nbsp;
# Trackables
🍃 regular encounters

🦥 safari encounters 

🐣 when receiving Eggs

🦣 when receiving Fossils

&nbsp;
# Compatibility
🖥️ multi-monitor support

🔍 multi-interface support

📚 multi-language support

&nbsp;
# Media
to be updated shortly

![egg expand](https://github.com/ssjshields/archetype-counter/assets/88489119/03bff079-4e46-4f1c-8fc3-9204863b1bd1)

![fossil expand](https://github.com/ssjshields/archetype-counter/assets/88489119/0034da2d-853b-42e7-9548-a0eab426b89b)


&nbsp;
# Prerequisites

**Requires Windows 10+**
> Linux and MacOS will not be supported, there is no AHK equivilant for these platforms

&nbsp;
# Expectations
> Counter must be in counting mode (ON) before receiving Eggs / Fossils or when encounters begin

> Tracking occurs via battle monster nameplates, OCR will not process properly if there is anything blocking them

> String ids which contain crucial text such as "{user} recieved Eggs / Fossils" cannot be removed from the game entirely

&nbsp;
# Installation
**1.** Extract into `PokeMMO\data\mods`

> Alternatively, clone into `PokeMMO\data\mods` using [GitHub Desktop](https://desktop.github.com/) or [Git](https://git-scm.com/downloads), pull to receive updates

**2.** Run the `Archetype Counter.lnk`, pin to the taskbar if needed

> Do not pin the Counter from the taskbar while it's running, otherwise it will pin the Powershell terminal instead

&nbsp;
# Removal
**1.** From the Counter menu navigate to Settings → Uninstall Archetype Counter

> All Counter files and theme modifications are subseqently removed automatically

&nbsp;
# Main Navigation
> right-click window title area to access the Counter menu

> right-click empty slot to manually set monster via dex number

> right-click to decrease count, left-click to increase count

> middle-click (scroll wheel) to manually set count

> hover over monster sprite to display dex number and name 

&nbsp;
# Counter Menu Navigation
*Note: Some options will appear "grayed out" and cannot be modified while the Counter is in counting mode (ON) or (BUSY)*

![Counter Menu](https://github.com/ssjshields/archetype-counter/assets/88489119/aac25da5-c6b5-4e34-832d-e9903b3a17e2)

### Language
> Select PokeMMO client language for OCR to detect

### Theme Selector
> Choose Counter themes and or collapsed mode 

### Sprite Selector
> Choose between several different monster sprite sets

### Detection Selector
> Choose the amount of monsters to track at one given time

### Reset selector
> Clear seen monsters from specific slot, Egg or Fossil count- this does not affect the total count

### Counter Mode
> Choose between expanded (with Egg), expanded (with Fossil), collapsed (encounters), collapsed (with Egg), or collapsed (with Fossil)

### Picture Mode
> Choose between two screenshot methods for the Counter to utilize, PrintWindow function (Default) and PrintScreen (Alternative)

### Hunt Profiles
> Choose or rename up to 10 different Counter profiles

### Backup
> Save the Counter in its current state to avoid possible lost config data, daily backup is automatic

### Support
> Seek assistance or report a bug

### Settings

> Set whether the Counter retains priority over the PokeMMO window or not

> Ignore the Windows operating system language (use when the operating system language does not match in-game language.)

> Uninstall Archetype Counter and its dependencies 

### Total Current Counts
> Displays the count between all seen monsters for a total count 

### Debug
>  Open the debug file directory, fetching important data in the form of `.png` and `.txt` files for error reporting

</details>
&nbsp;

# FAQ
### Does this work on Linux, MacOS or mobile?
> Unfortunately, no- the Counter utilizes built in Windows features (OCR, Powershell, etc.) as well as AHK

### Does this work with custom PokeMMO client themes?
> Yes, it will work with all custom themes, but the monster nameplate text will be modified to be OCR compatible. 

> Client theme.xml, font values and graphical assets (AC folder) are inserted into the currently installed theme list 

### How does the Counter work?
> In a nutshell; it uses OCR and several other utilities to scan screenshots of monster names and compares them against a list

> Utilities scripted with [GDI+ standard library 1.45 by tic](https://www.autohotkey.com/boards/viewtopic.php?t=6517) and PowerShell 5.1 by AnonymousPoke

> Monster nameplates processed using images passed through an [Imagemagick](https://imagemagick.org/index.php) formula by realmadrid1809

### How are Eggs and Fossils tracked?
> When the user retrieves them

> Events / trades do not log towards count

> DO NOT COMPLETELY REMOVE RECEIVED EGG / FOSSIL DIALOG USING CUSTOM STRINGS

### Can I convert data from other counters?
> Yes, right-click empty slot to manually set monster via dex number, middle-click (scroll wheel) to manually set count

> Manually editing profiles may cause corruption- located in `Files\Counter Config Files`

### How can I report a bug?
> Before creating a report, check the [prerequisites](https://github.com/ssjshields/archetype-counter/tree/development#prerequisites), [expectations](https://github.com/ssjshields/archetype-counter/tree/development#expectations) and [the existing issues](https://github.com/ssjshields/archetype-counter/issues)

> Open the Debug and Imagemagick folders from the Debug submenu, attach the `.png` and `.txt` files

&nbsp;
# Disclaimer
This software has been created purely for the purposes of academic research. It is not intended to be used to attack other systems, nor does it provide the user any unfair advantage. There are no artificial inputs or hotkeys simulated. Project maintainers are not responsible or liable for misuse of the software. Source code can be viewed from the AHK scripts or in batch files. Use responsibly.

&nbsp;
# Contact and Support
[![discord](https://assets-global.website-files.com/6257adef93867e50d84d30e2/62594fddd654fc29fcc07359_cb48d2a8d4991281d7a6a95d2f58195e.svg)](https://discord.gg/rYg7ntqQRY)

