return setmetatable(
    {},
    {
        __call = function()
            return {
                -- Create the "Input Log.txt"
                makeInputLogFile = function(bjInputs)
                    local orderedFrames = {}
                    for frame, _ in pairs(bjInputs) do
                        table.insert(orderedFrames, frame)
                    end
                    table.sort(orderedFrames)

                    local lastFrame = 1
                    for _, frame in ipairs(orderedFrames) do
                        lastFrame = frame
                    end

                    local keys = {
                        'Up', 'Down', 'Left', 'Right',
                        'Select', 'Start',
                        'Square', 'Triangle', 'Circle', 'Cross',
                        'L1', 'R1', 'L2', 'R2'
                    }
                    local inputs = {
                        ['Up'] = 'U',
                        ['Down'] = 'D',
                        ['Left'] = 'L',
                        ['Right'] = 'R',
                        ['Select'] = 's',
                        ['Start'] = 'S',
                        ['Square'] = 'Q',
                        ['Triangle'] = 'T',
                        ['Circle'] = 'O',
                        ['Cross'] = 'X',
                        ['L1'] = 'l',
                        ['R1'] = 'r',
                        ['L2'] = 'L',
                        ['R2'] = 'R'
                    }

                    local p1Keys = {}
                    local p1Inputs = {}
                    local p2Keys = {}
                    local p2Inputs = {}

                    for _, input in ipairs(keys) do
                        p1Keys[#p1Keys + 1] = 'P1 ' .. input
                        p1Inputs['P1 ' .. input] = inputs[input]
                        p2Keys[#p2Keys + 1] = 'P2 ' .. input
                        p2Inputs['P2 ' .. input] = inputs[input]
                    end

                    local lines = { '[Input]' }
                    lines[#lines + 1] = string.format('LogKey:#Disc Select|Open|Close|Reset'
                            .. '|#P1 LStick X|P1 LStick Y|P1 RStick X|P1 RStick Y|%s|P1 L3|P1 R3|P1 MODE'
                            .. '|#P2 LStick X|P2 LStick Y|P2 RStick X|P2 RStick Y|%s|P2 L3|P2 R3|P2 MODE|',
                        table.concat(p1Keys, '|'),
                        table.concat(p2Keys, '|'))

                    for currentFrame = 1, lastFrame do
                        local line = { '|    1,...|  128,  128,  128,  128,' }

                        for _, p1Input in ipairs(p1Keys) do
                            if (bjInputs[currentFrame] and bjInputs[currentFrame][p1Input]) then
                                line[#line + 1] = p1Inputs[p1Input]
                            else
                                line[#line + 1] = '.'
                            end
                        end

                        line[#line + 1] = '...|  128,  128,  128,  128,'

                        for _, p2Input in ipairs(p2Keys) do
                            if (bjInputs[currentFrame] and bjInputs[currentFrame][p2Input]) then
                                line[#line + 1] = p2Inputs[p2Input]
                            else
                                line[#line + 1] = '.'
                            end
                        end

                        line[#line + 1] = '...|'

                        lines[#lines + 1] = table.concat(line, '')
                    end
                    lines[#lines + 1] = '[/Input]'

                    return table.concat(lines, "\n")
                end,
            }
        end
    }
)