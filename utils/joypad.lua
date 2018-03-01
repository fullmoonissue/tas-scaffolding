require('utils/class')
local fs = require('utils/fs')
local tableExtension = require('utils/table-extension')

BizhawkJoypad = class()

function BizhawkJoypad:getInputs(tas)
    local inputs = {}
    fs:iterateOver(tas, function(filePath)
        tableExtension:join(inputs, require(filePath))
    end)

    return inputs
end

function BizhawkJoypad:getOrderedFrames(inputs)
    local orderedFrames = {}
    for frame, _ in pairs(inputs) do
        table.insert(orderedFrames, frame)
    end
    table.sort(orderedFrames)

    return orderedFrames
end

return BizhawkJoypad