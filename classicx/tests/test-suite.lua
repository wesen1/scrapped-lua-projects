---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

-- Add the classicx src directory to package.path
package.path = package.path .. ";../src/?.lua"

-- Add the repository root directory to package.path
package.path = package.path .. ";../?.lua"


-- Load the test cases into the global table
_G.TestCallable = require "tests.classicx.TestCallable"


-- Run LuaUnit
local luaunit = require "luaunit"
os.exit(luaunit.LuaUnit.run())
