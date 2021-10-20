---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local BaseInjector = require "ArgumentListWrapper.Injector.BaseInjector"

local ValueAtPositionInjector = BaseInjector:extend()

ValueAtPositionInjector.appendValues = nil

function ValueAtPositionInjector:new(_injectValues, _nilInjectPositions)
  self.appendValues = _appendValues
end


function ValueAtPositionInjector:injectValues(_arguments)

  local numberOfInjectedValues = 0
  for position, value in pairs(self.injectValues) do
    table.insert(_arguments, position, value)
  end

  tablex.insertvalues(_arguments, self.appendValues)
end


return ValueAtPositionInjector
