---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")


---
-- Stores the configuration for a single command input (argument or option).
--
-- @type CommandInput
--
-- TODO: Predefined value range or pattern (for strings)
local CommandInput = Object:extend()


---
-- The full name of the input
--
-- @tfield string name
--
CommandInput.name = nil

---
-- The short name of the input
-- This will be the same as the full name if no short name is defined
--
-- @tfield string shortName
--
CommandInput.shortName = nil

---
-- The description of the input that will be shown in the help text for the parent command
-- Defaults to "No description"
--
-- @tfield string description
--
CommandInput.description = nil

---
-- The type to which this arguments value(s) will be casted
-- Valid types are: integer, float, bool, nil
--
-- If the type is nil, no type casting will be done and the value will be a string
--
-- @tfield string|nil type
--
CommandInput.type


---
-- CommandInput constructor.
--
-- @tparam string _name The name of the input
-- @tparam string _shortName The short name of the input (optional)
-- @tparam string _description The description of the input (optional)
-- @tparam string _type The type to which this arguments value(s) will be converted (integer, float, bool) (optional)
--
-- @raise Error if the specified type is not valid
--
function CommandInput:new(_name, _shortName, _description, _type)

  -- Set name
  self.name = tostring(_name)

  -- Set shortName
  if (_shortName) then
    self.shortName = tostring(_shortName)
  else
    self.shortName = _name
  end

  -- Set description
  if (_description) then
    self.description = tostring(_description)
  else
    self.description = "No description"
  end


  -- Set type
  if (_type) then
    self.type = tostring(_type)

    if (not StringTypeCaster.supportsType(self.type)) then
      error(
        string.format(
          "Invalid type \"%s\" configured for input \"%s\"",
          self.type, self.name
        )
      )
    end

  end

end


-- Getters and Setters

---
-- Returns the arguments full name.
--
-- @treturn string The arguments full name
--
function CommandInput:getName()
  return self.name
end

---
-- Returns the arguments short name.
--
-- @treturn string The arguments short name
--
function CommandInput:getShortName()
  return self.shortName
end

---
-- Returns the arguments description.
--
-- @treturn string The arguments description
--
function CommandInput:getDescription()
  return self.description
end


-- Public Methods

---
-- Parses a argument value for this argument and returns the type casted argument value.
--
-- @tparam string _value The argument value
--
-- @treturn string|int|float|bool The type casted argument value
--
-- @raise Error if the argument value is not valid for this arguments type
--
function CommandInput:parse(_value)

  if (StringTypeCaster.is(self.type, _value)) then
    return StringTypeCaster.to(self.type, _value)
  else
    error(
      string.format(
        "Input value \"%s\" did not match expected type \"%s\"",
        _value, self.type
      )
    )

end


return CommandInput
