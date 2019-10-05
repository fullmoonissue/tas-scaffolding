local bhc = require('plugins/bizhawk/configuration')

local Input = {
    bag = {},
    currentPlayer = 1
}

function Input:all()
    return self.bag
end

function Input:reset()
    self.bag = {}
end

function Input:setPlayer(player)
    self.currentPlayer = player
end

function Input:add(frame, iterations, joypad)
    local currentFrame
    for i = 1, (iterations or 1) do
        currentFrame = tonumber(frame + (i - 1))

        if (not self.bag[currentFrame]) then
            self.bag[currentFrame] = {}
        end

        for k, v in pairs(joypad) do
            self.bag[currentFrame][k] = v
        end
    end

    return currentFrame
end

-- Merge inputs from files
function Input.merge(files)
    local inputs = {}
    for _, file in ipairs(files) do
        if file ~= '.' and file ~= '..' then
            local importedInputs = require(file)
            for frame, bInputs in pairs(importedInputs) do
                inputs[frame] = bInputs
            end
        end
    end

    return inputs
end

function Input:up(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadUp(self.currentPlayer)] = true })
end

function Input:left(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadLeft(self.currentPlayer)] = true })
end

function Input:right(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadRight(self.currentPlayer)] = true })
end

function Input:down(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadDown(self.currentPlayer)] = true })
end

function Input:upLeft(frame, iterations)
    return Input:add(
        frame,
        iterations,
        {
            [bhc.joypadUp(self.currentPlayer)] = true,
            [bhc.joypadLeft(self.currentPlayer)] = true,
        }
    )
end

function Input:upRight(frame, iterations)
    return Input:add(
        frame,
        iterations,
        {
            [bhc.joypadUp(self.currentPlayer)] = true,
            [bhc.joypadRight(self.currentPlayer)] = true,
        }
    )
end

function Input:downLeft(frame, iterations)
    return Input:add(
        frame,
        iterations,
        {
            [bhc.joypadDown(self.currentPlayer)] = true,
            [bhc.joypadLeft(self.currentPlayer)] = true,
        }
    )
end

function Input:downRight(frame, iterations)
    return Input:add(
        frame,
        iterations,
        {
            [bhc.joypadDown(self.currentPlayer)] = true,
            [bhc.joypadRight(self.currentPlayer)] = true,
        }
    )
end

function Input:select(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadSelect(self.currentPlayer)] = true })
end

function Input:start(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadStart(self.currentPlayer)] = true })
end

function Input:triangle(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadTriangle(self.currentPlayer)] = true })
end

function Input:square(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadSquare(self.currentPlayer)] = true })
end

function Input:circle(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadCircle(self.currentPlayer)] = true })
end

function Input:cross(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadCross(self.currentPlayer)] = true })
end

function Input:l1(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadL1(self.currentPlayer)] = true })
end

function Input:l2(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadL2(self.currentPlayer)] = true })
end

function Input:r1(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadR1(self.currentPlayer)] = true })
end

function Input:r2(frame, iterations)
    return Input:add(frame, iterations, { [bhc.joypadR2(self.currentPlayer)] = true })
end

return Input