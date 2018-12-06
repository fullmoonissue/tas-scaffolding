local lu = require('luaunit')
local dump = require('bizhawk/dump')()

function testFromLuaFilesToLuaInputs()
    lu.assertEquals(
        {
            [1] = {
                ['P1 Cross'] = true,
            },
            [2] = {
                ['P1 Cross'] = true,
                ['P1 Start'] = true,
            },
            [3] = {
                ['P1 Select'] = true,
            },
        },
        dump.fromLuaFilesToLuaInputs('tests/tas', require('tests/bizhawk/files'), 'test-game')
    )
end

function testFromLuaInputsToBizhawksLog()
    lu.assertEquals(
        '[Input]' .. "\n"
        .. 'LogKey:#Disc Select|Open|Close|Reset|#P1 LStick X|P1 LStick Y|P1 RStick X|P1 RStick Y|P1 Up|P1 Down|P1 Left|P1 Right|P1 Select|P1 Start|P1 Square|P1 Triangle|P1 Circle|P1 Cross|P1 L1|P1 R1|P1 L2|P1 R2|P1 L3|P1 R3|P1 MODE|#P2 LStick X|P2 LStick Y|P2 RStick X|P2 RStick Y|P2 Up|P2 Down|P2 Left|P2 Right|P2 Select|P2 Start|P2 Square|P2 Triangle|P2 Circle|P2 Cross|P2 L1|P2 R1|P2 L2|P2 R2|P2 L3|P2 R3|P2 MODE|' .. "\n"
        .. '|    1,...|  128,  128,  128,  128,.........X.......|  128,  128,  128,  128,.................|' .. "\n"
        .. '|    1,...|  128,  128,  128,  128,.....S...X.......|  128,  128,  128,  128,.................|' .. "\n"
        .. '|    1,...|  128,  128,  128,  128,....s............|  128,  128,  128,  128,.................|' .. "\n"
        .. '[/Input]',
        dump.fromLuaInputsToBizhawksLog({
            [1] = {
                ['P1 Cross'] = true,
            },
            [2] = {
                ['P1 Cross'] = true,
                ['P1 Start'] = true,
            },
            [3] = {
                ['P1 Select'] = true,
            },
        })
    )
end

function testLfsForBizhawk()
    lu.assertEquals(
        'return {' .. "\n"
        .. '    [\'test-game\'] = {' .. "\n"
        .. '        \'0-init\',' .. "\n"
        .. '        \'1-exit\',' .. "\n"
        .. '    },' .. "\n"
        .. '}',
        dump.lfsForBizhawk('tests/tas')
    )
end

os.exit( lu.LuaUnit.run() )