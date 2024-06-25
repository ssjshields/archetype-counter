:: Archetype Counter Uninstaller

:: wait
timeout 3

:: move
cd ..
cd ..

:: cleanup
RMDIR "archetype-counter" /S /Q
RMDIR "archetype-counter-testing" /S /Q
RMDIR "archetype-counter-development" /S /Q
RMDIR "archetype-counter-main" /S /Q

