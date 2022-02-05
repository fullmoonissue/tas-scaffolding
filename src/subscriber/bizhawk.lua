local play = require('configuration/play')
local paths = require('configuration/paths')

local files = {}
local currentCategory = play['currentCategory']
local cFiles = require(paths['tas']['files'])
if cFiles[currentCategory] ~= nil then
    for _, file in ipairs(cFiles[currentCategory]) do
        files[#files + 1] = table.concat({ paths['folder']['tas'], currentCategory, file }, '/')
    end
end
local joypadSet = require('src/utils').merge(files)

return {
    subscribe = function ()
        return function(fc)
            if joypadSet[fc] then
                joypad.set(joypadSet[fc])
            end
        end
    end
}