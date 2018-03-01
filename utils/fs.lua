require('utils/class')
local files = require('files')

local Fs = class()

function Fs:iterateOver(tas, callback)
    for _, file in ipairs(files[tas]) do
        if file ~= '.' and file ~= '..' then
            callback('tas/' .. tas .. '/' .. file)
        end
    end
end

return Fs;