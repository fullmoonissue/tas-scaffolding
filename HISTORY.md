# History

For anyone interested, the history of this project is written here.

## Origins

Many years ago, I was thrilled when I have watched the famous [Morimoto's TAS of Super Mario Bros 3](https://www.youtube.com/watch?v=qXEEobKbfX0).

I don't remember exactly after that how the world of (tool-assisted) speedruns entered in my life (maybe it was with [88 miles à l'heure](https://www.youtube.com/playlist?list=PLD400FA8A50319D8C), a French show about TAS).

## Beginning

After many years watching Tool-Assisted Speedruns and many times saying to myself that "It will be very nice to TAS, no ?", I have indeed started in 2017.

My first game TASed was [Devil Dice](https://en.wikipedia.org/wiki/Devil_Dice) (only the puzzle mode), because :

- not too complicated for a first TAS
- PS1 game (the console I've played the most)

## BizHawk, Mac and Windows, PHP and Lua

Except for BizHawk, I haven't done a lot of research about which emulator I will work with to TAS.

I had just one thing in mind : I want to be able to script all my inputs and never let my fingers play directly (to be the more precise possible).

My computer is a Mac, so I have tested the macOS build of BizHawk (v1.13). Unfortunately, TAS-Studio and some other tools crashed when they were launched.

At that time, on the [tasvideos forum](http://tasvideos.org/forum/viewtopic.php?t=12659&start=175), the sentence `With BizHawk 2.0 moving to 64-bit, I can't support the current UI on macOS anymore` will divert me from TAS-Studio.

I hadn't the needed experience to give a hand to resolve the problems mentioned in the thread, so I have created a new tool.

It was a PHP project which was reading sentence like `3D1U4DR` (3 Down, 1 Up, 4 Down-Right), create the `Input Log.txt` file and recreate the `bk2` archive for BizHawk.

The major problem was that the time to recreate the archive was longer and longer during the creation of the TAS.

Searching for an other method to create a TAS, I discover that [Lua](http://tasvideos.org/Bizhawk/LuaFunctions.html) can be used to "talk" with BizHawk.

It was two good news in one :

- I wanted to learn Lua, so it was a good use case
- By this manner, it will be faster than the PHP project (no need to recreate constantly the archive file)

This is why today I use the software `Parallels` on my Mac : just to launch a Windows 10 with BizHawk v2.x.

## Today

Thanks to this `tas-scaffolding` project, I was able to create multiple TAS (Devil Dice, Bust A Groove, Rival Schools mini-games, ...).

Since the switch to Windows to launch BizHawk, I haven't really taken a look at TAS-Studio which works now on this OS, but I will do, one day or another.