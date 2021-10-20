---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")


---
-- Provides methods to cast strings to various data types.
--
-- @type StringTypeCaster
--
local StringTypeCaster = Object:extend()


---
-- The list of available types
--
-- @tfield function[][]|string[] types
--
StringTypeCaster.types = {
  ["integer"] = {
    ["is"] = StringTypeCaster.isInteger,
    ["to"] = StringTypeCaster.toInteger
  },
  ["int"] = "integer",

  ["float"] = {
    ["is"] = StringTypeCaster.isFloat,
    ["to"] = StringTypeCaster.toFloat
  },

  ["boolean"] = {
    ["is"] = StringTypeCaster.isBoolean,
    ["to"] = StringTypeCaster.toBoolean
  },
  ["bool"] = "boolean"
}

StringTypeCaster.booleanTruthyStrings = { "true", "on", "1" }
StringTypeCaster.booleanFalsyStrings = { "false", "off", "0" }



-- Public Methods

function StringTypeCaster.supportsType(_type)
  return (StringTypeCaster.types[_type] ~= nil)
end

function StringTypeCaster.is(_type, _value)
  local typeHandlers = StringTypeCaster.getTypeHandlers(_type)
  return typeHandlers.is(_value)
end

---
-- Casts a argument value for this argument to this arguments type and returns the result.
--
-- @tparam string _argumentValue The argument value
--
-- @raise Error if the argument value is not valid for this arguments type
--
function StringTypeCaster.to(_type, _value)
  local typeHandlers = StringTypeCaster.getTypeHandlers(_type)
  return typeHandlers.to(_value)
end


function StringTypeCaster.isInteger(_value)
  -- Check if the string contains only digits
  return (_value:match("^%d+$") ~= nil)
end

function StringTypeCaster.toInteger(_value)
  return tonumber(_value)
end


function StringTypeCaster.isFloat(_value)
  -- Check if the string is an integer or it contains only a single dot besides digits
  return (StringTypeCaster.isInteger(_value) or _value:match("^%d+%.%d+$") ~= nil)
end

function StringTypeCaster.toFloat(_value)
  return tonumber(_value)
end


function StringTypeCaster.isBoolean(_value)
  return (TableUtils.tableHasValue(StringTypeCaster.booleanTruthyString, _value) or
          TableUtils.tableHasValue(StringTypeCaster.booleanFalsyStrings, _value)
  )
end

function StringTypeCaster.toBoolean(_value)

  if (TableUtils.tableHasValue(StringTypeCaster.booleanTruthyStrings, _value)) then
    return true
  elseif (TableUtils.tableHasValue(StringTypeCaster.booleanFalsyStrings, _value)) then
    return false
  end

end


-- Private Methods

function StringTypeCaster:getTypeHandlers(_type)

  local typeHandlerEntry = self.types[_type]
  if (typeHandlerEntry == nil) then
    error("Unsupported string cast type \"" .. tostring(_type) .. "\"")
  end


  if (type(typeHandlerEntry) == "string") then
    return self:getTypeHandlers(typeHandlerEntry)
  else
    return typeHandlerEntry
  end

end


return StringTypeCaster
