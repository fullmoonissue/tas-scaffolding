local paths = require('configuration/paths')
local play = require(paths['configuration']['play'])

-- ## ### ### ### ### ##
-- ## Check category  ##
-- ## ### ### ### ### ##
local currentCategory = play['currentCategory']
if not currentCategory then
    console.clear()
    console.log('>>> The value of "currentCategory" has to be set in "configuration/play.lua" <<<')
end

-- ## ### ### ### ### ### ### ##
-- ## Load a savestate (file) ##
-- ## ### ### ### ### ### ### ##
local savestates = require(paths['configuration']['savestate'])
if savestates[currentCategory] ~= nil then
    savestate.load(table.concat({ paths['folder']['savestate'], savestates[currentCategory] }, '/'))
end

-- ## ### ### ### ### ### ### ##
-- ## Load a savestate (slot) ##
-- ## ### ### ### ### ### ### ##
local loadSlot = play['loadSlot']
if loadSlot ~= nil then
    savestate.loadslot(loadSlot)
end

-- ## ### ### ### ### ### ### ##
-- ##  Configure subscribers  ##
-- ## ### ### ### ### ### ### ##
local subscriberBizHawk = require(paths['subscriber']['bizhawk']).subscribe()
local subscriberOverlay = require(paths['subscriber']['overlay']).subscribe()
local subscriberScreenshot = require(paths['subscriber']['screenshot']).subscribe()
local pubSub = require('mediator')()
pubSub:subscribe({ 'frame.current' }, function(fc)
    subscriberOverlay(fc)
    subscriberScreenshot(fc)
    subscriberBizHawk(fc)
end)

-- ## ### ### ### ### ##
-- ##  Infinite loop  ##
-- ## ### ### ### ### ##
while true do
    pubSub:publish({ 'frame.current' }, emu.framecount())
    emu.frameadvance()
end