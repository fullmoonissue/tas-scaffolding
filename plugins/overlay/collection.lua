-- List of Lua functions available for BizHawk
-- http://tasvideos.org/Bizhawk/LuaFunctions.html#tabber

local Overlay = {}

local function framecount(fc)
    gui.drawText(5, 60, 'Frame', 'white', 'black', 15)
    gui.drawText(5, 75, fc, 'white', 'black', 20)
end

local function applySubscriptions(mediator)
    mediator:subscribe({ 'frame.displayed' }, function(fc)
        framecount(fc)
    end)
end

Overlay.applySubscriptions = applySubscriptions

return Overlay