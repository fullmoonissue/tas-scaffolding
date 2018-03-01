-- Code inspired from http://lua-users.org/wiki/SimpleLuaClasses
function class(base, init)
    local c = {}
    if not init and type(base) == 'function' then
        init = base
        base = nil
    end

    c.__index = c

    local mt = {}
    mt.__call = function(class_tbl, ...)
        local obj = {}
        setmetatable(obj, c)
        if init then
            init(obj, ...)
        else
            if base and base.init then
                base.init(obj, ...)
            end
        end
        return obj
    end

    c.init = init
    setmetatable(c, mt)

    return c
end