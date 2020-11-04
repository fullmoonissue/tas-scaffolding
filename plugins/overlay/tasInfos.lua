local play = require('configuration/play')
local paths = require('configuration/paths')
local game = require(paths['tas']['infos'])

local utils = require('plugins/overlay/utils')

local function tasInfos()
    local texts = {
        'Game',
        game['game_name'],
        'Console',
        game['game_console'],
        'Category',
        play['currentTas'] or 'Not set',
        'Bizhawk version',
        game['bizhawk_version'],
        'TAS scaffolding project version',
        game['scaffolding_version'],
    }
    local indexText, yOrigin, ySpace, fontSize = 0, 25, 50, 18
    for y = yOrigin, yOrigin + (ySpace * (#texts - 1)), ySpace do
        indexText = indexText + 1
        gui.drawText(
            utils.gridValues['xRightArea'] + utils.centerHorizontally(
                utils.gridValues['xRightArea'],
                utils.gridValues['screenWidth'],
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

return tasInfos