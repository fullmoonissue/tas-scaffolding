return setmetatable(
    {
        input = require('bizhawk/input')(),
    },
    {
        __call = function()
            return {
                -- Add your macros here
            }
        end
    }
)