require('utils/class')

TableExtension = class()

function TableExtension:join(initial, add)
    for k, v in pairs(add) do
        local i, f = math.modf(k)
        if(0 < f) then
            -- @todo : the repeat portion will may be useless (handled in input class)
            -- float are not easy not reach, so workaround (but doesn't work with modulo 10 numbers)
            for it = 0, tonumber(tostring(k):match("%.(%d+)")) - 1 do
                initial[i + it] = v
            end
        else
            initial[k] = v
        end
    end

    return initial
end

return TableExtension