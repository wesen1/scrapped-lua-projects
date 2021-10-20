---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

-- Add the LuaFunctionWrapper src directory to package.path
package.path = package.path .. ";../src/?.lua"

-- Add the repository root directory to package.path
package.path = package.path .. ";../?.lua"

require "pl.compat"

local luaunit = require "luaunit"
luaunit.TABLE_EQUALS_KEYBYCONTENT = false


--TestArgumentListWrapper = require "tests.LuaFunctionWrapper.TestArgumentListWrapper"
TestFunctionWrapper = require "tests.LuaFunctionWrapper.TestFunctionWrapper"

os.exit(luaunit.LuaUnit.run())
