local MacroCollection = {}
local inputBizhawk = require('src/input/bizhawk')
local input = require('tas/joypadInputs')

-- Macros without custom inputs

MacroCollection.tremoloLeftRight = function (currentFrame, iterations)
    for _ = 1, (iterations or 1) do
        input:left(currentFrame)
        currentFrame = currentFrame + 1
        input:right(currentFrame)
        currentFrame = currentFrame + 1
    end

    return currentFrame
end

MacroCollection.tremoloUpDown = function (currentFrame, iterations)
    for _ = 1, (iterations or 1) do
        input:up(currentFrame)
        currentFrame = currentFrame + 1
        input:down(currentFrame)
        currentFrame = currentFrame + 1
    end

    return currentFrame
end

-- Macros with custom inputs
-- Be aware that "Allow U+D/L+R" is a configurable option in BizHawk (Config > Controllers)

MacroCollection.leftRight = function (currentFrame, iterations)
    return input:add(
        currentFrame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'LEFT')] = true,
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'RIGHT')] = true,
        }
    )
end

MacroCollection.upDown = function (currentFrame, iterations)
    return input:add(
        currentFrame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'UP')] = true,
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'DOWN')] = true,
        }
    )
end

MacroCollection.selectStart = function (currentFrame, iterations)
    return input:add(
        currentFrame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'SELECT')] = true,
            [inputBizhawk.getButtonLabel(input.currentPlayer, 'START')] = true,
        }
    )
end

return MacroCollection