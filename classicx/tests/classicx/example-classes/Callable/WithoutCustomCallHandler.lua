---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Callable = require "Callable"

---
-- Example Callable class that does not define a custom instance __call handler.
--
-- @type WithoutCustomCallHandler
--
local WithoutCustomCallHandler = Callable:extend()

print("comp", WithoutCustomCallHandler.__instanceMetamethods, Callable.__instanceMetamethods)

return WithoutCustomCallHandler
