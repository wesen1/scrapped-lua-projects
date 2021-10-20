---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Callable = require "Callable"

---
-- Example Callable class that uses a static method as the instances __call handler.
--
-- @type WithStaticCallHandler
--
local WithStaticCallHandler = Callable:extend()


---
-- Method that is called when an instance of this class is called like a function.
-- Returns all input arguments.
--
-- @tparam mixed arguments,... The arguments that were passed by the caller
--
-- @treturn mixed ... The arguments that were passed to this method
--
function WithStaticCallHandler.__instanceCall(...)
  return ...
end


return WithStaticCallHandler
