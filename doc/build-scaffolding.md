## First of all

    Copy the archive tas-scaffolding.tar.gz into your project
    (ex: cp tas-scaffolding.tar.gz ../tas-your-game && cd tas-your-game)
    Then uncompress it (tar zxvf tas-scaffolding.tar.gz) 

## Installation

    make install

## Init

    make init

## Register your first file for the tas

    # TAS : your category name slugified (ex : any%, 100%, ...)
    # FILE : the filename (ex : 0-init.lua)
    make TAS=... FILE=... register

## Set the current tas name

    # Update the value of the variable currentTas in config.lua
    # by the given name from above (the TAS value)

## Update the README

    # There is a default text in the README of your new project.
    # Update it with the minimum information you have. 

## Update the Makefile

    # You can remove the tasks into the section for the scaffolding
    # and the big section comments

## Operations if Bizhawk's OS and your OS are not the same

    ## Example with Bizhawk running on Windows with Parallels (Mac)
    
    # Symlink of the file start.lua (to launch with Bizhawk under Tool > Lua Console)
    cd Desktop 
    ln -s /path/to/tas-of-your-game/start.lua start-your-game.lua