#!/usr/bin/lua
---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

for k, v in pairs(_G.arg) do
  print(k, v)
end


print(#_G.arg)


--[[
local application = Application()


application:run()
--]]
