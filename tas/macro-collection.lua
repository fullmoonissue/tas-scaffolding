local input = require('bizhawk/input')()

local MacroCollection = setmetatable(
    {
        input = input,
    },
    {
        __call = function()
            return {
                -- Add your macros here
            }
        end
    }
)

return MacroCollection