# TAS Scaffolding

## Table of contents

- [Explanation](#explanation)
  - [Warning](#warning)
  - [Introduction](#introduction)
  - [Technical difficulties](#technical-difficulties)
  - [Installation](#installation)
- [Features](#features)
    - [Macro](#macro)
    - [Overlay](#overlay)
    - [Archive bk2](#bizhawk-bk2-archive)
    - [Savestate](#savestate)
    - [Screenshots](#screenshots)
    - [Benchmark](#benchmark)
- [Development & Tests](#development--tests)
- [Changelog](#changelog)

## Explanation

This project aims to help in creating a TAS running on [BizHawk](https://github.com/TASVideos/BizHawk).

### Warning

```
This project was created with the following configuration :

* Shell : zsh
* File archiver : 7-Zip
* Code running on MacOS 10.15.7 (Catalina)
* BizHawk running on Windows 10 (with Parallels)
* The ~/Desktop folder is the bridge between Mac and Windows

More infos in the HISTORY.md file
```

### Introduction

You can assign the inputs to send to BizHawk by passing a lua table to his `joypad`.

```
Example :

joypad.set({['P1 Start'] = true})
```

So, the goal is to create a huge lua table which will contains all the inputs for a tas.
These table will have frame as key and inputs as value.

```
Example :

local joypadSet = {
    [2450] = {['P1 Select'] = true},
    [3200] = {['P1 Cross'] = true, ['P1 Square'] = true},
}
```

Inputs will be played at the wanted frame during the infinite loop calling the frame advance.

```
Example :

local joypadSet = {[2450] = {['P1 Select'] = true}}
while true do
    -- Retrieve the current frame ...
    local fc = emu.framecount()

    -- ... and send the inputs to BizHawk (if inputs are set for this frame)
    if(joypadSet[fc]) then
        joypad.set(joypadSet[fc])
    end

    emu.frameadvance()
end
```

The huge lua table can be build by the concatenation of lua tables coming from multiple files
(it's a cleaner way rather than having all in one file).

```
Example (of file naming) :

0-init.lua
1-level-1-the-intro.lua
...
15-level-15-the-final.lua

==> Here, the files start with an integer to sort them naturally
```

These files are into a folder which represents the category of the TAS (so, multiple tas
for the same game is possible) into the tas folder.

```
Example :

tas
    |
    -> any%
      |
      -> 0-init.lua
      -> ...
    |
    -> 100%
      |
      -> 0-init.lua
      -> ...
```

You can add a new file by executing a `make` task like `make TAS=any% FILE=0-init.lua register`.
It takes care of adding a file (which have for skeleton the file located in
`assets/templates/new-inputs-file.lua`) and update the listing of the files that have to be load
(explained in [Technical difficulties](#technical-difficulties)).

A tas file (full of inputs), looks like this :

```
Example (tas/any%/0-init.lua) :

local input = require('tas/joypadInputs')

-- Push, during 1 frame, the Select button on frame 2450
input:select(2450)

-- Push, during 5 frames, the Cross button from the frame 3200
-- And retrieve the number of the frame after that
local currentFrame = input:cross(3200, 5)

-- Push, during 1 frame, the Square button 6 frames after the previous action
-- (because the variable currentFrame is set after the previous action)
input:square(currentFrame + 6)

-- ... a lot of other inputs inserted here ...

return input:all()
```

### Technical difficulties

During a TAS, the folder which contains the list of the specific files (composing the TAS) have to be scanned. Two methods exist :

* Using `io.popen` and execute `/bin/ls`
* Using [lfs](https://github.com/keplerproject/luafilesystem) and the `dir` method

None of these options can be used because :

* BizHawk forbid the method `io.popen`
* When you install `lfs` (`luarocks install lfs`), switch your OS, you will have a `.so` file or not (so not reliable).

To fix this listing issue, a `make` task scans the folders and write the listing into a dedicated file.
This file will be read as the "real" listing of files without properly doing a scan into the script played by BizHawk.
This one is `configuration/files.lua` and the `make` task to do this listing is : `make bizhawk-lfs`.

### Installation

```
- Go to your working directory
$ cd /path/to/your/projects

- Clone this project
$ git clone https://github.com/fullmoonissue/tas-scaffolding.git

- Go into it
$ cd tas-scaffolding

- Create the folder where your TAS will be
$ mkdir /path/to/your/tas

- Call the task `build-scaffolding` to build the structure of your TAS project
$ make TAS_PATH=/path/to/your/tas build-scaffolding

- Go to your TAS project
$ cd /path/to/your/tas

- Let's say you'll make the any%, update the value of currentCategory (vi is used for the example)
$ vi configuration/play.lua (local currentCategory = 'any%')
- In this same file, you can assign the savestate slot which will be loaded
when Bizhawk will be rebooted, let's say you will load the slot 0 after reboot
$ vi configuration/play.lua (local loadSlot = 0)

- Launch the Lua Console of BizHawk on the start.lua file
BizHawk > Tool > Lua Console > /path/to/your/tas/start.lua

- Register a new TAS file (ex : 0-init.lua)
$ make TAS=any% FILE=0-init.lua register

- Add / Update some inputs
$ vi tas/any%/0-init.lua

- Reboot BizHawk
BizHawk > Emulation > Reboot Core

=> Here you are. You will alternate between the update of the inputs and the reboot of BizHawk.

Finally, add new files for the tas and repeat the process until your tas is done.
```

## Features

### BizHawk, bk2 archive

[Associated documentation](http://tasvideos.org/Bizhawk/BK2Format.html)

One of the 5 files of the archive is `Input Log.txt` which is a representation of your inputs (understood by BizHawk).

So, to "translate" the lua inputs into BizHawk inputs, the `make` task to do it is `make TAS=any% bizhawk-dump`.

After that, your text file will be located in `assets/bk2/any%`.

#### Create the bk2 archive

Launch BizHawk, then your ROM and go to File -> Movie -> Record Movie...

Select the location of the archive (ex: `/path/to/tas/project/assets/bk2/any%.bk2`), type Enter and go to File -> Movie -> Stop Movie

If you want to unzip the bk2 archive : `make BK2_NAME=any% bizhawk-bk2-archive-extract`

### Macro

The file `src/input/macro.lua` allows you to put a collection of inputs under a function to not rewrite them.
Some examples are written into the precised file and the associated call into `assets/templates/new-inputs-file.lua`.

### Overlay

The file `src/overlay/collection.lua` allows you to put a collection of overlays.

An overlay is information displayed on the screen, like :

* The current frame
* Values from the memory
* Draw a HUD

The library [mediator_lua](https://github.com/Olivine-Labs/mediator_lua) is used but to avoid cross OS library preloading problem, the core file of the mediator, `mediator.lua`, is copied at the root of your TAS (during the scaffolding).

Some overlays are available :

* Display the current frame
* Display the tas infos
* Display a grid to layout a HUD

### Savestate

If a savestate (as a file, not a slot) have to be load before a tas :

* Place your savestate into `assets/savestates`
* Fill the lua table in `configuration/savestates.lua`

The file `configuration/savestates.lua` have to look like this :

```
return {
    ['any%'] = 'the-savestate-file-for-any%.State',
    ['100%'] = 'the-savestate-file-for-100%.State',
}
```

### Screenshots

If you want to do a screenshot of a specific frame (or many frames) :

* Fill the lua table in `configuration/screenshots.lua`

```
return {
    -- Frame number as key ; Path to your future screenshot as value
    [245] = 'C:\\Path\\To\\TasProjects\\YourTAS\\assets\\screenshots\\screenshot_245.png',
    [690] = 'C:\\Path\\To\\TasProjects\\YourTAS\\assets\\screenshots\\main_screen.png',
}
```

## Development & Tests

* [Selene](https://github.com/Kampfkarren/selene) : linter
* [LuaUnit](https://github.com/bluebird75/luaunit) : unit-testing framework

```
# Dev dependencies
make install

# Check code style
make code-style-check

# Tests (code)
make test

# Tests (with a game)

[Please check the "Warning" section above to understand the way of testing all the process]

1. Setup test game environment
    make TAS_PATH=/path/to/tas/project/test-tas-scaffolding build-scaffolding
    cd ~/Desktop
    ln -s /path/to/tas/project/test-tas-scaffolding/start.lua test-scaffolding.lua (for Parallels)
2. Setup Bizhawk
    a. Launch Parallels then BizHawk then a game
    b. Menu Tools -> Lua Console and then select test-scaffolding.lua file (previously created)
3. Checks
    Register a new file (make TAS=any% FILE=0-init.lua register, from test-tas-scaffolding project folder)
    Then add an input enough long to be viewed after (ex: input:start(cf + 650, 200) in tas/any%/0-init.lua)
    Then update the value in configuration/play.lua (local currentCategory = 'any%')
    Then display inputs in BizHawk (View -> Display inputs)
    Finally, reboot the core (Emulation -> Reboot Core) and check that the inputs are displayed

    If an error is displayed on the lua console
    Then fix into test-tas-scaffolding project, close the Lua Console and repeat 2b. (to recheck)
    And once the fix is done, propagate the fix into the tas-scaffolding project

The command make test-overall will help to test much faster the whole scaffolding process.

```

## Changelog

[Over here](./CHANGELOG.md)