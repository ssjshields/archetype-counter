<p align="center">
  <img src="/.github/images/main_logo.png">
</p>

<p align="center">
  <a href="https://github.com/ssjshields/archetype-counter/archive/refs/heads/main.zip"><img src="https://img.shields.io/badge/%F0%9F%93%82-%20?style=flat&label=Download&color=blue" alt="https://github.com/ssjshields/archetype-counter/archive/refs/heads/testing.zip">
</a></p>

# What is this? 💭
Archetype Counter is a tool for the online video game [PokeMMO](https://pokemmo.com/).

Automatically track wild encounters and manually track when you receive Eggs or Fossils.
 
Have questions? See the [FAQ](?tab=readme-ov-file#faq-) and [Counter Menu Navigation](?tab=readme-ov-file##counter-menu-navigation-) for more information before reaching out.

&nbsp;

# Media 🖼️
<p align="left">
  <img src="/.github/images/main_preview.png">
</p>

&nbsp;

# Features 🧪
🚨 **Convenient Notifications**:
   - Optional Windows toast notifications for tracking counts.
   - Multiple sorting and notification modes for seamless navigation.
   - Set custom notification Milestones to track your progress the way you want.

🔧 **Automated Management**:
   - Automatically Open and or Close PokeMMO alongside the Counter.
   - Automatic Profile backup and debug systems for hassle-free usage.

📋 **Flexible Hunt Profiles**:
   - 10 renameable Hunt Profiles.
   - Unlimited Pokémon capture per Profile (Up to 25 Seen Pokémon shown in counter menu).

👁 **Optional On Screen Overlay**:
   - Display by Total count OR Pokédex number, Pokémon name, and Total count.
   - Customize font style, size, colors, thickness, padding, opacity and more.

🎨 **Choose your Theme**:
   - Light and Dark mode menu themes for comfortable viewing.
   - 5 different Pokémon sprite styles to suit your preferences.

&nbsp;

# What can I track? 🔍

- Regular / Horde encounters

- Shiny encounters

- Alpha encounters

- Legendary encounters

- Safari encounters 

- Eggs (Manual)

- Fossils (Manual)

&nbsp;

# Compatibility ✅
- Multi-language support

- Multi-monitor and high resolution support

- Custom PokeMMO theme support 

> [!NOTE]
Custom themes require default PokeMMO font- NotoSans.

&nbsp;

# Requirements 🗝️
- Windows 10 Version 1809+ or Windows 11

- Net Framework 4.7.2

- PowerShell 5.1

> [!NOTE]
Net Framework and PowerShell are typically included in the latest Windows updates.

&nbsp;
# Installation 📦

**1.** Extract into `PokeMMO\data\mods`

> [!TIP]
You can clone this repository into `PokeMMO\data\mods` using [GitHub Desktop](https://desktop.github.com/) or [Git](https://git-scm.com/downloads), pull to receive updates.

&nbsp;

**2.** Run the `Archetype Counter.lnk`

> [!CAUTION]
Ensure you run the `Archetype Counter.lnk` shortcut once before pinning the shortcut to taskbar or any other location. 

> [!CAUTION]
Do not pin the Counter from the taskbar while it's running, otherwise it will pin the Powershell terminal instead.

&nbsp;

# Removal 🗑️
1. From the Counter menu navigate to Settings → Uninstall Archetype Counter

> [!TIP] 
If you are only using the Default PokeMMO theme, you can repair the client from the main menu.

> [!CAUTION]
Deleting the Counter folder from the mods directory will not remove the XML changes from the theme files.

&nbsp;

# Credits
**External Libraries:**
- VistaMenu (https://wyday.com/vistamenu/)
- Tesseract OCR (https://github.com/tesseract-ocr/tesseract)
- ImageMagick (https://imagemagick.org/index.php)
- Ookii.Dialogs.Winforms (https://github.com/ookii-dialogs/ookii-dialogs-winforms)
- BurntToast (https://github.com/Windos/BurntToast)
- Pngquant (https://pngquant.org/)
- DarkNet (https://github.com/Aldaviva/DarkNet)

**Pokémon Sprites:**
- Default (https://pokemmo.com/)
- 3DS (https://forums.pokemmo.com/index.php?/topic/93475-mod-3ds-monster-icons/)
- Home (https://forums.pokemmo.com/index.php?/topic/112385-mod-pokemon-home-monster-icons/)
- Shuffle (https://forums.pokemmo.com/index.php?/topic/74184-mod-shuffle-icons-mod-32/)
- Gen 8 (https://forums.pokemmo.com/index.php?/topic/139566-generation-8-style-icons-v8-updated-as-of-112422/)

&nbsp;
# Counter Icon Indicator (System Tray) 💡

<img src="/.github/images/startup.png">

> Counter is in the `startup` state (Yellow). This is when the counter is starting/loading when launched.

&nbsp;

<img src="/.github/images/idle.png">

> Counter is in an `idle` state (Gray). This indicates PokeMMO is not launched or is in a minimized state in the taskbar and performs no logic until PokeMMO is active.

&nbsp;

<img src="/.github/images/running.png">

> Counter is in an `running` state (Blue). The normal running state where it actively takes screenshots in memory until a wild battle is encountered.

&nbsp;

<img src="/.github/images/busy.png">

> Counter is in an `busy` state (Red). Indicates the counter is currently running through the main logic to add the correct counts (In Wild Battle)

&nbsp;
# Counter Menu Navigation 📌
> [!NOTE]
Options will appear "grayed out" and cannot be accessed while the Counter is (BUSY).

&nbsp;

## Encountered (Count) 🔎
<details>
<summary>Click to expand</summary>

&nbsp;
> *Encountered Pokémon dynamically get loaded from the top 25 seen in battle. (Top 25 have been chosen for the counter menu due to performance reasons.)*

> *Selecting an existing Pokémon in the counter menu allows you to manually modify the specific encountered count.*

>- **`Encountered Type Count`**: Shows all of the encountered types the counter will track.
>	- `Single Battle`: Displays the current count for all single battles encountered.
>	- `Double Battle`: Displays the current count for all double battles encountered.
>	- `Triple Battle`: Displays the current count for all triple battles encountered.
>	- `Horde Battle`: Displays the current count for all horde battles encountered.

>- **`Change Encountered Count`**: Set any number value for the Encountered count. (Typically when transferring from another counter)

>- **`Reset Encountered Count`**: Resets the current hunt profile Encountered count to "0".

</details>

&nbsp;

## Egg (Count) 🐣
<details>
<summary>Click to expand</summary>

&nbsp;
>- **`Add +1`**: Adds a number value count of "1" to the total Egg count.

>- **`Add +30`**: Adds a number value count of "30" to the total Egg count.

>- **`Add +60`**: Adds a number value count of "60" to the total Egg count.

>- **`Change Egg Count`**: Set any number value for the Egg count. (Typically when transferring from another counter)

>- **`Reset Egg Count`**: Resets the current hunt profile Egg count to "0".

</details>

&nbsp;

## Fossil (Count) 🐚
<details>
<summary>Click to expand</summary>

&nbsp;
>- **`Add +1`**: Adds a number value count of "1" to the total Fossil count.

>- **`Add +30`**: Adds a number value count of "30" to the total Fossil count.

>- **`Add +60`**: Adds a number value count of "60" to the total Fossil count.

>- **`Change Fossil Count`**: Set any number value for the Fossil count. (Typically when transferring from another counter)

>- **`Reset Fossil Count`**: Resets the current hunt profile Fossil count to "0".

</details>

&nbsp;

## Alpha / Legendary / Shiny ⭐
<details>
<summary>Click to expand</summary>

&nbsp;
>- **`Alpha (Count)`**:
>	- `Change Alpha Count`:
>	- `Reset Alpha Count`: Resets the current hunt profile Alpha count to "0".

>- **`Legendary (Count)`**:
>	- `Change Legendary Count`:
>	- `Reset Legendary Count`: Resets the current hunt profile Legendary count to "0".

>- **`Shiny (Count)`**:
>	- `Change Shiny Count`:
>	- `Reset Shiny Count`: Resets the current hunt profile Shiny count to "0".

</details>

&nbsp;

## Hunt (Hunt Profile) 📋
<details>
<summary>Click to expand</summary>

&nbsp;
> *Do NOT use the same word for different hunt profiles. Ensure hunt profile name is unique from the others.*

>- **`Rename Current Hunt`**: Change the current hunt profile name to better organized specific hunts.

>- **`Reset Current Hunt`**: Resets the current hunt profile in the counter (Encountered, Egg, Fossil, Alpha, Legendary, Shiny.. everything!)

>- **`Reset All Hunts`**: Resets all hunt profiles in the counter. (Warning: Please ensure you have backups of your current counts in all hunt profiles before utilizing the "Reset All Hunts" selection.)

</details>

&nbsp;

## Settings ⚙️

<details>
<summary>Click to expand</summary>

### Picture Mode
>- **`Primary`**: Uses built PrintWindow function wrapped in a dll file (PrintWindowStream.dll).

>- **`Alternate (Debug)`**: Backup option if the Primary picture mode fails.

### Chinese Mode
>- **`Off`**: Indicates the counter will not OCR scan the screenshot with Chinese recognition.

>- **`Chinese Simplified`**: Indicates the counter will OCR scan the screenshot with Chinese recognition (From Chinese in-game strings).

>- **`Chinese Traditional`**: Indicates the counter will OCR scan the screenshot with Chinese recognition. (From Chinese in-game strings).

### Theme Mode
>- **`Auto`**: Sets the couner menu based on the Windows standard theme (Light/Dark).

>- **`Light`**: Manually overrides and sets the counter menu to "Light" theme.

>- **`Dark`**: Manually overrides and sets the counter menu to "Dark" theme.

### Sprite Mode
>- **`Default`**: Standard PokeMMO sprites used in counter menu & notifications.

>- **`3DS`**:  3DS PokeMMO sprites used in counter menu & notifications.

>- **`Gen 8`**: Gen 8 PokeMMO sprites used in counter menu & notifications.

>- **`Home`**: Home PokeMMO sprites used in counter menu & notifications.

>- **`Shuffle`**: Shuffle PokeMMO sprites used in counter menu & notifications.

### Notify Mode
>- **`Never`**: Windows toast notifications is turned off and will not trigger.

>- **`Partial (By Pokémon)`**: Windows toast notifications triggered based on Pokémon counts.

>- **`Partial (By Total)`**: Windows toast notifications triggered based on total Encountered count.

>- **`Always`**:

>- **`Set Milestone (Count)`**: Sets the specific number value count when to trigger the "By Total" or "By Pokémon". Ex: If the count is set to 10, then the Windows toast notification will trigger if the count reaches 10 by total or by Pokémon.

### Sorting Mode
>- **`Encountered (Ascending)`**: Sorts the encountered list by Ascending order (lowest to highest).

>- **`Encountered (Descending)`**: Sorts the encountered list by Descending order (highest to lowest).

>- **`Pokédex (Ascending)`**: Sorts the encountered list by Ascending order from the the Pokémon Pokédex number (lowest to highest).

>- **`Pokédex (Descending)`**: Sorts the encountered list by Descending order from the the Pokémon Pokédex number (highest to lowest).

>- **`Pokémon (Ascending)`**: Sorts the encountered list by Ascending order from the Pokémon name (Alphabetical - lowest to highest).

>- **`Pokémon (Descending)`**: Sorts the encountered list by Descending order from the Pokémon name (Alphabetical - highest to lowest).

>- **`Pokémon (Last Seen)`**: Sorts the encountered list by the last Pokémon seen in battle.

>- **`None`**: No sort is added in.

### Overlay Mode

<details>
<summary>Click to see Overlay Settings</summary>

&nbsp;

>- **`Normal Symbol`**: The main symbol used for the GUI Overlay while outside of battle. This is a unicode character symbol.

>- **`Normal Symbol`**: The busy symbol used for the GUI Overlay while inside of battle. This is a unicode character symbol.

>- **`Unicode Character Symbols`**: https://www.vertex42.com/ExcelTips/unicode-symbols.html

>- **`With Symbol`**: Sets whether or not to use the symbols on the GUI Overlay. True = ON / False = OFF

>- **`Multiline`**: Sets the GUI Overlay to show up to invididual Pokémon in the GUI list. (This will only display if using the "On (Pokémon)" option in the Overlay Mode.)

>- **`Multiline Count`**: Ability to set/control the amount of encountered Pokémon displayed in Overlay Mode.

>- **`Font Type`**: This property sets the typeface of the text displayed. For example, "Arial", "Times New Roman", or any other installed font family can be used - Using "System" utilizes no font and goes based off of Windows system font. (String Name)

>- **`Font Size`**: This property sets the size of the text displayed. (Number Value)

>- **`Font Padding`**: This property is the space between the content of the Text and its border. (Number Value)

>- **`Font Color`**: This property sets the color of the text displayed. (Hex Code Value)

>- **`Font Background Color`**: This property sets the color of the text background displayed. (Hex Code Value)

>- **`Font Opacity`**: This property sets & determines the transparency of the Text. It ranges from 0 (fully transparent) to 1 (fully opaque). Values between 0 and 1 specify varying levels of transparency. Ex: 0.6 (Number Value or Number Decimal Value)

>- **`Font Background Opacity`**: This property sets & determines the transparency of the Text background. It ranges from 0 (fully transparent) to 1 (fully opaque). Values between 0 and 1 specify varying levels of transparency. Ex: 0.6 (Number Value or Number Decimal Value)

>- **`Font Weight`**: This property sets the thickness of the font's stroke. It can be set to predefined values like Normal or Bold. (String Name)

>- **`Font Style`**: This property sets the style of the font, such as Normal, Italic, or Oblique. Italicized text has a slanted appearance compared to normal text. Oblique is similar to italic but uses a different algorithm to slant the characters. (String Name)

</details>

>- **`On (Pokémon)`**: Shows a minimal but customizable GUI overlay for the current Pokémon count (Based on the "Sorting Mode").

>- **`On (Total)`**: Shows a minimal but customizable GUI overlay for the total Encountered count.

>- **`Off (System Tray)`**: No GUI overlay is displayed.

>- **`Open Overlay Settings`**: Opens the "Config_OverlaySettings.txt" file that allows you to customize the GUI overlay.

### Open PokeMMO
>- **`Yes`**: Set to open PokeMMO when the counter is opened.

>- **`No`**: Does not set PokeMMO to open when the counter is opened.

### Close PokeMMO
>- **`Yes`**: Set to close PokeMMO when the counter is closed.

>- **`No`**: Does not set PokeMMO to close when the counter is closed.

### Show Failed Scans
>- **`Yes`**: Showed failed scans dialog to rectify failed ocr name scans from battle.

>- **`No`**: Disables the failed scan dialog (Reccomended not to turn this off).

### Uninstall
> Dialog that allows FULL uninstall of the Archetype Counter. See [Removal](?tab=readme-ov-file#removal-%EF%B8%8F) for more info.

</details>

&nbsp;

## Support 🧡
<details>
<summary>Click to expand</summary>

&nbsp;
>- **`GitHub Readme`**:
>	- github.com/ssjshields/archetype-counter

>- **`GitHub Issues`**:
>	- github.com/ssjshields/archetype-counter/issues

>- **`Discord Link`**:
>	- discord.gg/rYg7ntqQRY

</details>

&nbsp;

## Troubleshooting 🔌
<details>
<summary>Click to expand</summary>

### Open Debug Folder
>- Opens the counter debug folder that holds .txt and .png file (Typically for the Archetype to further diagnose an issue).

### Open Name Fix File
>- Opens the "Config_PokemonNameFix.txt" file to manually add in failed name entries (Should not be needed with automated failed dialog scans to correct issue).

### Toggle Debug Window
>- Give the ability to show the counter console window to help determine 

> WARNING: Do not close the console window from the taskbar as it will close the exit the entire counter. Simply reselect the toggle option to make the console window disappear.

### Test Toast Notification
>- Allows to you manually invoke the toast notifications to ensure they work and/or are turned on via the Windows system.

</details>

&nbsp;

## Exit ❌
<details>
<summary>Click to expand</summary>

&nbsp;
>- Closes the counter and all of its current processes.

</details>

&nbsp;

# FAQ 📖
### How does the Counter work?
> [OCR](https://www.ibm.com/blog/optical-character-recognition/) and several other utilities are used to scan screenshots of monster names and compares them against a list

> Monster nameplates processed using images passed through [ImageMagick](https://imagemagick.org/index.php) formula by realmadrid1809 + additional logic cleanup in PowerShell

> Utilities scripted with PowerShell 5.1 by AnonymousPoke

&nbsp;

### Does the counter work on Linux, MacOS or mobile?
> Unfortunately no - the Counter utilizes built in WinForms in Powershell + Tesseract OCR & ImageMagick.

&nbsp;

### Does this work with custom PokeMMO client themes?
> Yes, it will work with all custom themes, but the monster nameplate text will be modified to be OCR compatible.

> Client theme.xml, font values and graphical assets (AC folder) are inserted into the currently installed theme list.

&nbsp;

### Does the Counter track Shiny Pokémon?
> Yes it does and it will also provide a prompt indicating a shiny is on the screen (Extra layer to prevent defeating or running from the shiny).

&nbsp;

### Does the Counter track Alpha Pokémon?
> Yes, but only as a total count in the counter - will not add to the normal tracked monster count.

&nbsp;

### Does the Counter track Legendary Pokémon?
> Yes.

&nbsp;

### How are Eggs and Fossils tracked?
> They are not tracked. You will need to manually set the count within the counter menu.

&nbsp;

### Does the counter track Zorua or Zoroark?
> Due to this Pokémon and it's ability.. No.

&nbsp;

### Can the Counter track 2 different Pokémon in a double wild battle or horde?
> Yes it does.

&nbsp;

### Can I convert data from other counters?
> Yes, but only the total encountered count.

> Manually editing profiles may cause corruption - located in `<Profile Name>\Config_<Profile Name>.txt`

&nbsp;

### When I go into battle, the counter does not count or go busy. What do I do?
> Jump on our discord so we can look to resolve the issue.

&nbsp;

### How do I fix incorrect scanned Pokémon names with the 'Name Fix' file?
> This should be done automatically via the counter when a scan fails and following the prompt. But, below is how to add manually.

> When a monster is incorrectly scanned via OCR, you take the 'failed' name and place it on the left hand side of the semi-colon and then take the correct monster name and place to the right of the semi-colon.

> `(Ex: Gastiy; Gastly)`

> You will need to restart the counter for these changes to take effect.

&nbsp;

### How do I manually remove additional characters/symbols from the failed scan?
> Open up the 'Name Fix' file from the counter menu and take the partial/incorrect text and place on the left hand side of the semi-colon and then place the word 'Blank' on the right hand side of the semi-colon

> `(Ex: GastE; Blank)`

> When a 'Blank' is provided on the right hand side of the semi-colon, this indicates the counter to completely remove that specific text - You will need to turn the counter OFF and then back ON for these changes to take effect

&nbsp;

### How can I report a bug?
> Before creating a report, review this readme and [the existing issues](https://github.com/ssjshields/archetype-counter/issues)

> Open the Debug folders from the Debug submenu, attach the `.png` and `.txt` file.

&nbsp;

# Consider giving a Star! ⭐
If you like this project please give it a [Star](https://docs.github.com/en/enterprise-cloud@latest/get-started/exploring-projects-on-github/saving-repositories-with-stars#starring-a-repository). Thanks!

&nbsp;

# Feel like exploring? 🧭
[Archetype Theme](https://github.com/ssjshields/archetype#readme) is a total visual overhaul for [PokeMMO](https://pokemmo.com/). Includes animations and customization features.

&nbsp;

# Disclaimer
This software has been created purely for the purposes of academic research. It is not intended to be used to attack other systems, nor does it provide the user any unfair advantage. It does not hook or inject into any game processes. There are no artificial inputs or hotkeys simulated. Project maintainers are not responsible or liable for misuse of the software. Source code can be viewed in the batch files. Use responsibly.

&nbsp;
# Contact and Support
[![discord](https://assets-global.website-files.com/6257adef93867e50d84d30e2/62594fddd654fc29fcc07359_cb48d2a8d4991281d7a6a95d2f58195e.svg)](https://discord.gg/rYg7ntqQRY)

[Open a GitHub issue](https://github.com/ssjshields/archetype-counter/issues/new)
