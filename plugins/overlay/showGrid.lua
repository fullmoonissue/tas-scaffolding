local utils = require('plugins/overlay/utils')

-- These method draw some rectangles to show areas, useful when making HUD
local function showGrid()
    -- Whole area
    gui.drawRectangle(1, 1, utils.gridValues['screenWidth'], utils.gridValues['screenHeight'], 'white')
    -- Right area (HUD)
    gui.drawRectangle(
        utils.gridValues['xRightArea'],
        1,
        utils.gridValues['screenWidth'] - utils.gridValues['xRightArea'],
        utils.gridValues['screenHeight'],
        'white'
    )
    -- Right area split in half
    gui.drawRectangle(
        utils.gridValues['xRightArea'],
        1,
        (utils.gridValues['screenWidth'] - utils.gridValues['xRightArea']) / 2,
        utils.gridValues['screenHeight'],
        'white'
    )
end

return showGrid