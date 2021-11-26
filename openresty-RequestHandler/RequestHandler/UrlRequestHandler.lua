---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")
local StringUtils = require("src/Util/StringUtils")

local UrlRequestHandler = Object:extend()


function UrlRequestHandler:handleRequest(_uri, _get, _post)

  local requestUriParts = StringUtils.splitString(_uri, "/")
  if (#requestUriParts >= 2) then

    local controllerName = StringUtils.toCamelCase(requestUriParts[1])
    local status, result = pcall(function()
        return require("src/Controller/" .. controllerName .. "Controller")
    end)

    if (status == false) then
      return "Controller not found"
    else

      local controller = result

      local actionName = StringUtils.toCamelCase(requestUriParts[2])
      if (controller:hasAction(requestUriParts[2])) then
      end

      local methodName = "action" .. actionName
      if (controller[methodName] == nil) then
        return "Action not found"
      else
        return controller[methodName]()
      end

    end

  else
    return "Invalid URL"
  end

end


return UrlRequestHandler
