local frameCount = require('src/overlay/frameCount')

local function subscribe()
    return function(fc)
        -- Display the current frame
        frameCount(fc)
    end
end

return {
    subscribe = subscribe
}