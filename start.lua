local config = require('config')
local paths = require('paths')

-- Retrieve the inputs of the current tas
local joypadSet = require('bizhawk/dump')().fromLuaFilesToLuaInputs(
    paths['tas'],
    require(paths['files']),
    config['currentTas']
)

-- Preload a savestate, if exists
local preloads = require(paths['preloads'])
if(preloads[config['currentTas']] ~= nil) then
    savestate.load(paths['savestate'] .. '/' .. preloads[config['currentTas']])
end

-- Load the current savestate, if exists
if(config['loadSlot'] ~= nil) then
    savestate.loadslot(config['loadSlot'])
end

-- Add overlays
local mediator = require('mediator')()
require('tas/overlay-collection')().applySubscriptions(mediator)

while (true) do
    -- Retrieve the current frame ...
    local fc = emu.framecount()

    -- ... then dispatch it (for overlays) ...
    mediator:publish({ 'frame.displayed' }, fc)

    -- ... and "push" the inputs (if inputs are set for this frame)
    if(joypadSet[fc]) then
        joypad.set(joypadSet[fc])
    end

    emu.frameadvance()
end