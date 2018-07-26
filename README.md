# Scaffolding of your next tas

## Installation

    # Dependencies mandatory during setup and build of your tas
    make install
    
    # Dependencies about the development of this project, "sudo" right might be asked
    make install-dev

## Handle conflicts, methods not allowed and cross OS

Here are some points to clarify to understand some choices made in this project :

* Problem : Method io.popen is not allowed in Bizhawk
    * So we can't use io.popen('/bin/ls') to list the files which are representing the TAS
    * The lfs library is used outside Bizhawk's scope (because of .dll or .so file switch OS)
    * Solution : The file bizhawk/files.lua is filled (see make bizhawk-lfs)
    * => When you register a file for the TAS (see make register), take care of the files order
* Problem : Method require on different OS & package.preload & . in folder's name
    * The mediator.lua file (from the mediator_lua library) is copied to the root of the TAS

## Preloads

If a savestate have to be load before a tas, you can configure it in bizhawk/preloads.lua

    # Example
    # A folder named my-current-tas have to exists in the tas directory
    # A savestate named my-savestate have to exists in the bizhawk/savestate directory
    return {
        ['my-current-tas'] = 'my-savestate',
    }

## Todo

* Add input visualizer (like stepmania)
* Add time splitter (like live split)
* Explain the whole process
  * start.lua for Bizhawk
  * the continuing reboot core process
  * config.lua playground
