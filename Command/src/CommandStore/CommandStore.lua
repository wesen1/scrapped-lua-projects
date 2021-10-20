---
-- @author wesen
-- @copyright 2017-2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

---
-- Stores a list of all available commands and provides methods to get the commands.
--
-- @type CommandStore
--
local CommandStore = Object:extend()


---
-- The list of commands in the format { commandName => Command }
--
-- @tfield BaseCommand[] commands
--
CommandStore.commands = nil


---
-- CommandStore constructor.
--
function CommandStore:new()
  self.commands = {}
end


-- Public Methods

---
-- Adds a list of commands to this CommandStore.
--
-- @tparam Command[] _commands The list of commands to add
--
function CommandStore:addCommands(_commands)
  for _, command in ipairs(_commands) do
    self:addCommand(command)
  end
end

---
-- Removes a list of commands from this CommandList.
--
-- @tparam Command[] _commands The list of commands to remove
--
function CommandStore:removeCommands(_commands)
  for _, command in ipairs(_commands) do
    self:removeCommand(command)
  end
end

---
-- Returns a command that has a specified name or alias.
--
-- @tparam string _commandName The command name without the leading "!"
--
-- @treturn Command|bool The command or false if no command with that name or alias exists
--
function CommandStore:getCommandByNameOrAlias(_commandName)

  local command = self.commands[_commandName]
  if (command) then
    return command
  else

    -- Check aliases
    for _, command in pairs(self.commands) do
      if (command:hasAlias(_commandName)) then
        return command
      end
    end

    -- Command not found, throw error
    error(string.format("Could not find a command with the name or alias \"%s\"", _commandName))

  end

end


-- Private Methods

---
-- Adds a command to this CommandStore.
--
-- @tparam Command _command The command to add
--
function CommandStore:addCommand(_command)
  self.commands[_command:getName():lower()] = _command
end

---
-- Removes a command from this CommandList.
--
-- @tparam Command _command The command to remove
--
function CommandStore:removeCommand(_command)
  self.commands[_command:getName():lower()] = nil
end


return CommandStore
