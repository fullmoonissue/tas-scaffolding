local config = require('config')
local preloads = require('preloads')
local bj = require('utils/joypad')
local Mediator = require('utils/mediator')

-- Retrieve the inputs of the current tas
local joypadSet = bj:getInputs(config['currentTas'])

-- Preload a savestate if needed
if(preloads[config['currentTas']] ~= nil) then
    savestate.load('savestate/' .. preloads[config['currentTas']])
end

-- Load the current savestate
if(config['loadSlot'] ~= nil) then
    savestate.loadslot(config['loadSlot'])
end

-- Add the mediator for events management
mediator = Mediator()

-- Add custom overlay
require('start_overlay')

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