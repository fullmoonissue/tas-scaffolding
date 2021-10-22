local inputBizhawk = require('src/input/bizhawk')

local JoypadInputs = {
    bag = {},
    currentPlayer = 1
}

function JoypadInputs:all()
    return self.bag
end

function JoypadInputs:reset()
    self.bag = {}
end

function JoypadInputs:setPlayer(player)
    self.currentPlayer = player
end

function JoypadInputs:add(frame, iterations, joypad)
    local currentFrame
    for i = 1, (iterations or 1) do
        currentFrame = tonumber(frame + (i - 1))

        if not self.bag[currentFrame] then
            self.bag[currentFrame] = {}
        end

        for k, v in pairs(joypad) do
            self.bag[currentFrame][k] = v
        end
    end

    return currentFrame
end

function JoypadInputs:up(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'UP')] = true })
end

function JoypadInputs:left(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'LEFT')] = true })
end

function JoypadInputs:right(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'RIGHT')] = true })
end

function JoypadInputs:down(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'DOWN')] = true })
end

function JoypadInputs:upLeft(frame, iterations)
    return JoypadInputs:add(
        frame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'UP')] = true,
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'LEFT')] = true,
        }
    )
end

function JoypadInputs:upRight(frame, iterations)
    return JoypadInputs:add(
        frame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'UP')] = true,
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'RIGHT')] = true,
        }
    )
end

function JoypadInputs:downLeft(frame, iterations)
    return JoypadInputs:add(
        frame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'DOWN')] = true,
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'LEFT')] = true,
        }
    )
end

function JoypadInputs:downRight(frame, iterations)
    return JoypadInputs:add(
        frame,
        iterations,
        {
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'DOWN')] = true,
            [inputBizhawk.getButtonLabel(self.currentPlayer, 'RIGHT')] = true,
        }
    )
end

function JoypadInputs:select(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'SELECT')] = true })
end

function JoypadInputs:start(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'START')] = true })
end

function JoypadInputs:triangle(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'TRIANGLE')] = true })
end

function JoypadInputs:square(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'SQUARE')] = true })
end

function JoypadInputs:circle(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'CIRCLE')] = true })
end

function JoypadInputs:cross(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'CROSS')] = true })
end

function JoypadInputs:l1(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'L1')] = true })
end

function JoypadInputs:l2(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'L2')] = true })
end

function JoypadInputs:r1(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'R1')] = true })
end

function JoypadInputs:r2(frame, iterations)
    return JoypadInputs:add(frame, iterations, { [inputBizhawk.getButtonLabel(self.currentPlayer, 'R2')] = true })
end

return JoypadInputs