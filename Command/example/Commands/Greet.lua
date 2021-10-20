---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Command = require "../../src/Command/Command"

local GreetCommand = Command:extend()


function GreetCommand:new()

  Command.super.new(
    self,
    "greet",
    {},
    {},
    "Greets someone",
    { "sayHello" }
  )

end


function GreetCommand:execute(_input, _output)

  _output.writeln("Hello " .. _input.getArgument("name"))

end


return GreetCommand
