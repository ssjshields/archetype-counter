![mainlogo](https://cdn.discordapp.com/attachments/894130957588766770/995035312592015420/archetype.png)

Archetype Counter is a PowerShell WinForm script for the online video game [PokeMMO](https://pokemmo.com/).

Automatically tracks encounters (Horde, Safari, etc.) and when you receive Eggs or Fossils.
 
Does not hook into the PokeMMO or javaw process. Utilizes [ImageMagick](https://imagemagick.org/index.php) and [OCR](https://www.ibm.com/blog/optical-character-recognition/) technology.

Useful for [shiny hunting](https://Pokémondb.net/pokedex/shiny) or metrics lovers. Feel like exploring? Give our [client theme](https://github.com/ssjshields/archetype#readme) a try.

**Requires Windows 10+**

&nbsp;
# Features
🚀 Prompts to open the PokeMMO client if its not currently running

📝 10 hunt profiles and 3 count slots, includes 7 additional non-focused slots

🎨 Includes x2 themes (Archetype & Default) and x5 sprite sets, supports up to x3 custom themes

🗳️ Built-in backup system / manually amend counts, automatic restore if hunt profiles corrupt

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
🖥️ Multi-monitor support

🔍 Multi-interface support

📚 Full Multi-language support (Including CJK)

&nbsp;
# Media
![encounter collapsed - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125459286001193010/image.png) &nbsp; ![encounter collapsed - Default](https://cdn.discordapp.com/attachments/1032300868491546654/1125459348706041886/image.png)  

![Counter Mode - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458544267894834/image.png)  

![encounter expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125457882016657418/image.png) &nbsp; ![encounter expanded - Default](https://cdn.discordapp.com/attachments/1032300868491546654/1125457920335806474/image.png) &nbsp; ![egg expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458808148344943/image.png) &nbsp; ![fossil expanded - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458845649617017/image.png)  

&nbsp;
# Expectations
> Counter must be in counting mode (ON) before receiving Eggs / Fossils or when encounters begin

> Tracking occurs via battle monster nameplates, [OCR](https://www.ibm.com/blog/optical-character-recognition/) will not process properly if there is anything blocking them

> String ids which contain text such as "{user} recieved Eggs / Fossils" cannot be removed from the game entirely

&nbsp;
# Installation
**1.** Extract into `PokeMMO\data\mods`

> Alternatively, clone into `PokeMMO\data\mods` using [GitHub Desktop](https://desktop.github.com/) or [Git](https://git-scm.com/downloads), pull to receive updates

**2.** Run the `Archetype Counter.lnk`, pin to the taskbar if needed (After you run at least once)

> Ensure you run the `Archetype Counter.lnk` shortcut once before pinning to taskbar or any other location

> Do not pin the Counter from the taskbar while it's running, otherwise it will pin the Powershell terminal instead

&nbsp;
# Removal
**1.** From the Counter menu navigate to Settings → Uninstall Archetype Counter

> All Counter files and theme modifications are subseqently removed automatically

&nbsp;
# Main Navigation
> Right-click window title area to access the Counter menu

> Right-click empty slot to manually set monster via dex number

> Right-click to decrease count, left-click to increase count (Tracked Pokémon & total count)

> Middle-click (scroll wheel) to manually set count

> Hover over monster sprite to display dex number and name 

&nbsp;
# Counter Menu Navigation
*Options will appear "grayed out" and cannot be modified while the Counter is in counting mode (ON) or (BUSY)*

![Extra Poke Slots - Archetype](https://cdn.discordapp.com/attachments/1032300868491546654/1125458980404207636/image.png)

### Theme Selector
> Choose Counter themes (Archetype, Default) + 3 Custom theme options (Create your own theme)

### Sprite Selector
> Choose between several different monster sprite sets (Default, 3DS, Gen 8, Home, Shuffle)

### Detection Selector
> Choose the amount of monsters to track at one given time (1 to 3) - In Expanded Mode

### Reset selector
> Clear seen monsters from specific slots, extra slots, Egg/Fossil count and current hunt profile

### Counter Mode
> Choose between Expanded (Encounter), Expanded (Egg), Expanded (Fossil), Collapsed (Encounter), Collapsed (Egg), or Collapsed (Fossil)

### Picture Mode
> Choose between two screenshot methods for the Counter to utilize, PrintWindow function (Default) and PrintScreen (Alternative)

### Chinese Mode
> Choose between No Override, Chinese Simplified, or Chinese Traditional to support Chinese strings ('No Override' means Chinese Mode is not utilized)

### Extra Pokémon Slots
> Displays the last 7 previously encountered monsters (Displays all 10 slots in collapsed mode)

### Hunt Profiles
> Choose between 10 hunt profiles for current hunt

### Rename Hunt Profiles
> Change the name of hunt profiles

### Backup
> Save the Counter in its current state to avoid possible lost config data, daily backup is automatic

### Support
> Seek assistance or report a bug

### Settings
> Close PokeMMO: PokeMMO will close down when you exit counter

> Counter Screen Position: Allows you to lock the counters current position on screen to prevent accidental movement

> Always on Top: Set whether the Counter retains priority over the PokeMMO window or not

> Beep Count Sound: Set system sound effect when a pokémon is tracked by counter

> Manual Pixel Search: Ability to switch to a precise mode if auto pixel searching fails (Last possible effort)

> AC Uninstaller: Uninstall Archetype Counter and its dependencies 

### Total Current Counts
> Displays the count(s) from counter and total count between all seen monsters

### Debug
> Open 'DEBUG' folder: Opens the general counter folder to help diagnose issues in the format of `.png` screenshots and a DEBUG_OCR_OUTPUT.txt file

> Open 'Failed Scan' folder: Opens the debug counter folder that is specific to failed scans (This helps reduce pinpoint specific issues) - in the format of screenshots and a DEBUG_OCR_OUTPUT.txt file

> Open 'Core' folder: Opens the Core folder where automatic screenshots are taken and when failing to activate the counter during battles (When fundamentally something is wrong)

> Open 'Name Fix' File folder: Opens the text file that allows you the user to manipulate the OCR scanned output by correcting the bad name with the correct name

&nbsp;
# FAQ
### How does the Counter work?
> [OCR](https://www.ibm.com/blog/optical-character-recognition/) and several other utilities are used to scan screenshots of monster names and compares them against a list

> Monster nameplates processed using images passed through [ImageMagick](https://imagemagick.org/index.php) formula by realmadrid1809 + additional logic cleanup in PowerShell

> Utilities scripted with PowerShell 5.1 by AnonymousPoke

### Does the counter work on Linux, MacOS or mobile?
> Unfortunately no - the Counter utilizes built in Windows OCR (OCR, Powershell, etc.) + Tesseract OCR & ImageMagick

### Does this work with custom PokeMMO client themes?
> Yes, it will work with all custom themes, but the monster nameplate text will be modified to be OCR compatible

> Client theme.xml, font values and graphical assets (AC folder) are inserted into the currently installed theme list

### How do I make custom Counter theme?
> Open the counter menu and navigate to -> Theme Selector -> "Open Theme Folder" and modify the .png images accordingly

> Modifying the `ThemeConfig.txt` file will allow you to change the font/background colors along with font sizing & types

### Does the Counter track Shiny Pokémon?
> Yes it does and it will also provide a prompt provided by the counter indicating a shiny is on the screen (Extra layer to prevent defeating or running from the shiny)

### Does the Counter track Alpha Pokémon?
> Yes, but only as a total count in the counter - will not add to the normal tracked monster count

### Does the Counter track Legendary Pokémon?
> Yes, but currently only the 3 legendary dogs from Johto (Raikou, Suicune, and Entei)

### How are Eggs and Fossils tracked?
> When the user retrieves them - by tracking the word `egg` & `recieved` for eggs / by tracking the word `<FossilMonsterName>` & `recieved` for fossils

> Events / trades do not log towards count

> If you are using custom strings do not completely remove receieved Egg / Fossil dialog

### Does the counter track Zorua or Zoroark?
> Due to this Pokémon and it's ability.. No.

### Can the Counter track 2 different Pokémon in a double wild battle or horde?
> Currently the counter does not support these types of battles and you may get mixes results when tracked in the counter

### Can I convert data from other counters?
> Yes, right-click empty slot to manually set monster via dex number, middle-click (scroll wheel) to manually set count

> Manually editing profiles may cause corruption - located in `Files\Counter Config Files`

### When I go into battle, the counter does not count or go busy. What do I do?
> Go into the counter menu and change your Picture Mode from `PrintWindow (Default)` to `PrintScreen (Alternate)` - If this does not resolve issue, please report a bug

### How do I fix incorrect scanned Pokémon names with the 'Name Fix' file?
> When a monster is incorrectly scanned via OCR, you take the 'failed' name and place it on the left hand side of the semi-colon and then take the correct monster name and place to the right of the semi-colon

> `(Ex: Gastiy; Gastly)`

> You will need to turn the counter OFF and then back ON for these changes to take effect

### How do I manually remove additional characters/symbols from the failed scan?
> Open up the 'Name Fix' file from the counter menu and take the partial/incorrect text and place on the left hand side of the semi-colon and then place the word 'Blank' on the right hand side of the semi-colon

> `(Ex: GastE; Blank)`

> When a 'Blank' is provided on the right hand side of the semi-colon, this indicates the counter to completely remove that specific text - You will need to turn the counter OFF and then back ON for these changes to take effect

### Does the Counter support transparency when making custom themes?
> No - this is a limitation with the PowerShell WinForms GUI

### How do I move the counter location to the top of the screen edge?
> Move the counter as closely as possible to the top of the screen and then utilize the arrows keys to move to desired location

### Can I manually add a count to the tracked Pokémon and total count in the Counter?
> See `Main Navigation` above

### Can I preset a Pokémon in the counter before being tracked?
> See `Main Navigation` above



### How can I report a bug?
> Before creating a report, review this readme and [the existing issues](https://github.com/ssjshields/archetype-counter/issues)

> Open the Debug folders from the Debug submenu, attach the `.png` and `.txt` files

&nbsp;
# Disclaimer
This software has been created purely for the purposes of academic research. It is not intended to be used to attack other systems, nor does it provide the user any unfair advantage. There are no artificial inputs or hotkeys simulated. Project maintainers are not responsible or liable for misuse of the software. Source code can be viewed in the batch files. Use responsibly.

&nbsp;
# Contact and Support
[![discord](https://assets-global.website-files.com/6257adef93867e50d84d30e2/62594fddd654fc29fcc07359_cb48d2a8d4991281d7a6a95d2f58195e.svg)](https://discord.gg/rYg7ntqQRY)

