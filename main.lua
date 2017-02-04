_DEBUG = true
require('squirrel').import()
local inspect = require('inspect')

local f = function(a, ...)
  return ...
end

print(inspect(debug.getinfo(f)))
