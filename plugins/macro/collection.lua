local Macro = {}
-- local input = require('core/input')

--[[

    -->> Here are two examples of macros

    - First example -
    local function example_macro_without_custom_inputs(currentFrame)
        input:right(currentFrame)
        currentFrame = currentFrame + 2
        input:right(currentFrame)

        return currentFrame
    end

    Macro.example_macro_without_custom_inputs = example_macro_without_custom_inputs

    - Second example -
    local function example_macro_with_custom_inputs(currentFrame, iterations)
        return input:add(
            currentFrame,
            iterations,
            {
                [input.currentPlayer .. ' Circle'] = true,
                [input.currentPlayer .. ' Cross'] = true,
            }
        )
    end

    Macro.example_macro_with_custom_inputs = example_macro_with_custom_inputs

]]--

return Macro