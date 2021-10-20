---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Callable = require "Callable"

---
-- Example Callable class that accesses instance attributes in the instances __call handler.
--
-- @type WithObjectAttributeAccessInCallHandler
--
local WithObjectAttributeAccessInCallHandler = Callable:extend()


---
-- An example attribute that will be accessed in the instances __call handler
--
-- @tfield mixed exampleAttribute
--
WithObjectAttributeAccessInCallHandler.exampleAttribute = nil


---
-- WithObjectAttributeAccessInCallHandler constructor.
--
-- @tparam mixed _exampleAttributeValue The value to set the example attribute to
--
function WithObjectAttributeAccessInCallHandler:new(_exampleAttributeValue)
  self.super.new(self)
  self.exampleAttribute = _exampleAttributeValue
end


---
-- Returns the example attributes value of the instance that this method is called on.
--
-- @treturn mixed The example attributes value of the instance
--
function WithObjectAttributeAccessInCallHandler:getExampleAttributeValueFromInstance()
  return self.exampleAttribute
end

---
-- Returns the example attributes value of the class.
--
-- @treturn mixed The example attributes value of the class
--
function WithObjectAttributeAccessInCallHandler.getExamplteAttributeValueFromClass()
  return WithObjectAttributeAccessInCallHandler.exampleAttribute
end


---
-- Method that is called when an instance of this class is called like a function.
-- Returns the example attributes value of the instance that was called like a function..
--
-- @treturn mixed The example attributes value of the instance
--
function WithObjectAttributeAccessInCallHandler:__instanceCall()
  return self.exampleAttribute
end


return WithObjectAttributeAccessInCallHandler
