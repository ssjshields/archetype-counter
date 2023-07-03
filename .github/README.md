![mainlogo](https://cdn.discordapp.com/attachments/894130957588766770/995035312592015420/archetype.png)

Archetype Counter is a PowerShell WinForm script for the online video game [PokeMMO](https://pokemmo.com/).

Automatically tracks encounters (Horde, Safari, etc.) and when you receive Eggs or Fossils.
 
Does not hook into the PokeMMO or javaw process. Utilizes Imagemagick and OCR technology.

Useful for [shiny hunting](https://pokemondb.net/pokedex/shiny) or metrics lovers. Feel like exploring? Give our [client theme](https://github.com/ssjshields/archetype#readme) a try.

**Requires Windows 10+**

&nbsp;
# Features
🚀 Opens PokeMMO if not found

📝 10 hunt profiles and 3 count slots (7 additional non-focused slots = 10 total)

🎨 Includes x2 themes (Archetype & Default) and x5 sprite sets

🎭 Ability to create custom theme

🗳️ Built-in backup system / manually amend counts (Plus "Auto Restore" if hunt profiles corrupt)

&nbsp;
# Trackables
🍃 Regular/Horde encounters

🦥 Safari encounters 

🔥 Alpha encounters

🌟 Shiny encounters

🐣 When receiving Eggs

🦣 When receiving Fossils

&nbsp;
# Compatibility
🖥️ multi-monitor support

🔍 multi-interface support

📚 multi-language support (Except CJK)

&nbsp;
# Media
![encounter expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125457882016657418/image.png)
&nbsp;
![encounter expanded - Default](https://cdn.discordapp.com/attachments/1032300868491546654/1125457920335806474/image.png)
&nbsp;
![encounter collapsed - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125459286001193010/image.png)
&nbsp;
![encounter collapsed - Default](https://cdn.discordapp.com/attachments/1032300868491546654/1125459348706041886/image.png)
&nbsp;
![egg expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458808148344943/image.png)
&nbsp;
![fossil expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458845649617017/image.png)
&nbsp;
![Counter Mode - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458544267894834/image.png)
&nbsp;
![Sprite Selector - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125459593775034521/image.png)
&nbsp;
![Extra Poke Slots - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458980404207636/image.png)

&nbsp;
# Expectations
> Counter must be in counting mode (ON) before receiving Eggs / Fossils or when encounters begin

> Tracking occurs via battle monster nameplates, OCR will not process properly if there is anything blocking them

> String ids which contain crucial text such as "{user} recieved Eggs / Fossils" cannot be removed from the game entirely

&nbsp;
# Installation
**1.** Extract into `PokeMMO\data\mods`

> Alternatively, clone into `PokeMMO\data\mods` using [GitHub Desktop](https://desktop.github.com/) or [Git](https://git-scm.com/downloads), pull to receive updates

**2.** Run the `Archetype Counter.lnk`, pin to the taskbar if needed (After you run at least once)

> Do not pin the Counter from the taskbar while it's running, otherwise it will pin the Powershell terminal instead

&nbsp;
# Removal
**1.** From the Counter menu navigate to Settings → Uninstall Archetype Counter

> All Counter files and theme modifications are subseqently removed automatically

&nbsp;
# Main Navigation
> Right-click window title area to access the Counter menu

> Right-click empty slot to manually set monster via dex number

> Right-click to decrease count, left-click to increase count

> Middle-click (scroll wheel) to manually set count

> Hover over monster sprite to display dex number and name 

&nbsp;
# Counter Menu Navigation
*Note: Some options will appear "grayed out" and cannot be modified while the Counter is in counting mode (ON) or (BUSY)*

![Counter Menu](https://github.com/ssjshields/archetype-counter/assets/88489119/aac25da5-c6b5-4e34-832d-e9903b3a17e2)

### Language
> Select PokeMMO client language for OCR to detect

### Theme Selector
> Choose Counter themes (Archetype, Default) + 3 Custom theme options (Create your own theme)

### Sprite Selector
> Choose between several different monster sprite sets (Default, 3DS, Gen 8, Home, Shuffle)

### Detection Selector
> Choose the amount of monsters to track at one given time (1 to 3)

### Reset selector
> Clear seen monsters from specific slots, extra slots, Egg/Fossil count and current hunt profile - this does not affect the total count

### Counter Mode
> Choose between Expanded (Encounter), Expanded (Egg), Expanded (Fossil), Collapsed (Encounter), Collapsed (Egg), or Collapsed (Fossil)

### Picture Mode
> Choose between two screenshot methods for the Counter to utilize, PrintWindow function (Default) and PrintScreen (Alternative)

### Extra Pokémon Slots
> Displays 7 additional pokémon detected

### Hunt Profiles
> Choose between 10 hunt profiles for current hunt

### Raname Hunt Profiles
> Choose hunt profile to change name

### Backup
> Save the Counter in its current state to avoid possible lost config data, daily backup is automatic

### Support
> Seek assistance or report a bug

### Settings

> Close PokeMMO: Set PokeMMO will close down when you exit counter

> Always on Top: Set whether the Counter retains priority over the PokeMMO window or not

> Ignore System Language: Ignore the Windows operating system language (use when the operating system language does not match in-game language.)

> Beep Count Sound: Set system sound effect when a pokémon is tracked by counter

> AC Uninstaller: Uninstall Archetype Counter and its dependencies 

### Total Current Counts
> Displays the count(s) from counter and total count between all seen monsters

### Debug
>  Open the debug or failed scanned file directory, fetching important data in the form of `.png` and `.txt` files for error reporting

</details>
&nbsp;

# FAQ
### Does this work on Linux, MacOS or mobile?
> Unfortunately, no- the Counter utilizes built in Windows features (OCR, Powershell, etc.)

### Does this work with custom PokeMMO client themes?
> Yes, it will work with all custom themes, but the monster nameplate text will be modified to be OCR compatible. 

> Client theme.xml, font values and graphical assets (AC folder) are inserted into the currently installed theme list 

### How does the Counter work?
> In a nutshell; it uses OCR and several other utilities to scan screenshots of monster names and compares them against a list

> Utilities scripted with PowerShell 5.1 by AnonymousPoke

> Monster nameplates processed using images passed through an [Imagemagick](https://imagemagick.org/index.php) formula by realmadrid1809

### How are Eggs and Fossils tracked?
> When the user retrieves them

> Events / trades do not log towards count

> DO NOT COMPLETELY REMOVE RECEIVED EGG / FOSSIL DIALOG USING CUSTOM STRINGS

### Can I convert data from other counters?
> Yes, right-click empty slot to manually set monster via dex number, middle-click (scroll wheel) to manually set count

> Manually editing profiles may cause corruption- located in `Files\Counter Config Files`

### How can I report a bug?
> Before creating a report, check [expectations](https://github.com/ssjshields/archetype-counter/tree/development#expectations) and [the existing issues](https://github.com/ssjshields/archetype-counter/issues)

> Open the Debug folders from the Debug submenu, attach the `.png` and `.txt` files

&nbsp;
# Disclaimer
This software has been created purely for the purposes of academic research. It is not intended to be used to attack other systems, nor does it provide the user any unfair advantage. There are no artificial inputs or hotkeys simulated. Project maintainers are not responsible or liable for misuse of the software. Source code can be viewed in the batch files. Use responsibly.

&nbsp;
# Contact and Support
[![discord](https://assets-global.website-files.com/6257adef93867e50d84d30e2/62594fddd654fc29fcc07359_cb48d2a8d4991281d7a6a95d2f58195e.svg)](https://discord.gg/rYg7ntqQRY)

