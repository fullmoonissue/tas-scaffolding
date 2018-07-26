local input = require('tas/input')()
--local macro = require('tas/macro-collection')()

local cf = 1
cf = input:start(cf, 2)
print(cf)

return input:all()