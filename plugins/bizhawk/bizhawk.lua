local bhc = require('plugins/bizhawk/configuration')

local Bizhawk = {}

-- Create and return the lines for the "Input Log.txt"
local function makeInputLogLines(bjInputs)
    local orderedFrames = {}
    for frame, _ in pairs(bjInputs) do
        table.insert(orderedFrames, frame)
    end
    table.sort(orderedFrames)

    local lastFrame = 1
    for _, frame in ipairs(orderedFrames) do
        lastFrame = frame
    end

    local p1Keys = {}
    local p1Inputs = {}
    local p2Keys = {}
    local p2Inputs = {}
    for _, input in ipairs(bhc.keys) do
        local joypadButtonP1 = bhc:joypad(1, input)
        p1Keys[#p1Keys + 1] = joypadButtonP1
        p1Inputs[joypadButtonP1] = bhc.inputs[input]

        local joypadButtonP2 = bhc:joypad(2, input)
        p2Keys[#p2Keys + 1] = joypadButtonP2
        p2Inputs[joypadButtonP2] = bhc.inputs[input]
    end

    local lines = { '[Input]' }
    lines[#lines + 1] = string.format(
        'LogKey:#Disc Select|Open|Close|Reset'
        .. '|#P1 LStick X|P1 LStick Y|P1 RStick X|P1 RStick Y|%s|P1 L3|P1 R3|P1 MODE'
        .. '|#P2 LStick X|P2 LStick Y|P2 RStick X|P2 RStick Y|%s|P2 L3|P2 R3|P2 MODE|',
        table.concat(p1Keys, '|'),
        table.concat(p2Keys, '|')
    )

    for currentFrame = 1, lastFrame do
        local line = { '|    1,...|  128,  128,  128,  128,' }

        for _, p1Input in ipairs(p1Keys) do
            if (bjInputs[currentFrame] and bjInputs[currentFrame][p1Input]) then
                line[#line + 1] = p1Inputs[p1Input]
            else
                line[#line + 1] = bhc.NONE
            end
        end

        line[#line + 1] = '...|  128,  128,  128,  128,'

        for _, p2Input in ipairs(p2Keys) do
            if (bjInputs[currentFrame] and bjInputs[currentFrame][p2Input]) then
                line[#line + 1] = p2Inputs[p2Input]
            else
                line[#line + 1] = bhc.NONE
            end
        end

        line[#line + 1] = '...|'

        lines[#lines + 1] = table.concat(line, '')
    end
    lines[#lines + 1] = '[/Input]'

    return table.concat(lines, "\n")
end

local function makeJoypadInputs(inputLogContent)
    local catch = string.format(
        '([%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s])',
        bhc.inputs[bhc.UP],
        bhc.inputs[bhc.DOWN],
        bhc.inputs[bhc.LEFT],
        bhc.inputs[bhc.RIGHT],
        bhc.inputs[bhc.SELECT],
        bhc.inputs[bhc.START],
        bhc.inputs[bhc.SQUARE],
        bhc.inputs[bhc.TRIANGLE],
        bhc.inputs[bhc.CIRCLE],
        bhc.inputs[bhc.CROSS],
        bhc.inputs[bhc.L1],
        bhc.inputs[bhc.R1],
        bhc.inputs[bhc.L2],
        bhc.inputs[bhc.R2],
        bhc.NONE
    )
    local gamepadCatch = "%d+,  %d+,  %d+,  %d+," .. string.rep(catch, 14) .. "..."

    local joypadInputs = {}
    local inputs, hasInputs, p1, p2, pu, pd, pl, pr, pse, pst, psqu, ptri, pcir, pcro, pl1, pr1, pl2, pr2

    local frameCount = -2 -- Start at -2 because the two first lines of "Input Log" are not useful
    for inputLogLine in string.gmatch(inputLogContent, "[^\n]+") do
        frameCount = frameCount + 1
        if '|' == string.sub(inputLogLine, 0, 1) then
            -- We can't capture all buttons in one shot else a "too many captures" error message is throw
            p1, p2 = string.match(inputLogLine, "|    %d,...|  ([^|]+)|  ([^|]+)|")
            inputs = {}
            hasInputs = false
            for player, gamepad in pairs({ [1] = p1, [2] = p2 }) do
                pu, pd, pl, pr,
                pse, pst,
                psqu, ptri, pcir, pcro,
                pl1, pr1, pl2, pr2 = string.match(gamepad, gamepadCatch)
                if pu ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadUp(player)] = true
                end
                if pd ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadDown(player)] = true
                end
                if pl ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadLeft(player)] = true
                end
                if pr ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadRight(player)] = true
                end
                if pse ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadSelect(player)] = true
                end
                if pst ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadStart(player)] = true
                end
                if psqu ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadSquare(player)] = true
                end
                if ptri ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadTriangle(player)] = true
                end
                if pcir ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadCircle(player)] = true
                end
                if pcro ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadCross(player)] = true
                end
                if pl1 ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadL1(player)] = true
                end
                if pr1 ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadR1(player)] = true
                end
                if pl2 ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadL2(player)] = true
                end
                if pr2 ~= bhc.NONE then
                    hasInputs = true
                    inputs[bhc.joypadR2(player)] = true
                end
            end

            if hasInputs then
                joypadInputs[frameCount] = inputs
            end
        end
    end

    return joypadInputs
end

-- Create and retrieve the file content needed to get the listing of files for each tas
local function lfsForBizhawk(tasFolder)
    local lfs = require('lfs')
    local contents = { 'return {' }
    for folder in lfs.dir(tasFolder) do
        if folder ~= '.' and folder ~= '..' then
            local rTasFolder = tasFolder .. '/' .. folder
            if lfs.attributes(rTasFolder).mode == 'directory' then
                contents[#contents + 1] = '    [\'' .. folder .. '\'] = {'
                for file in lfs.dir(rTasFolder) do
                    if file ~= '.' and file ~= '..' then
                        contents[#contents + 1] = '        \'' .. string.gsub(file, '.lua', '') .. '\','
                    end
                end
                contents[#contents + 1] = '    },'
            end
        end
    end
    contents[#contents + 1] = '}'

    return table.concat(contents, "\n")
end

Bizhawk.makeInputLogLines = makeInputLogLines
Bizhawk.makeJoypadInputs = makeJoypadInputs
Bizhawk.lfsForBizhawk = lfsForBizhawk

return Bizhawk