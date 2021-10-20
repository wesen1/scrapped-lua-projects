---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local BaseInjector = require "ArgumentListWrapper.Injector.BaseInjector"
local tablex = require "pl.tablex"

local ValueAppendInjector = BaseInjector:extend()

ValueAppendInjector.appendValues = nil

function ValueAppendInjector:new(_appendValues)
  self.appendValues = _appendValues
end


function ValueAppendInjector:injectValues(_arguments)
  tablex.insertvalues(_arguments, self.appendValues)
end


return ValueAppendInjector
