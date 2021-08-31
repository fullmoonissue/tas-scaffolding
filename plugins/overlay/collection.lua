-- List of Lua functions available for BizHawk
-- http://tasvideos.org/Bizhawk/LuaFunctions.html#tabber

local frameCount = require('plugins/overlay/frameCount')

--[[

# ### ### ### ### ###
# Example of overlays
# ### ### ### ### ###

-- Extra padding to show tas infos
client.SetGameExtraPadding(0, 25, 350, 25)

local tasInfos = require('plugins/overlay/tasInfos')

]]--

local function applySubscriptions(mediator)
    mediator:subscribe({ 'frame.displayed' }, function(fc)
        -- Display the current frame
        frameCount(fc)

        -- Display infos about the game and BizHawk
        -- tasInfos()
    end)
end

local Overlay = {}

Overlay.applySubscriptions = applySubscriptions

return Overlay