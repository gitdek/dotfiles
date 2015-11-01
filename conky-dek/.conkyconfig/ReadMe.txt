ConkyBar - V2.0
===================
I've tested this running an up-to-date linux arch 64bit installation but it should work on other
distro's too. It uses nothing specific for linux arch.

Colors (for color0 + lua files)
====================
Arch 		1793d0	(blue)
Mint 		77B753	(green)
Ubuntu		dd4814	(orange)
Debian 		d70a53	(red)

Installation steps:
====================
1) Put the folder .conkyconfig in your home folder.
2) Make sure your conky version stupport lua and nvidia (arch: conky-lua-nv)
3) Make sure you've got all the dependencies (hddtemp, iostat, ...) and they are running (also on startup)
4) Make conky_start (and all files in /lua and /scripts) executable.
5) Add conky_start to your startup programs
6) Make sure you've installed the fonts in /fonts
7) Edit the system specific setting, for example in conky_network change it to your wifi/eth interface

Enjoy!
(you can ignore the debug folder)


Known bugs
====================
- Pauze banshee -> wrong current position value -> bug in banshee --query-position -> I can't solve it
- The hdd graph (ring) does have a blank space in the beginning
- The outlinement is not perfect
- Seconds uptime are 1sec off

Updates
====================
-V2.0 general improvements, updated images, improved allignment, code cleanup, ...
-V1.0 initial commit

Credits
====================
Look based on: Conky Launchpad - http://freeazy.deviantart.com/art/Conky-Launchpad-186251285
Thanks to crunchbang forums - http://crunchbang.org/forums/viewtopic.php?id=16909
Icons - forgot sorry
Banshee implementation - kaivalagi  - http://ubuntuforums.org/showthread.php?t=1223883

Feel free to fork/improve

