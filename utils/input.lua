require('utils/class')

Input = class(function(input)
    input.bag = {}
    input.currentPlayer = 'P1'
end)

function Input:all()
    return self.bag
end

function Input:player(player)
    self.currentPlayer = 'P' .. player
end

function Input:add(frame, iterations, joypad)
    local currentFrame
    for i = 1, (iterations or 1) do
        currentFrame = tonumber(frame + (i - 1))
        self.bag[currentFrame] = joypad
    end

    return currentFrame
end

function Input:up(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Up'] = true})
end

function Input:left(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Left'] = true})
end

function Input:right(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Right'] = true})
end

function Input:down(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Down'] = true})
end

function Input:select(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Select'] = true})
end

function Input:start(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Start'] = true})
end

function Input:triangle(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Triangle'] = true})
end

function Input:square(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Square'] = true})
end

function Input:circle(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Circle'] = true})
end

function Input:cross(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' Cross'] = true})
end

function Input:l1(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' L1'] = true})
end

function Input:l2(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' L2'] = true})
end

function Input:r1(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' R1'] = true})
end

function Input:r2(frame, iterations)
    return self:add(frame, iterations, {[self.currentPlayer .. ' R2'] = true})
end

return Input