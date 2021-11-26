---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")

local StringUtils = Object:extend()


function StringUtils.splitString(_string, _delimiter)

  local parts = {}
  for part in _string:gmatch("([^" .. _delimiter .. "]+)") do
    table.insert(parts, part)
  end

  return parts

end

function StringUtils.toCamelCase(_string)
  return _string:sub(1, 1):upper() .. _string:lower():sub(2)
end


return StringUtils
