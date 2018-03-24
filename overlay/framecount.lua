require('utils/class')

OverlayFrameCount = class(function(overlayFrameCount, overlay)
    overlayFrameCount.overlay = overlay
end)

function OverlayFrameCount:display(fc)
    local monitor = self.overlay:getMonitor()
    monitor.drawText(5, 60, 'Frame', 'white', 'black', 15)
    monitor.drawText(5, 75, fc, 'white', 'black', 20)
end