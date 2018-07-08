--[[

example_with_custom_inputs = function(currentFrame, iterations)
    return input:add(
        currentFrame,
        iterations,
        {
            [input.currentPlayer .. ' Circle'] = true,
            [input.currentPlayer .. ' Cross'] = true,
        }
    )
end

]]