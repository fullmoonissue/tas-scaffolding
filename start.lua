local play = require('configuration/play')
local currentTas = play['currentTas']
if not currentTas then
    console.clear()
    console.log('>>> The value of "currentTas" has to be set in "configuration/play.lua" <<<')
end
local loadSlot = play['loadSlot']

local paths = require('configuration/paths')

local files = {}
local cFiles = require(paths['tas']['files'])
if (cFiles[currentTas] ~= nil) then
    for _, file in ipairs(cFiles[currentTas]) do
        files[#files + 1] = table.concat({ paths['folder']['tas'], currentTas, file }, '/')
    end
end

-- Retrieve the inputs of the current tas' category
local joypadSet = require('core/input').merge(files)

-- Preload a savestate, if defined
local preloads = require(paths['collection']['preload'])
if (preloads[currentTas] ~= nil) then
    savestate.load(table.concat({ paths['folder']['savestate'], preloads[currentTas] }, '/'))
end

-- Load the current savestate, if defined
if (loadSlot ~= nil) then
    savestate.loadslot(loadSlot)
end

-- Add overlays
local mediator = require('mediator')()
require('plugins/overlay/collection').applySubscriptions(mediator)

-- @see Plugins > Screenshots in the README.md for further explanations
local screenshotConfiguration = require(paths['collection']['screenshot'])

while (true) do
    -- Retrieve the current frame ...
    local fc = emu.framecount()

    -- ... then dispatch it (for overlays) ...
    mediator:publish({ 'frame.displayed' }, fc)

    -- ... then send the configured inputs to Bizhawk ...
    if (joypadSet[fc]) then
        joypad.set(joypadSet[fc])
    end

    -- ... then do a screenshot if set for this frame ...
    if (screenshotConfiguration[fc]) then
        client.screenshot(screenshotConfiguration[fc])
    end

    -- ... and forward to the next frame
    emu.frameadvance()
end