-- Declaration

local BizhawkDump = {}

local function process(tas, cFilesPath, tasPath, archivesBk2Path)
    local files = {}
    local cFiles = require(cFilesPath)
    for _, file in ipairs(cFiles[tas]) do
        files[#files + 1] = table.concat({ tasPath, tas, file }, '/')
    end

    local inputLogFile = io.open(table.concat({ archivesBk2Path, tas, 'Input Log.txt' }, '/'), 'w')
    inputLogFile:write(
        require('plugins/bizhawk/bizhawk').makeInputLogLines(
            require('core/input').merge(files)
        )
    )
    inputLogFile:close()
end

BizhawkDump.process = process

-- Call

BizhawkDump.process(arg[1], string.gsub(arg[2], '.lua', ''), arg[3], arg[4])