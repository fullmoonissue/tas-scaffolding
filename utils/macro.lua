require('utils/class')

Macro = class(function(macro, input)
    macro.input = input
end)

function Macro:getInputManager()
    return self.input
end

return Macro