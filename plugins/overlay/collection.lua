-- List of Lua functions available for BizHawk
-- http://tasvideos.org/Bizhawk/LuaFunctions.html#tabber

local paths = require('configuration/paths')
local game = require(paths['game'])

local Overlay = {}

local function extraPadding(fc)
    client.SetGameExtraPadding(0, 25, 0, 25)
end

local function framecount(fc)
    local text = string.format('Frame : %d', fc)
    gui.drawText(client.screenwidth() / 4 - string.len(text) * 5, 0, text, 'white', 'black', 15)
end

local function gameInfos()
    local screenWidth, yOrigin, text = client.screenwidth() / 2, client.screenheight() / 2 - 42

    text = string.format('Game : %s', game['game_name'])
    gui.drawText(
        screenWidth / 2 - screenWidth / 4 - screenWidth / 8 - string.len(text) * 5,
        yOrigin,
        text,
        'white',
        'black',
        15
    )

    text = string.format('Console : %s', game['game_console'])
    gui.drawText(
        screenWidth / 2 - screenWidth / 8 - string.len(text) * 5,
        yOrigin, text,
        'white',
        'black',
        15
    )

    text = string.format('Bizhawk : %s', game['bizhawk_version'])
    gui.drawText(
        screenWidth / 2 + screenWidth / 8 - string.len(text) * 5,
        yOrigin,
        text,
        'white',
        'black',
        15
    )

    text = string.format('Framework : %s', game['scaffolding_version'])
    gui.drawText(
        screenWidth / 2 + screenWidth / 4 + screenWidth / 8 - string.len(text) * 5,
        yOrigin,
        text,
        'white',
        'black',
        15
    )
end

local function applySubscriptions(mediator)
    mediator:subscribe({ 'frame.displayed' }, function(fc)
        extraPadding()
        framecount(fc)
        gameInfos()
    end)
end

Overlay.applySubscriptions = applySubscriptions

return Overlay