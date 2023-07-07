v2.0.2.0 hotfix 1
- Resolved profile corruption issue

2.0.2.0
- Fixed French, Portuguese Brazilian, and Polish language for horde detection (Better translation detection)
- Added in "Home" style Pokémon sprite icons to the Counter
- Adjusted counter to prevent hitting memory limit and crashing (For long shunting sessions)
- Small tweaks to Shiny and Alpha logic count + Additional checks for both counts
- Changed Counter to allow placement on the right hand side of screen on the edge again

3.0.0.0
// Reworks:
- Full GUI redesign (Thanks to nurver and Madrid).
- Full support to work with ANY PokeMMO theme
- Encounter/Safari/Horde/Egg/Fossil tracking have been optimized to be 99.9% accurate.
	
// Features:
- Added additional functionality to track 7 more Pokémon in the "Extra Pokémon Slots" under the counter menu
- Added ability to track "Fossils".
- Added ablity to only track encounters in expanded mode (No Egg/Fossil)
- Added ability to change total count on Encounter/Egg/Fossil.
- Added indicator letting the user know when the counter is "busy".
- Added 5 additional profiles; reorganized rename profile option
- Added name display for current hunt profile in counter menu
- Added additional counter mode for Fossil tracking (Normal/Collapsed)
- Added in ability to close PokeMMO when closing counter (Under Settings in counter menu)
- Added in ability to enable system "beep" sound effect when the total count goes up
- Added in 3 additional custom theme slots
- No longer have to disable Battle Background to track Pokémon in battle.

// Fixes:
- Poke monsters properly refresh on first time seen without restarting counter.
- Dreaded Bulbasaur issue has fully been resolved (Yes I know… finally)
- Fixed false positive virus detection

// Misc:
- Huge performance optimizations and resolved memory leak/limit
- Custom strings are no longer utilized for the counter.
- External software (AutoHotkey) no longer needed to perform main picture taking function.
- Changed Screen Capture method to PrintWindow() which can grab the PokeMMO window on any screen without being in focus.
- Added in PrintScreen method as an alternate picture taking method (Just in case the main capture method fails).
- Added logic for backing up other profiles besides the actively used one
- Added additional debugging options in menu (Normal/Advanced)
- Added in uninstaller as optional way to clean out counter directory.