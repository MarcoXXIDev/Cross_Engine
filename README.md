#Cross Engine for Friday Night Funkin'
Here's another custom engine! Right now, there's nothing too interesting here. Ghost tapping, ratings, miss counting, custom health bar colors, all very simple. But soon I'll add more stuff to make modding easier. For now though, this is an engine for people who love the OG FNF, but like a few features from mods. Soon I'll also release a guide to adding characters, songs, charts and more, but if you really wanna get started right now, look at this guide: https://gamebanana.com/tuts/13798
##How to install?
This is for compiling the game's source code. If ya just wanna play the game normally, I'll add a link on GameBanana. For now though, here's a link to the OG FNF:
https://ninja-muffin24.itch.io/funkin

(this is all copy pasted from Ninjamuffin's guide lol)

Installing the Required Programs
First, you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple).

Install Haxe 4.1.5 (Download 4.1.5 instead of 4.2.0 because 4.2.0 is broken and is not working with gits properly...)
Install HaxeFlixel after downloading Haxe
Other installations you'd need are the additional libraries, a fully updated list will be in Project.xml in the project root. Currently, these are all of the things you need to install:

flixel
flixel-addons
flixel-ui
hscript
newgrounds
So for each of those type haxelib install [library] so shit like haxelib install newgrounds

You'll also need to install a couple things that involve Gits. To do this, you need to do a few things first.

Download git-scm. Works for Windows, Mac, and Linux, just select your build.
Follow instructions to install the application properly.
Run haxelib git polymod https://github.com/larsiusprime/polymod.git to install Polymod.
Run haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc to install Discord RPC.
You should have everything ready for compiling the game! Follow the guide below to continue!

At the moment, you can optionally fix the transition bug in songs with zoomed-out cameras.

Run haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons in the terminal/command-prompt.

##How do I actually compile the game?
Well, it's pretty simple. At the root of the project, open Command Prompt, Power Shell, or whatever equivalent you have of that. Then run 
lime test (whatever platform: mac, linux, windows, or html5) -debug. 
If you write anything other than -debug at the end, it'll be impossible to open up the HaxeFlixel debug menu :) Thanks for reading this
