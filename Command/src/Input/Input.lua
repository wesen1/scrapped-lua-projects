---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")

local Input = Object:extend()


Input.arguments = {}
Input.options = {}


function Input:new()
  self.arguments = {}
  self.options = {}
  self.commandName = nil
end


function Input:parse(_parameters)
end


function Input:getArguments()
  return self.arguments
end

function Input:getOptions()
  return self.options
end

function Input:getCommandName()
  return self.commandName
end


function Input:getArgument(_argumentName)
  return self.arguments[_argumentName]
end

function Input:getOption(_optionName)
  return self.options[_optionName]
end


return Input
