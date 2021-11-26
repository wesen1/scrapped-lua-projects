---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")

local BaseController = Object:extend()


function BaseController:new()
end

BaseController.actions = {}


function BaseController:hasAction(_actionName)
  return (self.actions[_actionName] ~= nil)
end

function BaseController:executeAction(_actionName, _get, _post)
end



return BaseController
