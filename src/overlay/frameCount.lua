local function frameCount(fc)
    local fontSize, text = 15, string.format('Frame : %d', fc)
    gui.drawText(
        2,
        2,
        text,
        'white',
        'black',
        fontSize
    )
end

return frameCount