---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local CliOutput = Object:extend()


function CliOutput:write(_text)
  io.write(_text)
end

function CliOutput:writeln(_text)
  io.write(_text .. "\n")
end


return CliOutput
