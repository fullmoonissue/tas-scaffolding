--[[

example_without_custom_inputs = function(currentFrame)
    input:right(currentFrame)

    currentFrame = currentFrame + 2
    input:right(currentFrame)

    return currentFrame
end

]]