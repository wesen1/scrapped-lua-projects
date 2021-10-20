---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local Output = Object:extend()


function Output:write(_text)
end

function Output:writeln(_text)
end


return Output
