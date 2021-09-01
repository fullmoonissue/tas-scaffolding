# History

For anyone interested, the history of the creation of this project is written here.

## Origins

Many years ago, I was thrilled when I have watched the famous [Morimoto's TAS of Super Mario Bros 3](https://www.youtube.com/watch?v=qXEEobKbfX0).

I don't remember exactly after that how the world of (tool-assisted) speedruns entered in my life (maybe it was with [88 miles à l'heure](https://www.youtube.com/playlist?list=PLD400FA8A50319D8C), a show about TAS).

## Promise

After many years watching (TA) Speedruns and many times saying to myself that "It will be very cool to TAS, no ?", I've promised to myself to start TASing on my birthdate.

For my first game to TAS, I wanted :

- a PS1 game (the console I've played the most)
- no existing TAS of this game
- a "simple" game (no open world)

In 2017, it's a done deal, for my first TAS, [Devil Dice](https://en.wikipedia.org/wiki/Devil_Dice) was chosen.

## BizHawk, Mac and Windows, PHP and Lua

Except for BizHawk, I haven't done a lot of research about which emulator I will work with to TAS.

My computer is a Mac, so I have tested the macOS build of BizHawk. Unfortunately, TAS-Studio and some other tools crashed when launched.

At that time, on the [tasvideos forum](http://tasvideos.org/forum/viewtopic.php?t=12659&start=175), the sentence `With BizHawk 2.0 moving to 64-bit, I can't support the current UI on macOS anymore` will change my way to TAS.

I hadn't the needed experience to give a hand to resolve the problems mentioned in the thread, so I have created a new tool.

It was a PHP project which was reading sentence like `3D1U4DR` (3 Down, 1 Up, 4 Down-Right), create the `Input Log.txt` file and recreate the `bk2` archive for BizHawk.

The major problem was that the time to recreate the archive was longer and longer during the creation of the TAS.

Searching for an other method to create a TAS, I discover that [Lua](http://tasvideos.org/Bizhawk/LuaFunctions.html) can be used to "talk" with BizHawk.

It was two good news in one :

- I wanted to learn Lua, so it was a good use case
- by this manner, it will be faster than the PHP project (no need to recreate constantly the archive file)

Thinking about a hypothetical future submission, I thought that I have to be on the v2 of BizHawk to be at least "version compliant".

This is why today I use Parallels on my Mac : just to launch a Windows 10 with BizHawk v2.x.