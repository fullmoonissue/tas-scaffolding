# TAS Scaffolding

## Explanation

This project aims to help creating a TAS running on
[BizHawk](https://github.com/TASVideos/BizHawk).

    /!\ Warning /!\
    This project was created with the following configuration :
    * Code running on Mac OS
    * BizHawk running on Windows 10 (with Parallels)

You can assign the inputs to "push" to BizHawk by passing a lua table to his `joypad`.

    Example :
    joypad.set({['P1 Start'] = true})

So, the goal is to create a huge lua table which will have a frame as key and inputs as value.

    Example :
    local joypadSet = {
        [2450] = {['P1 Select'] = true},
        [3200] = {['P1 Cross'] = true, ['P1 Square'] = true},
    }

Inputs will be played at the wanted frame during the infinite loop calling the frame advance.

    Example :
    local joypadSet = {[2450] = {['P1 Select'] = true}}
    while (true) do
        -- Retrieve the current frame ...
        local fc = emu.framecount()
    
        -- ... and "push" the inputs (if inputs are set for this frame)
        if(joypadSet[fc]) then
            joypad.set(joypadSet[fc])
        end
    
        emu.frameadvance()
    end

The huge lua table is build by the concatenation of lua tables coming from multiple files
(in order to split inputs into multiple files, it's a cleaner way).

    Example (of file naming) :
    0-init.lua
    1-level-1-the-intro.lua
    ...
    15-level-15-the-final.lua
    
    ==> Here, the files start with an integer to sort them naturally

These files are into a folder which represents the category of the TAS (so, multiple tas
for the same game is possible) into the tas folder (in the root of the project).

    Example (of tree of folder) :
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

You can add a new file by executing a make task like `make TAS=any% FILE=0-init.lua register`.
It takes care of adding a file (which have for skeleton the file located in
`templates/new-tas-file.lua`) and update the listing of the files (explained just after).

A file (full of inputs), looks like this :

    Example (tas/any%/0-init.lua) :
    local input = require('tas/input')()
    input:select(2450)
    input:cross(3200, 5)
    
    return input:all()

All wanted inputs will be written with methods which represents a "button" in the joypad.

But, to get the list of files for a particular TAS, a scan of all required files have to be
done. Two methods exist :

* Using io.popen and execute `/bin/ls`
* Using [lfs](https://github.com/keplerproject/luafilesystem) and the `dir` method

None of these options can be used because :

* BizHawk forbid the method io.popen
* When you `luarocks install lfs`, switch your OS, you will have a .so file or not.

Lfs is still used in the project but only for the host OS (not for BizHawk's running OS).

To fix the listing issue, a make task use lfs to scan the folders and write the listing into
a file. This file will be read as the "real" listing of files without properly doing a scan.
This one is called files.lua (in the bizhawk folder) and the make task to call is :
`make bizhawk-lfs`

So, the current (categorized) TAS have to be set to know which inputs have to be played.
This value is located in the file config.lua at the root of the tas project.

    Example (in config.lua) :
    local currentTas = 'any%'

At this point, you are able to create a TAS, here are the sequences to go for it :

    - Go to your project's folder
    $ cd /path/to/projects
    
    - Git clone this project
    $ git clone https://github.com/fullmoonissue/tas-scaffolding.git
    $ cd tas-scaffolding
    
    - Create the folder where your TAS will be
    $ mkdir /path/to/projects/tas-of-my-game
    
    - Call the task `build-scaffolding` to build the structure of your TAS project
    $ make TAS_FOLDER=/path/to/projects/tas-of-my-game build-scaffolding
    
    - Go to your TAS project
    $ cd /path/to/projects/tas-of-my-game
    
    - Let's say you'll make the any%, update the value of currentTas in config.lua
    $ vi config.lua (or update the file with your favorite IDE)
    - In this same file, you can assign the savestate slot which will be loaded
    when Bizhawk will be rebooted, let's say you will load the slot 0 after reboot
    $ vi config.lua (and update the value of loadSlot to 0)
    
    - Launch the Lua Console of BizHawk on the start.lua file
    BizHawk > Tool > Lua Console > /path/to/projects/tas-of-my-game/start.lua
    
    - Register a new TAS file (ex : 0-init.lua)
    $ make TAS=any% FILE=0-init.lua register
    
    - Add / Update some inputs
    $ vi tas/any%/0-init.lua
    
    - Reboot BizHawk
    BizHawk > Emulation > Reboot Core
    
    => Here you are. You will alternate with inputs updated and BizHawk rebooted.
    Then add a new file and repeat the process until your TAS is done.

## Plugins

Some additional goodies are present, here they are :

#### Macro

The file `tas/macro-collection.lua` allows you to put a collection of inputs under a function.

    Example 1 :
    example_without_custom_inputs = function(currentFrame)
        input:right(currentFrame)
        currentFrame = currentFrame + 2
        input:right(currentFrame)
        
        return currentFrame
    end
    
    Example 2 :
    example_with_custom_inputs = function(currentFrame, iterations)
        return input:add(
            currentFrame,
            iterations,
            {
                [input.currentPlayer .. ' Circle'] = true,
                [input.currentPlayer .. ' Cross'] = true,
            }
        )
    end

#### Overlay

The file `tas/overlay-collection.lua` allows you to put a collection of overlays.

An overlay is information displayed on the screen with a style, like :

* The current frame
* Values from the memory

The library [mediator_lua](https://github.com/Olivine-Labs/mediator_lua) is used (installed
by `make install`) but to avoid cross OS library preloading problem, the core file of the
mediator is copied at the root of your TAS (during the scaffolding).

The overlay which display the current frame will be already displayed.

#### Archive bk2

[Associated documentation](http://tasvideos.org/Bizhawk/BK2Format.html).

One of the 5 files of the archive is "Input Log.txt" which is a representation of your inputs.

So, to "translate" the lua inputs into BizHawk inputs, the make task to do it is
`make TAS=any% bizhawk-dump` (a folder by TAS will be created in the bizhawk folder).

#### Preloads

If a savestate (as a file, not a slot) have to be load before a tas :

* Place your savestate into `bizhawk/savestate`
* Fill the lua table in `bizhawk/preloads.lua`

The file `bizhawk/preloads.lua` will looks like this :

    return {
        ['any%'] = 'the-savestate-any',
        ['100%'] = 'the-savestate-100',
    }

## Tests & Development

    # Dependencies
    make install
    
    # Dev dependencies, "sudo" right might be asked
    make install-dev

    # Check code style
    make check
    
    # Tests
    make test

## Todo (bonus)

* Add an input visualizer (like stepmania)
* Add a tool to speedrun games (preloads + a little time splitter)