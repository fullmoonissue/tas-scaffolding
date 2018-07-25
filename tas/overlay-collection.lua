local OverlayCollection = setmetatable(
    {
        gui = gui,
        memory = memory,
    },
    {
        __call = function()
            local framecount = function(fc)
                gui.drawText(5, 60, 'Frame', 'white', 'black', 15)
                gui.drawText(5, 75, fc, 'white', 'black', 20)
            end

            local applySubscriptions = function(mediator)
                mediator:subscribe({ 'frame.displayed' }, function(fc)
                    framecount(fc)
                end)
            end

            return {
                applySubscriptions = applySubscriptions,
            }
        end
    }
)

return OverlayCollection