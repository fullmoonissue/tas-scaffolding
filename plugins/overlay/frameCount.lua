local utils = require('plugins/overlay/utils')

local function frameCount(fc)
    local fontSize, text = 15, string.format('Frame : %d', fc)
    gui.drawText(
        utils.centerHorizontally(1, utils.gridValues['screenWidth'], text, fontSize),
        2,
        text,
        'white',
        'black',
        fontSize
    )
end

return frameCount