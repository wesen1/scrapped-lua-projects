---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Session = require("resty.session")
local UrlRequestHandler = require("src/RequestHandler/UrlRequestHandler")

local session = Session.start()

-- TODO: Get + POST parameters
local requestHandler = UrlRequestHandler()

local result = requestHandler:handleRequest(ngx.var.uri, nil, nil)
ngx.say(result)

session:save()
