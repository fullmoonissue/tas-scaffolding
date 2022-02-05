local inputBizhawk = require('src/input/bizhawk')

local function getAllButtonPossibleValues()
    local buttonPossibleValues = {}
    local tmpUniqueness = {}
    local defaultValue, activeValue
    for _, buttonName in ipairs(inputBizhawk.getButtonNamesOrdered()) do
        defaultValue = inputBizhawk.getButtonDefaultValue(buttonName)
        if not tmpUniqueness[defaultValue] then
            tmpUniqueness[defaultValue] = true
            table.insert(buttonPossibleValues, defaultValue)
        end
        activeValue = inputBizhawk.getButtonActiveValue(buttonName)
        if nil ~= activeValue and not tmpUniqueness[activeValue] then
            tmpUniqueness[activeValue] = true
            table.insert(buttonPossibleValues, activeValue)
        end
    end

    return buttonPossibleValues
end

local function catchPlayersGamepad(inputLogLine)
    local pG = {}
    local countPlayers = 5
    repeat
        countPlayers = countPlayers - 1
        if countPlayers == 0 then
            return {}
        end
        -- We can't capture all buttons in one shot else a "too many captures" error message is throw
        pG[1], pG[2], pG[3], pG[4] = string.match(
            inputLogLine,
            string.format("|    %%d,...|%s", string.rep('  ([^|]+)|', countPlayers))
        )
    until pG[countPlayers] ~= nil

    return pG
end

local function makeJoypadInputs(inputLogContent)
    local catch = string.format('([%s])', table.concat(getAllButtonPossibleValues(), ''))
    local gamepadCatch = "%d+,  %d+,  %d+,  %d+," .. string.rep(catch, 14) .. "..."

    local joypadInputs = {}
    local inputs, hasInputs, playersGamepad,
    inputUp, inputDown, inputLeft, inputRight,
    inputSelect, inputStart,
    inputSquare, inputTriangle, inputCircle, inputCross,
    inputL1, inputR1, inputL2, inputR2

    local frameCount = -2 -- Start at -2 because the two first lines of "Input Log" are not useful
    for inputLogLine in string.gmatch(inputLogContent, "[^\n]+") do
        frameCount = frameCount + 1
        if '|' == string.sub(inputLogLine, 0, 1) then
            playersGamepad = catchPlayersGamepad(inputLogLine)
            inputs = {}
            hasInputs = false
            for player, gamepad in pairs(playersGamepad) do
                inputUp, inputDown, inputLeft, inputRight,
                inputSelect, inputStart,
                inputSquare, inputTriangle, inputCircle, inputCross,
                inputL1, inputR1, inputL2, inputR2 = string.match(gamepad, gamepadCatch)
                if inputUp ~= inputBizhawk.getButtonDefaultValue('UP') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'UP')] = true
                end
                if inputDown ~= inputBizhawk.getButtonDefaultValue('DOWN') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'DOWN')] = true
                end
                if inputLeft ~= inputBizhawk.getButtonDefaultValue('LEFT') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'LEFT')] = true
                end
                if inputRight ~= inputBizhawk.getButtonDefaultValue('RIGHT') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'RIGHT')] = true
                end
                if inputSelect ~= inputBizhawk.getButtonDefaultValue('SELECT') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'SELECT')] = true
                end
                if inputStart ~= inputBizhawk.getButtonDefaultValue('START') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'START')] = true
                end
                if inputSquare ~= inputBizhawk.getButtonDefaultValue('SQUARE') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'SQUARE')] = true
                end
                if inputTriangle ~= inputBizhawk.getButtonDefaultValue('TRIANGLE') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'TRIANGLE')] = true
                end
                if inputCircle ~= inputBizhawk.getButtonDefaultValue('CIRCLE') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'CIRCLE')] = true
                end
                if inputCross ~= inputBizhawk.getButtonDefaultValue('CROSS') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'CROSS')] = true
                end
                if inputL1 ~= inputBizhawk.getButtonDefaultValue('L1') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'L1')] = true
                end
                if inputR1 ~= inputBizhawk.getButtonDefaultValue('R1') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'R1')] = true
                end
                if inputL2 ~= inputBizhawk.getButtonDefaultValue('L2') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'L2')] = true
                end
                if inputR2 ~= inputBizhawk.getButtonDefaultValue('R2') then
                    hasInputs = true
                    inputs[inputBizhawk.getButtonLabel(player, 'R2')] = true
                end
            end

            if hasInputs then
                joypadInputs[frameCount] = inputs
            end
        end
    end

    return joypadInputs
end

local function joypadInputsToTasFile(joypadInputs)
    local contentLines = {"local input = require('tas/joypadInputs')"}
    local orderedFrames = require('src/utils').orderFrames(joypadInputs)
    for _, frame in ipairs(orderedFrames) do
        for inputLabel, _ in pairs(joypadInputs[frame]) do
            table.insert(contentLines, string.format('input:setPlayer(%s)', string.sub(inputLabel, 2, 2)))
            table.insert(contentLines, string.format('input:%s(%s)', string.lower(string.sub(inputLabel, 4)), frame))
        end
    end

    table.insert(contentLines, 'return input:all()')

    return table.concat(contentLines, "\n")
end

local function process(tasFolder, tas, inputLogPath)
    local f = io.open(inputLogPath, 'rb')
    local c = f:read('*all')
    f:close()

    local joypadInputsFile = io.open(table.concat({ tasFolder, tas, '0-inputs.lua' }, '/'), 'w')
    joypadInputsFile:write(joypadInputsToTasFile(makeJoypadInputs(c)))
    joypadInputsFile:close()
end

-- Call
if 'tests/' ~= string.sub(arg[0], 1, 6) then
    process(arg[1], arg[2], arg[3])
else
    return { makeJoypadInputs = makeJoypadInputs }
end