-- Declaration

local BizhawkLfs = {}

local function process(cFilesPath, tasPath)
    local f = io.open(cFilesPath, 'w')
    f:write(require('plugins/bizhawk/bizhawk').lfsForBizhawk(tasPath))
    f:close()
end

BizhawkLfs.process = process

-- Call

BizhawkLfs.process(arg[1], arg[2])