return setmetatable(
    {
        input = require('core/input')(),
    },
    {
        __call = function()
            return {
                -- Add your macros here
            }
        end
    }
)