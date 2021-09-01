-- TAS configuration
local play = require('configuration/play')
-- Paths configuration
local paths = require('configuration/paths')

-- ## Current TAS category assigned ?
local currentTas = play['currentTas']
if not currentTas then
    console.clear()
    console.log('>>> The value of "currentTas" has to be set in "configuration/play.lua" <<<')
end

-- ## Load a savestate (file), if defined
local preloads = require(paths['collection']['preload'])
if preloads[currentTas] ~= nil then
    savestate.load(table.concat({ paths['folder']['savestate'], preloads[currentTas] }, '/'))
end

-- ## Load a savestate (slot), if defined
local loadSlot = play['loadSlot']
if loadSlot ~= nil then
    savestate.loadslot(loadSlot)
end

-- ## Configure subscribers
local subscriberOverlay = require(paths['collection']['overlay']).subscribe()
local subscriberScreenshot = require(paths['collection']['screenshot']).subscribe()
local pubSub = require('mediator')()
pubSub:subscribe({ 'frame.current' }, function(fc)
    subscriberOverlay(fc)
    subscriberScreenshot(fc)
end)

-- ## Retrieve the inputs of the current tas' category
local files = {}
local cFiles = require(paths['tas']['files'])
if cFiles[currentTas] ~= nil then
    for _, file in ipairs(cFiles[currentTas]) do
        files[#files + 1] = table.concat({ paths['folder']['tas'], currentTas, file }, '/')
    end
end
local joypadSet = require('core/input').merge(files)

-- ## Infinite loop
local fc
while true do
    -- 1. Retrieve the current frame
    fc = emu.framecount()

    -- 2. Dispatch 'frame.current' event
    pubSub:publish({ 'frame.current' }, fc)

    -- 3. If defined, send the configured inputs to Bizhawk
    if joypadSet[fc] then
        joypad.set(joypadSet[fc])
    end

    -- 4. Forward to the next frame
    emu.frameadvance()
end