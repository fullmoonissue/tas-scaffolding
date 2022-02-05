local paths = require('configuration/paths')
local frameScreenshot = require(paths['configuration']['screenshot'])

return {
    subscribe = function ()
        return function(fc)
            if frameScreenshot[fc] then
                client.screenshot(frameScreenshot[fc])
            end
        end
    end
}