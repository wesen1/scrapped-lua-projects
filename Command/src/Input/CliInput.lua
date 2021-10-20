---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Input = require "Input"

local CliInput = Input:extend()


function CliInput:parse(_parameters)

  self.commandName = _parameters[1]

  local nextParameterIsOptionValue
  for i = 1, #_parameters, 1 do

    if (substr)

  end

  -- -1 = lua binary
  -- 0 = script name
  -- 1+ = parameters

  -- TODO: Parse arguments and options from params
end


return CliInput
