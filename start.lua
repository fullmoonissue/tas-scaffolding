local play = require('configuration/play')
local currentTas = play['currentTas']
local loadSlot = play['loadSlot']

local paths = require('configuration/paths')

local files = {}
local cFiles = require(paths['files'])
if (cFiles[currentTas] ~= nil) then
    for _, file in ipairs(cFiles[currentTas]) do
        files[#files + 1] = table.concat({ paths['tas'], currentTas, file }, '/')
    end
end

-- Retrieve the inputs of the current tas
local joypadSet = require('core/input').merge(files)

-- Preload a savestate, if exists
local preloads = require(paths['preloads'])
if (preloads[currentTas] ~= nil) then
    savestate.load(table.concat({ paths['savestate'], preloads[currentTas] }, '/'))
end

-- Load the current savestate, if defined and exists
if (loadSlot ~= nil) then
    savestate.loadslot(loadSlot)
end

-- Add overlays
local mediator = require('mediator')()
require('plugins/overlay/collection').applySubscriptions(mediator)

-- Screenshot configuration
local screenshotConfiguration = require(paths['screenshot'])

while (true) do
    -- Retrieve the current frame ...
    local fc = emu.framecount()

    -- ... then dispatch it (for overlays) ...
    mediator:publish({ 'frame.displayed' }, fc)

    -- ... then "push" the inputs (if inputs are set for this frame) ...
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