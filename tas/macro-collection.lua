local Input = require('tas/input')
local input = Input()

local MacroCollection = setmetatable(
    {
        input = input,
    },
    {
        __call = function()
            return {
                -- Add your macros here (check templates)
            }
        end
    }
)

return MacroCollection