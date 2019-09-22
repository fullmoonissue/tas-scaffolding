local lu = require('luaunit')
local input = require('core/input')

function testQueuedInputs()
    input:reset()
    input:setPlayer(5)
    input:up(1)
    input:left(2)
    input:right(3)
    input:down(4)
    input:select(5)
    input:start(6)
    input:triangle(7)
    input:square(8)
    input:circle(9)
    input:cross(10)
    input:l1(11)
    input:l2(12)
    input:r1(13)
    input:r2(14)
    input:upLeft(15)
    input:upRight(16)
    input:downLeft(17)
    input:downRight(18)
    lu.assertEquals(
        {
            [1] = {
                ['P5 Up'] = true,
            },
            [2] = {
                ['P5 Left'] = true,
            },
            [3] = {
                ['P5 Right'] = true,
            },
            [4] = {
                ['P5 Down'] = true,
            },
            [5] = {
                ['P5 Select'] = true,
            },
            [6] = {
                ['P5 Start'] = true,
            },
            [7] = {
                ['P5 Triangle'] = true,
            },
            [8] = {
                ['P5 Square'] = true,
            },
            [9] = {
                ['P5 Circle'] = true,
            },
            [10] = {
                ['P5 Cross'] = true,
            },
            [11] = {
                ['P5 L1'] = true,
            },
            [12] = {
                ['P5 L2'] = true,
            },
            [13] = {
                ['P5 R1'] = true,
            },
            [14] = {
                ['P5 R2'] = true,
            },
            [15] = {
                ['P5 Up'] = true,
                ['P5 Left'] = true,
            },
            [16] = {
                ['P5 Up'] = true,
                ['P5 Right'] = true,
            },
            [17] = {
                ['P5 Down'] = true,
                ['P5 Left'] = true,
            },
            [18] = {
                ['P5 Down'] = true,
                ['P5 Right'] = true,
            },
        },
        input:all()
    )
end

function testCombinedInputs()
    input:reset()
    input:add(
        1,
        2,
        {
            ['P7 Up'] = true,
            ['P7 Left'] = true,
            ['P7 Right'] = true,
            ['P7 Down'] = true,
            ['P7 Select'] = true,
            ['P7 Start'] = true,
            ['P7 Triangle'] = true,
            ['P7 Square'] = true,
            ['P7 Circle'] = true,
            ['P7 Cross'] = true,
            ['P7 L1'] = true,
            ['P7 L2'] = true,
            ['P7 R1'] = true,
            ['P7 R2'] = true,
        }
    )
    lu.assertEquals(
        {
            [1] = {
                ['P7 Up'] = true,
                ['P7 Left'] = true,
                ['P7 Right'] = true,
                ['P7 Down'] = true,
                ['P7 Select'] = true,
                ['P7 Start'] = true,
                ['P7 Triangle'] = true,
                ['P7 Square'] = true,
                ['P7 Circle'] = true,
                ['P7 Cross'] = true,
                ['P7 L1'] = true,
                ['P7 L2'] = true,
                ['P7 R1'] = true,
                ['P7 R2'] = true,
            },
            [2] = {
                ['P7 Up'] = true,
                ['P7 Left'] = true,
                ['P7 Right'] = true,
                ['P7 Down'] = true,
                ['P7 Select'] = true,
                ['P7 Start'] = true,
                ['P7 Triangle'] = true,
                ['P7 Square'] = true,
                ['P7 Circle'] = true,
                ['P7 Cross'] = true,
                ['P7 L1'] = true,
                ['P7 L2'] = true,
                ['P7 R1'] = true,
                ['P7 R2'] = true,
            },
        },
        input:all()
    )
end

function testMerge()
    input:reset()
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
        input.merge({
            'tests/tas/any%/0-init',
            'tests/tas/any%/1-exit',
        })
    )
end

os.exit(lu.LuaUnit.run())