---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")

---
-- Executes commands from a passed CommandStore based on a command name and raw arguments.
--
local CommandExecutor = Object:extend()


-- Public Methods

---
-- Executes a command.
--
-- @tparam CommandStore _commandStore The CommandStore to fetch the command from
-- @tparam string _commandName The command name
-- @tparam string[] _arguments The command arguments
--
-- @raise Error if the player has no permission to use the command
--
function CommandExecutor:executeCommand(_commandStore, _commandName, _arguments)

  local command = self:fetchCommand(_commandStore, _commandName)

  -- Check if the player is allowed to execute the command
  if (_player:getLevel() < command:getRequiredLevel()) then
    error(Exception(StaticString("exceptionNoPermissionToUseCommand"):getString()))
  end

  local arguments = self:parseArguments(command, _arguments)

  command:validateInputArguments(arguments)
  arguments = command:adjustInputArguments(arguments)

  command:execute(_player, arguments)

end


-- Private Methods

---
-- Fetches a command from a CommandList by its name.
--
-- @tparam CommandList _commandList The command list to fetch the command from
-- @tparam string _commandName The command name to search for
--
-- @treturn BaseCommand The command
--
-- @raise Error if there is no command with that name in the CommandList
--
function CommandExecutor:fetchCommand(_commandList, _commandName)

  local command = _commandList:getCommandByNameOrAlias(_commandName)
  if (not command) then
    error(TemplateException(
            "TextTemplate/ExceptionMessages/CommandHandler/UnknownCommand",
            { ["commandName"] = _commandName }
    ))
  end

  return command

end

---
-- Fetches the arguments from the input text parts.
-- Creates a table in the format { argumentName => inputArgumentValue }.
--
-- @tparam BaseCommand _command The command for which the arguments are used
-- @tparam string[] _rawArguments The argument text parts
--
-- @raise Error if there are not enough arguments
-- @raise Error if there are too many arguments
--
function CommandExecutor:parseArguments(_command, _rawArguments)

  local numberOfArguments = #_rawArguments

  -- Check whether the number of arguments is valid
  if (numberOfArguments < _command:getNumberOfRequiredArguments()) then
    error(TemplateException(
      "TextTemplate/ExceptionMessages/CommandHandler/NotEnoughCommandArguments",
      { numberOfPassedArguments = numberOfArguments, command = _command }
    ))

  elseif (numberOfArguments > _command:getNumberOfArguments()) then
    error(Exception(StaticString("exceptionTooManyCommandArguments"):getString()))
  end


  local parsedArguments = {}
  if (numberOfArguments > 0) then
    for index, argument in ipairs(_command:getArguments()) do
      parsedArguments[argument:getName()] = argument:parse(_rawArguments[index])
    end
  end

  return parsedArguments

end


return CommandExecutor
