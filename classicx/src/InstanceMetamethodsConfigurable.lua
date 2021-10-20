---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"
local tablex = require "pl.tablex"

local InstanceMetamethodsConfigurable = Object:extend()


InstanceMetamethodsConfigurable.__instanceMetamethods = {}


function InstanceMetamethodsConfigurable:extend()

  local class = Object.extend(self)
  class.__instanceMetamethods = tablex.copy(self.__instanceMetamethods)

  return class

end

---
-- Callable constructor.
-- Initializes the __call metamethod for the Callable instance.
--
function InstanceMetamethodsConfigurable:new()

  print(self.super.__instanceMetamethods, InstanceMetamethodsConfigurable.__instanceMetamethods)
  for metamethodName, handler in pairs(getmetatable(self).__instanceMetamethods) do
    print(metamethodName)
    getmetatable(self)[metamethodName] = handler
  end

  print(self.__call, self.super.__call)

end

function InstanceMetamethodsConfigurable:__tostring()
  return "InstanceMetamethodsConfigurable"
end


return InstanceMetamethodsConfigurable
