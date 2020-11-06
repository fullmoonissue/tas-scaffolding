return {
    -- Values used to draw
    gridValues = {
        ['screenWidth'] = 1147, -- instead of client.screenWidth()
        ['screenHeight'] = 528, -- instead of client.screenHeight()
        ['xRightArea'] = 720, -- x position for HUD (on the right)
    },
    -- Compute the 'x' coordinate to center a text
    centerHorizontally = function(xOrigin, xEnd, text, fontSize)
        return (xEnd - xOrigin) / 2 - ((string.len(text) * (fontSize * 2 / 3)) / 2)
    end,
}