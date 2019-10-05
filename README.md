# TAS Scaffolding

## Usage

    # Clone
    git clone https://github.com/fullmoonissue/tas-scaffolding.git
    cd tas-scaffolding
    
    # Build
    mkdir /path/to/your/tas
    make TAS_FOLDER=/path/to/your/tas build-scaffolding
    
    # Create your tas
    cd /path/to/your/tas
    make help (to see tasks you can do)
    
    => Open your tas project with your favorite IDE and update the README.md
    => It's easier to add a new file to your tas by using the `make register` task
    => Good luck !

## Explanation

This project aims to help creating a TAS running on [BizHawk](https://github.com/TASVideos/BizHawk).

### Warning

    This project was created with the following configuration :
    * Code running on MacOS
    * BizHawk running on Windows 10 (with Parallels)

### Introduction

You can assign the inputs to send to BizHawk by passing a lua table to his `joypad`.

    Example :
    
    joypad.set({['P1 Start'] = true})

So, the goal is to create a huge lua table which will contains all the inputs for a tas.
These table will have frame as key and inputs as value.

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
    
        -- ... and send the inputs to BizHawk (if inputs are set for this frame)
        if(joypadSet[fc]) then
            joypad.set(joypadSet[fc])
        end
    
        emu.frameadvance()
    end

The huge lua table can be build by the concatenation of lua tables coming from multiple files
(it's a cleaner way that having all in one file).

    Example (of file naming) :
    
    0-init.lua
    1-level-1-the-intro.lua
    ...
    15-level-15-the-final.lua
    
    ==> Here, the files start with an integer to sort them naturally

These files are into a folder which represents the category of the TAS (so, multiple tas
for the same game is possible) into the tas folder.

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

You can add a new file by executing a `make` task like `make TAS=any% FILE=0-init.lua register`.
It takes care of adding a file (which have for skeleton the file located in
`assets/templates/new-tas-file.lua`) and update the listing of the files that have to be load
(explained in Technical difficulties).

A tas file (full of inputs), looks like this :

    Example (tas/any%/0-init.lua) :
    
    local input = require('core/input')
    
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

### Technical difficulties

To get the list of files for a particular TAS, a scan into the folder have to be done. Two methods exist :

* Using io.popen and execute `/bin/ls`
* Using [lfs](https://github.com/keplerproject/luafilesystem) and the `dir` method

None of these options can be used because :

* BizHawk forbid the method io.popen
* When you launch `luarocks install lfs`, switch your OS, you will have a .so file or not (so not reliable).

Lfs is still used in the project but only for the host OS (not for BizHawk's running OS).

To fix the listing issue, a `make` task use lfs to scan the folders and write the listing into
a file. This file will be read as the "real" listing of files without properly doing a scan.
This one is `configuration/files.lua` and the `make` task to do this listing is : `make bizhawk-lfs`

### Installation

At this point, you are able to create a TAS, here are the steps :

    - Go to your working directory
    $ cd /path/to/your/projects
    
    - Clone this project
    $ git clone https://github.com/fullmoonissue/tas-scaffolding.git
    
    - Go into it
    $ cd tas-scaffolding
    
    - Create the folder where your TAS will be
    $ mkdir /path/to/your/projects/tas-of-your-game
    
    - Call the task `build-scaffolding` to build the structure of your TAS project
    $ make TAS_FOLDER=/path/to/your/projects/tas-of-your-game build-scaffolding
    
    - Go to your TAS project
    $ cd /path/to/your/projects/tas-of-your-game
    
    - Let's say you'll make the any%, update the value of currentTas (with vi or your in your IDE)
    $ vi configuration/play.lua (local currentTas = 'any%')
    - In this same file, you can assign the savestate slot which will be loaded
    when Bizhawk will be rebooted, let's say you will load the slot 0 after reboot
    $ vi configuration/play.lua (local loadSlot = 0)
    
    - Launch the Lua Console of BizHawk on the start.lua file
    BizHawk > Tool > Lua Console > /path/to/your/projects/tas-of-your-game/start.lua
    
    - Register a new TAS file (ex : 0-init.lua)
    $ make TAS=any% FILE=0-init.lua register
    
    - Add / Update some inputs
    $ vi tas/any%/0-init.lua
    
    - Reboot BizHawk
    BizHawk > Emulation > Reboot Core
    
    => Here you are. You will alternate with inputs updated, BizHawk rebooted and put some savestate.
    
    Finally, add new files for the tas and repeat the process until your tas is done.

### Summary of the folders' structure

    tas-scaffolding
        |
        -> assets
            |
            -> ram-watch (Location of your RAM Watch files ; Extension : .wch)
            |
            -> templates
                |
                -> .gitignore (For your tas project after scaffolding)
                |
                -> Makefile (For your tas project after scaffolding)
                |
                -> new-tas-file.lua (Template of a new file added by the `make` task to register a new one [in your tas])
                |
                -> README.md (For your tas project after scaffolding)
        |
        -> configuration
            |
            -> files.lua (Lua table which contains all the files to load by tas)
            |
            -> paths.lua (Lua table which contains all the paths to specific folders)
            |
            -> play.lua.dist (Configuration file of the played tas)
        |
        -> core
            |
            -> input.lua (Tool to add a new input to send to Bizhawk)
        |
        -> plugins
            |
            -> bizhawk
                |
                -> bk2 (Location of your .bk2 archive)
                |
                -> bizhawk.lua (Tool to dump various contents)
            |
            -> macro
                |
                -> collection.lua (Location where you will add your own macro)
            |
            -> overlay
                |
                -> collection.lua (Location where you will add your own overlay)
            |
            -> preload
                |
                -> collection.lua (Lua table which contains the savestate to load before a certain tas)
                |
                -> savestate (Location of your savestates as file)
        |
        -> scripts (Location of some pre-configured scripts and your own scripts)
        |
        -> tas (Location of your tas by category like any%, 100%, ...)

## Plugins

Some additional goodies are present, here they are :

#### Macro

The file `plugins/macro/collection.lua` allows you to put a collection of inputs under a function to not rewrite them.
Some examples are written into the precised file and the associated call into `assets/templates/new-tas-file.lua`.

#### Overlay

The file `plugins/overlay/collection.lua` allows you to put a collection of overlays.

An overlay is information displayed on the screen with a style, like :

* The current frame
* Values from the memory

The library [mediator_lua](https://github.com/Olivine-Labs/mediator_lua) is used (installed
by `make install`) but to avoid cross OS library preloading problem, the core file of the
mediator, `mediator.lua`, is copied at the root of your TAS (during the scaffolding).

The overlay which display the current frame is already created and displayed by default.

#### Archive bk2

[Associated documentation](http://tasvideos.org/Bizhawk/BK2Format.html)

One of the 5 files of the archive is `Input Log.txt` which is a representation of your inputs.

So, to "translate" the lua inputs into BizHawk inputs, the `make` task to do it is `make TAS=any% bizhawk-dump`.

After that, your text file will be located in `bizhawk/bk2/any%`.

#### Preloads

If a savestate (as a file, not a slot) have to be load before a tas :

* Place your savestate into `plugins/preload/savestate`
* Fill the lua table in `plugins/preload/collection.lua`

The file `plugins/preload/collection.lua` have to look like this :

    return {
        ['any%'] = 'the-savestate-file-for-any%',
        ['100%'] = 'the-savestate-file-for-100%',
    }

#### Screenshots

If you want to do a screenshot of a specific frame (or many frames) :

* Fill the lua table in `plugins/screenshot/configuration.lua`

The file `plugins/screenshot/configuration.lua` have to look like this :

    return {
        -- Frame number as key ; Path to your future screenshot as value
        [245] = 'C:\\Users\\your-username\\Documents\\screenshot_245.png',
        [690] = 'C:\\Users\\your-username\\Documents\\main_screen.png',
    }

## Development & Tests

    # Dev dependencies, "sudo" right might be asked
    make install

    # Check code style
    make cs-check
    
    # Tests (code)
    make test
    
    # Tests (with a game)
    [Please check the "Warning" section above to understand my way of testing all the process]
    make TAS_FOLDER=/path/to/tas/project/test-tas-scaffolding build-scaffolding
    cd ~/Desktop && ln -s /path/to/tas/project/test-tas-scaffolding/start.lua test-scaffolding.lua (for Parallels)
    1. Setup
    => Launching Parallels then BizHawk then a game
    => Then I select the menu Tools -> Lua Console and then select the test-scaffolding.lua (previously created) file
    2. Checks
    2a. No tas file added
    => Here, I check that no errors are displayed on the lua console before continuing
    => Else I fix into test-tas-scaffolding (and I do a Emulation -> Reboot Core to recheck)
    => And once the fix is done, I propagate it into the tas-scaffolding project
    2b. New tas file added
    => Here, I register a new file (make TAS=any% FILE=0-init.lua register <= from test-tas-scaffolding folder)
    => Then add an input enough long to be viewed after (ex: input:start(cf + 650, 200) in tas/any%/0-init.lua)
    => Then update the value in configuration/play.lua (local currentTas = 'any%')
    => Then display inputs in BizHawk (View -> Display inputs)
    => Finally, I reboot the core (cf 2a. above) and check that the framecount overlay and my inputs are displayed
    => Else I do the fixes (cf 2a.)

## Todo

* Generator of description for youtube, tasvideos.org, ...
* Make some schemas in addition to the text in the README (plantUML ? mermaid ?)
* Make a video about the usage of this project
