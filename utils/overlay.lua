require('utils/class')

Overlay = class(function(overlay, gui, memory)
    overlay.gui = gui
    overlay.memory = memory
end)

function Overlay:getMonitor()
    return self.gui
end

function Overlay:getMemory()
    return self.memory
end

return Overlay