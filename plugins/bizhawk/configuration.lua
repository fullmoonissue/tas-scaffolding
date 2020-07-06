local UP = 'Up'
local DOWN = 'Down'
local LEFT = 'Left'
local RIGHT = 'Right'
local SELECT = 'Select'
local START = 'Start'
local SQUARE = 'Square'
local TRIANGLE = 'Triangle'
local CIRCLE = 'Circle'
local CROSS = 'Cross'
local L1 = 'L1'
local R1 = 'R1'
local L2 = 'L2'
local R2 = 'R2'
local NONE = '.'

local function getPlayer(player)
    return 'P' .. player
end

local function getJoypadInput(player, key)
    return string.format('%s %s', getPlayer(player), key)
end

return {
    ['UP'] = UP,
    ['DOWN'] = DOWN,
    ['LEFT'] = LEFT,
    ['RIGHT'] = RIGHT,
    ['SELECT'] = SELECT,
    ['START'] = START,
    ['SQUARE'] = SQUARE,
    ['TRIANGLE'] = TRIANGLE,
    ['CIRCLE'] = CIRCLE,
    ['CROSS'] = CROSS,
    ['L1'] = L1,
    ['R1'] = R1,
    ['L2'] = L2,
    ['R2'] = R2,
    ['NONE'] = NONE,
    ['keys'] = {
        UP, DOWN, LEFT, RIGHT,
        SELECT, START,
        SQUARE, TRIANGLE, CIRCLE, CROSS,
        L1, R1, L2, R2
    },
    ['inputs'] = {
        [UP] = 'U',
        [DOWN] = 'D',
        [LEFT] = 'L',
        [RIGHT] = 'R',
        [SELECT] = 's',
        [START] = 'S',
        [SQUARE] = 'Q',
        [TRIANGLE] = 'T',
        [CIRCLE] = 'O',
        [CROSS] = 'X',
        [L1] = 'l',
        [R1] = 'r',
        [L2] = 'L',
        [R2] = 'R'
    },
    ['joypad'] = function (self, player, key)
        return self[string.format('joypad%s', key)](player)
    end,
    ['joypadUp'] = function (player)
        return getJoypadInput(player, UP)
    end,
    ['joypadDown'] = function (player)
        return getJoypadInput(player, DOWN)
    end,
    ['joypadLeft'] = function (player)
        return getJoypadInput(player, LEFT)
    end,
    ['joypadRight'] = function (player)
        return getJoypadInput(player, RIGHT)
    end,
    ['joypadSelect'] = function (player)
        return getJoypadInput(player, SELECT)
    end,
    ['joypadStart'] = function (player)
        return getJoypadInput(player, START)
    end,
    ['joypadSquare'] = function (player)
        return getJoypadInput(player, SQUARE)
    end,
    ['joypadTriangle'] = function (player)
        return getJoypadInput(player, TRIANGLE)
    end,
    ['joypadCircle'] = function (player)
        return getJoypadInput(player, CIRCLE)
    end,
    ['joypadCross'] = function (player)
        return getJoypadInput(player, CROSS)
    end,
    ['joypadL1'] = function (player)
        return getJoypadInput(player, L1)
    end,
    ['joypadR1'] = function (player)
        return getJoypadInput(player, R1)
    end,
    ['joypadL2'] = function (player)
        return getJoypadInput(player, L2)
    end,
    ['joypadR2'] = function (player)
        return getJoypadInput(player, R2)
    end
}