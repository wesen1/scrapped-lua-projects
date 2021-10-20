---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local FunctionWrapper = require "FunctionWrapper"
local IgnoreArgumentByValueFilter = require "ArgumentListWrapper.Filter.IgnoreArgumentByValueFilter"

---
-- Callable wrapper for a class method.
--
-- @type MethodWrapper
--
local MethodWrapper = FunctionWrapper:extend()


---
-- Enables ignoring of the self parameter that is passed to the function wrapper.
--
-- @tparam Object _object The object that would be the self parameter if one is passed
--
function MethodWrapper:ignoreSelfParameter(_object)
  local filter = IgnoreArgumentByValueFilter()
  filter:filterByNot(_object, {1})
  self.argumentListWrapper:ignoreArgumentValueIfExists(_object, {1})
end


return MethodWrapper
