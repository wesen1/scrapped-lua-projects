---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require("classic")

local UserController = Object:extend()


UserController.actions = {
  {
    name = "login",
    parameters = { "userName", "password" },
    rights = "anonymous"
  },
  {
    name = "logout",
    rights = "user"
  }
}


function UserController:register(_email, _userName, _password)

  -- TODO: Check if IP is banned
  -- TODO: If not: Save account request in database + send mail to owner

  return "tried to register"
end

function UserController:login(_userName, _password)
  -- TODO: Check with database request if username password combo exists
  return "tried to login"
end

function UserController:logout()
  -- TODO: Forget current login (Session)
  return "tried to logout"
end


return UserController
