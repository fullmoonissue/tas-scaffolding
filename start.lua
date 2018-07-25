local config = require('config')
local paths = require('paths')
local preloads = require(paths['preloads'])
local dump = require('tas/dump')()
-- Add the mediator for events management
local mediator = require('mediator')()

-- Retrieve the inputs of the current tas
local joypadSet = dump.fromLuaFilesToLuaInputs(
    paths['tas'],
    require(paths['files']),
    config['currentTas']
)

-- Preload a savestate, if exists
if(preloads[config['currentTas']] ~= nil) then
    savestate.load(paths['savestate'] .. '/' .. preloads[config['currentTas']])
end

-- Load the current savestate
if(config['loadSlot'] ~= nil) then
    savestate.loadslot(config['loadSlot'])
end

-- Add overlays
require('tas/overlay-collection')().applySubscriptions(mediator)

while (true) do
    local fc = emu.framecount()

    mediator:publish({ 'frame.displayed' }, fc)

    if(joypadSet[fc]) then
        joypad.set(joypadSet[fc])
    end

    if(config['doSaveStateAt'] ~= nil and config['saveSlot'] ~= nil and fc == config['doSaveStateAt']) then
        savestate.saveslot(config['saveSlot'])
    end

    emu.frameadvance()
end