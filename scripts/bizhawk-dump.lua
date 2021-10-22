local inputBizhawk = require('src/input/bizhawk')

local function getLastFrame(joypadInputs)
    local orderedFrames = require('src/utils').orderFrames(joypadInputs)

    local lastFrame = 1
    for _, frame in ipairs(orderedFrames) do
        lastFrame = frame
    end

    return lastFrame
end

local function getConsoleValues(consoleNamesOrdered)
    return string.format(
       '%s,%s%s%s',
       inputBizhawk.getConsoleDefaultValue(consoleNamesOrdered[1]),
       inputBizhawk.getConsoleDefaultValue(consoleNamesOrdered[2]),
       inputBizhawk.getConsoleDefaultValue(consoleNamesOrdered[3]),
       inputBizhawk.getConsoleDefaultValue(consoleNamesOrdered[4])
    )
end

local function getButtonValue(joypadInputs, currentFrame, player, buttonName)
    if joypadInputs[currentFrame] and joypadInputs[currentFrame][inputBizhawk.getButtonLabel(player, buttonName)] then
        return inputBizhawk.getButtonActiveValue(buttonName)
    else
        return inputBizhawk.getButtonDefaultValue(buttonName)
    end
end

local function getButtonValues(joypadInputs, currentFrame, player, buttonNamesOrdered)
    return string.format(
       '%s,  %s,  %s,  %s,%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s',
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[1]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[2]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[3]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[4]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[5]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[6]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[7]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[8]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[9]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[10]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[11]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[12]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[13]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[14]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[15]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[16]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[17]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[18]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[19]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[20]),
       getButtonValue(joypadInputs, currentFrame, player, buttonNamesOrdered[21])
    )
end

-- Create and return the lines for the "Input Log.txt"
local function makeInputLogLines(joypadInputs)
    local lines = {}
    -- First line
    table.insert(lines, '[Input]')

    -- Second line (headers)
    local headersConsole = {}
    local consoleNamesOrdered = inputBizhawk.getConsoleNamesOrdered()
    for _, consoleName in ipairs(consoleNamesOrdered) do
        table.insert(headersConsole, inputBizhawk.getConsoleLabel(consoleName))
    end

    local headersButtonsP1 = {}
    local headersButtonsP2 = {}
    local buttonNamesOrdered = inputBizhawk.getButtonNamesOrdered()
    for _, buttonName in ipairs(buttonNamesOrdered) do
        table.insert(headersButtonsP1, inputBizhawk.getButtonLabel(1, buttonName))
        table.insert(headersButtonsP2, inputBizhawk.getButtonLabel(2, buttonName))
    end

    table.insert(
        lines,
        table.concat(
            {
                'LogKey:',
                string.format('%s|', table.concat(headersConsole, '|')),
                string.format('%s|', table.concat(headersButtonsP1, '|')),
                string.format('%s|', table.concat(headersButtonsP2, '|')),
            },
            '#'
        )
    )

    -- Third line and more (consoles and buttons values)
    local lastFrame = getLastFrame(joypadInputs)
    for currentFrame = 1, lastFrame do
        table.insert(
            lines,
            string.format(
                '|    %s|  %s|  %s|',
                getConsoleValues(consoleNamesOrdered),
                getButtonValues(joypadInputs, currentFrame, 1, buttonNamesOrdered),
                getButtonValues(joypadInputs, currentFrame, 2, buttonNamesOrdered)
            )
        )
    end

    -- Last line
    table.insert(lines, '[/Input]')

    return table.concat(lines, "\n")
end

local function process(tas, cFilesPath, tasPath, archivesBk2Path)
    local files = {}
    local cFiles = require(cFilesPath)
    for _, file in ipairs(cFiles[tas]) do
        files[#files + 1] = table.concat({ tasPath, tas, file }, '/')
    end

    local inputLogFile = io.open(table.concat({ archivesBk2Path, tas, 'Input Log.txt' }, '/'), 'w')
    inputLogFile:write(makeInputLogLines(require('src/utils').merge(files)))
    inputLogFile:close()
end

-- Call
if 'tests/' ~= string.sub(arg[0], 1, 6) then
    process(arg[1], string.gsub(arg[2], '.lua', ''), arg[3], arg[4])
else
    return { makeInputLogLines = makeInputLogLines }
end