local frameNumberToImagePath = {}

local function subscribe()
    return function(fc)
        if frameNumberToImagePath[fc] then
            client.screenshot(frameNumberToImagePath[fc])
        end
    end
end

return {
    subscribe = subscribe
}