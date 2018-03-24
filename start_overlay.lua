require('utils/overlay')
require('overlay/framecount')

local overlayFrameCount = OverlayFrameCount(Overlay(gui, memory))
mediator:subscribe({ 'frame.displayed' }, function(fc)
    overlayFrameCount:display(fc)
end)