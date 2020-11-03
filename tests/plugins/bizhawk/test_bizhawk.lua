local lu = require('luaunit')
local bizhawk = require('plugins/bizhawk/bizhawk')

local bizhawkInputLog = '[Input]' .. "\n"
    .. 'LogKey:#Disc Select|Open|Close|Reset|#P1 LStick X|P1 LStick Y|P1 RStick X|P1 RStick Y|P1 Up|P1 Down|P1 Left|P1 Right|P1 Select|P1 Start|P1 Square|P1 Triangle|P1 Circle|P1 Cross|P1 L1|P1 R1|P1 L2|P1 R2|P1 L3|P1 R3|P1 MODE|#P2 LStick X|P2 LStick Y|P2 RStick X|P2 RStick Y|P2 Up|P2 Down|P2 Left|P2 Right|P2 Select|P2 Start|P2 Square|P2 Triangle|P2 Circle|P2 Cross|P2 L1|P2 R1|P2 L2|P2 R2|P2 L3|P2 R3|P2 MODE|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,U................|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.D...............|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,..L..............|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,...R.............|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,....s............|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.....S...........|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,......Q..........|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.......T.........|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,........O........|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.........X.......|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,..........l......|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,...........r.....|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,............L....|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.............R...|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,U................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.D...............|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,..L..............|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,...R.............|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,....s............|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.....S...........|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,......Q..........|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.......T.........|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,........O........|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.........X.......|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,..........l......|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,...........r.....|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,............L....|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.............R...|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,.................|  128,  128,  128,  128,.................|' .. "\n"
    .. '|    1,...|  128,  128,  128,  128,UDLRsSQTOXlrLR...|  128,  128,  128,  128,UDLRsSQTOXlrLR...|' .. "\n"
    .. '[/Input]';

local joypadInputs = {
    [2] = {
        ['P1 Up'] = true,
    },
    [3] = {
        ['P1 Down'] = true,
    },
    [4] = {
        ['P1 Left'] = true,
    },
    [5] = {
        ['P1 Right'] = true,
    },
    [6] = {
        ['P1 Select'] = true,
    },
    [7] = {
        ['P1 Start'] = true,
    },
    [8] = {
        ['P1 Square'] = true,
    },
    [9] = {
        ['P1 Triangle'] = true,
    },
    [10] = {
        ['P1 Circle'] = true,
    },
    [11] = {
        ['P1 Cross'] = true,
    },
    [12] = {
        ['P1 L1'] = true,
    },
    [13] = {
        ['P1 R1'] = true,
    },
    [14] = {
        ['P1 L2'] = true,
    },
    [15] = {
        ['P1 R2'] = true,
    },
    [17] = {
        ['P2 Up'] = true,
    },
    [18] = {
        ['P2 Down'] = true,
    },
    [19] = {
        ['P2 Left'] = true,
    },
    [20] = {
        ['P2 Right'] = true,
    },
    [21] = {
        ['P2 Select'] = true,
    },
    [22] = {
        ['P2 Start'] = true,
    },
    [23] = {
        ['P2 Square'] = true,
    },
    [24] = {
        ['P2 Triangle'] = true,
    },
    [25] = {
        ['P2 Circle'] = true,
    },
    [26] = {
        ['P2 Cross'] = true,
    },
    [27] = {
        ['P2 L1'] = true,
    },
    [28] = {
        ['P2 R1'] = true,
    },
    [29] = {
        ['P2 L2'] = true,
    },
    [30] = {
        ['P2 R2'] = true,
    },
    [32] = {
        ['P1 Up'] = true,
        ['P1 Down'] = true,
        ['P1 Left'] = true,
        ['P1 Right'] = true,
        ['P1 Select'] = true,
        ['P1 Start'] = true,
        ['P1 Square'] = true,
        ['P1 Triangle'] = true,
        ['P1 Circle'] = true,
        ['P1 Cross'] = true,
        ['P1 L1'] = true,
        ['P1 R1'] = true,
        ['P1 L2'] = true,
        ['P1 R2'] = true,
        ['P2 Up'] = true,
        ['P2 Down'] = true,
        ['P2 Left'] = true,
        ['P2 Right'] = true,
        ['P2 Select'] = true,
        ['P2 Start'] = true,
        ['P2 Square'] = true,
        ['P2 Triangle'] = true,
        ['P2 Circle'] = true,
        ['P2 Cross'] = true,
        ['P2 L1'] = true,
        ['P2 R1'] = true,
        ['P2 L2'] = true,
        ['P2 R2'] = true,
    },
}

function testMakeInputLogLines()
    lu.assertEquals(bizhawkInputLog, bizhawk.makeInputLogLines(joypadInputs))
end

function testMakeJoypadInputs()
    -- Weird : lu.assertEquals says that bizhawk.makeJoypadInputs(bizhawkInputLog) ~= joypadInputs
    -- But they are equals, so this is a walkaround => check tables at each frame
    local createdJoypadInputs = bizhawk.makeJoypadInputs(bizhawkInputLog)
    for frame, inputs in pairs(joypadInputs) do
        lu.assertEquals(inputs, createdJoypadInputs[frame])
    end
end

function testLfsForBizhawk()
    local lfsTestFile = './tests/plugins/bizhawk/lfsTest'
    local f = io.open(lfsTestFile .. '.lua', 'w')
    f:write(bizhawk.lfsForBizhawk('tests/tas'))
    f:close()

    lu.assertEquals(2, #require(lfsTestFile)['any%'])
end

os.exit(lu.LuaUnit.run())