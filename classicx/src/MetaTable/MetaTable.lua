---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local MetaTable = {}


function MetaTable:new()
  return setmetatable({}, {__index = self})
end


return MetaTable
