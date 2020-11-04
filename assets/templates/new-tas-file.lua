--[[

>> File : assets/templates/new-tas-file.lua

This file is the template when registering a new file (make register).

# ### Example ### #

local input = require('core/input')

local cf = 105 -- "cf" stands for "Current Frame"
cf = input:start(cf, 12)
print(cf)

-- To use some macros (>> plugins/macro/collection.lua (example))
local macro = require('plugins/macro/collection')
macro.example_macro_without_custom_inputs(1525)
macro.example_macro_with_custom_inputs(3000, 7)

-- Awaited return
return input:all()

]]--