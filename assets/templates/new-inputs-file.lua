--[[

>> File : assets/templates/new-inputs-file.lua

This file is the template when registering a new file (make register).

# ### ### #
# Example #
# ### ### #

local input = require('tas/joypadInputs')

local cf = 105 -- "cf" stands for "Current Frame"
cf = input:start(cf, 12)
print(cf)

-- To use some macros (>> src/input/macro.lua (example))
local macro = require('src/input/macro')
macro.upDown(5, 4)
macro.tremoloLeftRight(10, 7)

-- Awaited return
return input:all()

]]--

-- !! Default line, to be replaced !!
return require('tas/joypadInputs'):all()