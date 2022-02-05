-- Declaration

local Register = {}

Register.process = function (tas, file, tasPath, tasFileTemplate)
    local f = io.open(tasFileTemplate, 'rb')
    local c = f:read('*all')
    f:close()

    f = io.open(table.concat({ tasPath, tas, file }, '/'), 'w')
    f:write(c)
    f:close()
end

-- Call

Register.process(arg[1], arg[2], arg[3], arg[4])