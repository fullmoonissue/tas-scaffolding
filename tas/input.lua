local bag = {}
local currentPlayer = 'P1'

local Input = setmetatable(
    {
        bag = bag,
        currentPlayer = currentPlayer,
    },
    {
        __call = function()
            return {
                all = function()
                    return bag
                end,

                reset = function()
                    bag = {}
                end,

                setPlayer = function(player)
                    currentPlayer = 'P' .. player
                end,

                add = function(frame, iterations, joypad)
                    local currentFrame
                    for i = 1, (iterations or 1) do
                        currentFrame = tonumber(frame + (i - 1))

                        if (not bag[currentFrame]) then
                            bag[currentFrame] = {}
                        end

                        for k, v in pairs(joypad) do
                            bag[currentFrame][k] = v
                        end
                    end

                    return currentFrame
                end,

                up = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Up'] = true })
                end,

                left = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Left'] = true })
                end,

                right = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Right'] = true })
                end,

                down = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Down'] = true })
                end,

                select = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Select'] = true })
                end,

                start = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Start'] = true })
                end,

                triangle = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Triangle'] = true })
                end,

                square = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Square'] = true })
                end,

                circle = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Circle'] = true })
                end,

                cross = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' Cross'] = true })
                end,

                l1 = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' L1'] = true })
                end,

                l2 = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' L2'] = true })
                end,

                r1 = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' R1'] = true })
                end,

                r2 = function(self, frame, iterations)
                    return self.add(frame, iterations, { [currentPlayer .. ' R2'] = true })
                end,
            }
        end
    }
)

return Input