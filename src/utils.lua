local Utils = {}

-- Merge inputs from files
Utils.merge = function (files)
    local inputs = {}
    for _, file in ipairs(files) do
        if file ~= '.' and file ~= '..' then
            local importedInputs = require(file)
            for frame, bInputs in pairs(importedInputs) do
                inputs[frame] = bInputs
            end
        end
    end

    return inputs
end

Utils.orderFrames = function (joypadInputs)
    local orderedFrames = {}
    for frame, _ in pairs(joypadInputs) do
        table.insert(orderedFrames, frame)
    end
    table.sort(orderedFrames)

    return orderedFrames
end

return Utils