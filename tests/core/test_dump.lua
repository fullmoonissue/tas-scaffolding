local lu = require('luaunit')
local dump = require('core/dump')()

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