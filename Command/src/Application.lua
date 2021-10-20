---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local CommandStore = require "CommandStore.CommandStore"
local Object = require "classic"


local Application = Object:extend()


function Application:new()
  self.input = CliInput()
  self.output = CliOutput()
  self.commandStore = CommandStore()
end


function Application:setInput(_input)
  self.input = _input
end

function Application:setOutputImplementation(_output)
  self.output = _output
end


function Application:addCommandDir(_commandDir)
end


function Application:run(_parameters)

  local parameters
  if (_parameters == nil) then
    parameters = _G.arg
  else
    parameters = _parameters
  end


  -- Parse the input parameters
  self.input:parse(parameters)

  -- Get the command
  local command = self.commandStore.getCommandByNameOrAlias(self.input:getCommandName())

  command:validateArguments(self.input:getArguments())
  command:validateOptions(self.input:getOptions())

  command:execute(self.input, self.output)

end


return Application
