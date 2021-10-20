---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local ArgumentListWrapper = require "ArgumentListWrapper.ArgumentListWrapper"
local Object = require "classic"

---
-- Callable wrapper for a anonymous function.
--
-- @type FunctionWrapper
--
local FunctionWrapper = Object:extend()


---
-- The function that is wrapped by this wrapper
--
-- @tfield function wrappedFunction
--
FunctionWrapper.wrappedFunction = nil

---
-- The argument list wrapper
--
-- @tfield ArgumentListWrapper argumentListWrapper
--
FunctionWrapper.argumentListWrapper = nil


---
-- FunctionWrapper constructor.
--
-- @tparam function _function The function to wrap
--
function FunctionWrapper:new(_function)
  self.wrappedFunction = _function
  self.argumentListWrapper = ArgumentListWrapper()

  getmetatable(self).__call = self.__call
end


---
-- Method that is called when an instance of this class is called.
--
-- @tparam mixed,... ... The list of arguments
--
function FunctionWrapper:__call(...)
  return self.wrappedFunction(self.argumentListWrapper:getFilteredArguments(...))
end


return FunctionWrapper
