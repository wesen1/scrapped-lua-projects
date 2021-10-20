---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

---
-- Base class for ArgumentList filters.
--
-- If a filter is added to a ArgumentListWrapper its matches() method will be called whenever
-- a raw list of arguments need to be filtered.
--
-- @type BaseFilter
--
local BaseFilter = Object:extend()


---
-- Returns whether a argument value at a specific position matches this Filter.
-- If this returns false the value will be removed from the argument list.
--
-- @tparam int _position The position of the argument value in the list of arguments
-- @tparam mixed _argumentValue The argument value
--
-- @treturn bool True if the argument value matches this Filter, false otherwise
--
function BaseFilter:matches(_position, _argumentValue)
end


return BaseFilter
