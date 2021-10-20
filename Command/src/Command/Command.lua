---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")


---
-- Stores the configuration for a single command.
--
-- @type Command
--
local Command = Object:extend()


---
-- The main command name
--
-- @tfield string name
--
Command.name = nil

---
-- A description of what the command does
-- This will be displayed when someone uses the !help command on this command
--
-- @tfield string description
--
Command.description = nil

---
-- The alternative command names
--
-- @tfield string[] aliases
--
Command.aliases = {}

---
-- List of arguments that must be passed when calling the command
--
-- @tfield CommandArgument[] arguments
--
Command.arguments = {}

---
-- List of options that may be passed when calling the command
--
-- @tfield CommandOption[] options
--
Command.options = {}


---
-- BaseCommand constructor.
--
-- @tparam string _name The commands main name
-- @tparam CommandArgument[] _arguments The commands arguments (optional)
-- @tparam CommandOption[] _options The commands options (optional)
-- @tparam string _description The commands description (optional)
-- @tparam string[] _aliases The commands aliases (optional)
--
function Command:new(_name, _arguments, _options, _description, _aliases)

  self.name = tostring(_name)

  if (_description) then
    self.description = tostring(_description)
  else
    self.description = "No description" -- TODO: tr
  end

  if (type(_arguments) == "table") then
    self.arguments = _arguments
  end

  if (type(_options) == "table") then
    self.options = _options
  end

  if (type(_aliases) == "table") then
    self.aliases = _aliases
  end

end


-- Getters and setters

---
-- Returns the main name.
--
-- @treturn string The main name
--
function Command:getName()
  return self.name
end

---
-- Returns the description.
--
-- @treturn string The description
--
function Command:getDescription()
  return self.description
end

---
-- Returns the arguments.
--
-- @treturn CommandArgument[] The arguments
--
function Command:getArguments()
  return self.arguments
end

---
-- Returns the options.
--
-- @treturn CommandOption[] The options
--
function Command:getOptions()
  return self.options
end


-- Public Methods

---
-- Returns whether this BaseCommand has a specified alias.
--
-- @tparam string _alias The alias to look up without the leading "!"
--
-- @treturn bool True if the alias exists, false otherwise
--
function Command:hasAlias(_alias)

  local searchAlias = _alias:lower()
  for _, alias in ipairs(self.aliases) do
    if (alias == searchAlias) then
      return true
    end
  end

  return false

end


-- Abstract Methods

---
-- Method that will be called when this command is executed.
--
function Command:execute(_input, _output)
end



return Command
