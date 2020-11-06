-- List of Lua functions available for BizHawk
-- http://tasvideos.org/Bizhawk/LuaFunctions.html#tabber

--[[

# ### ### ### ### ###
# Example of overlays
# ### ### ### ### ###

-- Extra padding to show tas infos
client.SetGameExtraPadding(0, 25, 350, 25)

local frameCount = require('plugins/overlay/frameCount')
local tasInfos = require('plugins/overlay/tasInfos')

]]--

local function applySubscriptions(mediator)
    mediator:subscribe({ 'frame.displayed' }, function(--[[fc]])
        -- frameCount(fc)   ## Display the current frame
        -- tasInfos()       ## Display infos about the game and BizHawk
    end)
end

local Overlay = {}

Overlay.applySubscriptions = applySubscriptions

return Overlay