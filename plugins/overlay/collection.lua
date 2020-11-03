-- List of Lua functions available for BizHawk
-- http://tasvideos.org/Bizhawk/LuaFunctions.html#tabber

local paths = require('configuration/paths')
local game = require(paths['tas']['infos'])

local gridValues = {
    ['screenWidth'] = 1147, -- instead of client.screenWidth()
    ['screenHeight'] = 528, -- instead of client.screenHeight()
    ['xRightArea'] = 720, -- x position for HUD
}

local function centerHorizontally(xOrigin, xEnd, text, fontSize)
    return (xEnd - xOrigin) / 2 - ((string.len(text) * (fontSize * 2 / 3)) / 2)
end

local function framecount(fc)
    local fontSize, text = 15, string.format('Frame : %d', fc)
    gui.drawText(
        centerHorizontally(1, gridValues['screenWidth'], text, fontSize),
        2,
        text,
        'white',
        'black',
        fontSize
    )
end

-- These method draw some rectangles to show areas, useful when making HUD
--[[
local function showGrid()
    -- Whole area
    gui.drawRectangle(1, 1, gridValues['screenWidth'], gridValues['screenHeight'], 'white')
    -- Right area (HUD)
    gui.drawRectangle(
        gridValues['xRightArea'],
        1,
        gridValues['screenWidth'] - gridValues['xRightArea'],
        gridValues['screenHeight'],
        'white'
    )
    -- Right area split in half
    gui.drawRectangle(
        gridValues['xRightArea'],
        1,
        (gridValues['screenWidth'] - gridValues['xRightArea']) / 2,
        gridValues['screenHeight'],
        'white'
    )
end
]]--

local function tasInfos()
    local texts = {
        'Game',
        game['game_name'],
        'Console',
        game['game_console'],
        'Bizhawk version',
        game['bizhawk_version'],
        'TAS scaffolding project version',
        game['scaffolding_version'],
    }
    local indexText, yOrigin, ySpace, fontSize = 0, 50, 50, 18
    for y = yOrigin, yOrigin + (ySpace * (#texts - 1)), ySpace do
        indexText = indexText + 1
        gui.drawText(
            gridValues['xRightArea'] + centerHorizontally(
                gridValues['xRightArea'],
                gridValues['screenWidth'],
                texts[indexText],
                fontSize
            ),
            y,
            texts[indexText],
            'white',
            'black',
            fontSize
        )
    end
end

local function applySubscriptions(mediator)
    mediator:subscribe({ 'frame.displayed' }, function(fc)
        framecount(fc)
        --showGrid()
        tasInfos()
    end)
end

local Overlay = {}

Overlay.applySubscriptions = applySubscriptions

return Overlay