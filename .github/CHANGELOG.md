Version 2.0.0  
- Performance Improvements implemented in script to speed up counter.
- Screen Capture method been completely reworked for image cropping on the fly + increased speed of script
- Pokémon Egg detection has been enhanced with string files (from counter) to slow down the daycare dialog text. This is necessary for proper egg detection.
- Removed "Reset" button on counter and re-added underneath the "Reset Selector" option in the counter menu called "Current Hunt Profile".
- Removed CJK (Chinese/Japanese/Korean) language set detection capabilities from counter. The current implementation is not up to standard and have no way to properly test at this time. Will revisit in the future.
- Made adjustment to backup folder to include "CurrentProfileState" file alongside the counter config.
- When removing an individual Pokemon from a slot, the Pokemon will move up in the slot order (To avoid duplication of Pokemon within the counter).
- Added in ability to "Ignore" System Language for OCR comparison. You will use this option if the OCR is completely failing and you cannot change your system language. Last possible option to get counter working.
- Added in detection/count for Alpha Pokemon.
- Added total count to "Expanded" mode on the counter.
- Added in ability to manually increase/decrease total count.
- Added in the ability to rename Hunt Profile names - to better distinguish hunt type.
- Added in "Open DEBUG MODE Folder" selection under Debug Mode in the counter menu. This allows easy access to the folder when debugging issues on counter failures.
- Added support for "Polish" language (Recent update from PokeMMO).
- Added in ability to manually set Pokémon in the counter slot - without having to find in-game first (Just right click on an empty slot in the counter).
- Added in support for 720p under "Screen Mode" in the counter menu (This gives a better chance for lower resolutions not failing when using counter).
- Resolved Bulbasaur bug adding into counter slot when no Pokémon match found with OCR.
- Resolved issue when Weather effects ended. The counter captured the word "disappeared" for appeared - Now it only goes after exact word.
- Resolved issue where in some scenarios a "shiny" Pokémon was not detected by counter (For Dialog prompt).

*Big thank you to everyone that assisted in the testing process of the counter. Without you, the counter would not have become this amazing tool for the community 🙂 

Version 2.0.1  
- Adjusted scan time to ensure more accurate results in safari and other normal encounters
- Fixed Debug folder not generating properly

Version 2.0.2 - BETA
- Fixed French, Portuguese Brazilian, and Polish language for horde detection (Better translation detection)
- Added in "Home" style Pokémon sprite icons into counter
- Adjusted counter to prevent hitting memory limit and crashing (For long shunting sessions)
- Small tweaks to Shiny and Alpha logic count