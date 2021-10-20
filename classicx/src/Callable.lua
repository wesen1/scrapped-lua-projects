---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local InstanceMetamethodsConfigurable = require "InstanceMetamethodsConfigurable"

---
-- Parent class for classes whose instances are callable like functions.
--
-- @type Callable
--
local Callable = InstanceMetamethodsConfigurable:extend()


Callable.__instanceMetamethods.__call = Callable.onInstanceCall

function Callable:new()
  print("new callable")
  print(getmetatable(self))
  InstanceMetamethodsConfigurable.new(self)
end

---
-- Method that is called when an instance of this class is called like a function.
--
-- @tparam mixed arguments,... The arguments that were passed by the caller
--
function Callable:onInstanceCall()
end


function Callable:__tostring()
  return "Callable"
end


return Callable
