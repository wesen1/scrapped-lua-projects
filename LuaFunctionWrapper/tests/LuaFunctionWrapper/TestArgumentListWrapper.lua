---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local ArgumentListWrapper = require "ArgumentListWrapper"
local luaunit = require "luaunit"
local Object = require "classic"

local TestArgumentListWrapper = Object:extend()


-- Argument forwarding

function TestArgumentListWrapper:testForwardsAllArgumentsIfNoArgumentsAreIgnored()

  local argumentListWrapper = ArgumentListWrapper()

  local exampleTable = { "table" }
  local exampleFunction = function()
    return "no"
  end

  local arg1, arg2, arg3, arg4, arg5, arg6 = argumentListWrapper:getRelevantArguments(
    "a", 1, 5.6, exampleTable, false, exampleFunction
  )


  luaunit.TABLE_EQUALS_KEYBYCONTENT = false

  luaunit.assertEquals(arg1, "a")
  luaunit.assertEquals(arg2, 1)
  luaunit.assertEquals(arg3, 5.6)
  luaunit.assertEquals(arg4, exampleTable)
  luaunit.assertEquals(arg5, false)
  luaunit.assertEquals(arg6, exampleFunction)

  luaunit.TABLE_EQUALS_KEYBYCONTENT = true

end

function TestArgumentListWrapper:testForwardsNilArgumentsAtBeginning()

  local argumentListWrapper = ArgumentListWrapper()

  local arg1, arg2, arg3, arg4 = argumentListWrapper:getRelevantArguments(nil, 1, 2, 3)

  luaunit.assertEquals(arg1, nil)
  luaunit.assertEquals(arg2, 1)
  luaunit.assertEquals(arg3, 2)
  luaunit.assertEquals(arg4, 3)

end

function TestArgumentListWrapper:testForwardsNilArgumentsInMiddle()

  local argumentListWrapper = ArgumentListWrapper()

  local arg1, arg2, arg3, arg4, arg5 = argumentListWrapper:getRelevantArguments(1, 2, nil, 3, 4)

  luaunit.assertEquals(arg1, 1)
  luaunit.assertEquals(arg2, 2)
  luaunit.assertEquals(arg3, nil)
  luaunit.assertEquals(arg4, 3)
  luaunit.assertEquals(arg5, 4)

end

function TestArgumentListWrapper:testForwardsNilArgumentsAtEnd()

  local argumentListWrapper = ArgumentListWrapper()

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(1, 2, nil)

  luaunit.assertEquals(arg1, 1)
  luaunit.assertEquals(arg2, 2)
  luaunit.assertEquals(arg3, nil)

end


-- Ignore single arguments

function TestArgumentListWrapper:testCanIgnoreArgumentsByValueAtBeginning()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists(15, {1})

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(15, "test", true, 15)

  luaunit.assertEquals(arg1, "test")
  luaunit.assertEquals(arg2, true)
  luaunit.assertEquals(arg3, 15)

end

function TestArgumentListWrapper:testCanIgnoreArgumentsByValueInMiddle()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists("test", {2})

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(15, "test", true, "test")

  luaunit.assertEquals(arg1, 15)
  luaunit.assertEquals(arg2, true)
  luaunit.assertEquals(arg3, "test")

end

function TestArgumentListWrapper:testCanIgnoreArgumentsByValueAtEnd()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists(true, {3})

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(15, true, "test", true)

  luaunit.assertEquals(arg1, 15)
  luaunit.assertEquals(arg2, true)
  luaunit.assertEquals(arg3, "test")

end


-- Ignore multiple arguments

function TestArgumentListWrapper:testCanIgnoreArgumentsByValueAtMultiplePositions()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists("abc123", {1, 4})

  local arg1, arg2, arg3, arg4 = argumentListWrapper:getRelevantArguments("abc123", "abc123", 1, "abc123", 3, "abc123")

  luaunit.assertEquals(arg1, "abc123")
  luaunit.assertEquals(arg2, 1)
  luaunit.assertEquals(arg3, 3)
  luaunit.assertEquals(arg4, "abc123")

end

function TestArgumentListWrapper:testCanIgnoreAllOccurencesOfArgumentsByValue()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists("abc123")

  local arg1, arg2 = argumentListWrapper:getRelevantArguments("abc123", "abc123", 1, "abc123", 3, "abc123")

  luaunit.assertEquals(arg1, 1)
  luaunit.assertEquals(arg2, 3)

end

function TestArgumentListWrapper:testCanIgnoreMultipleArgumentsByValue()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists("abc123", {1})
  argumentListWrapper:ignoreArgumentValueIfExists(5.4, {5})
  argumentListWrapper:ignoreArgumentValueIfExists(false, {3})

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(
    "abc123", 5.4, false, "abc123", 5.4, false
  )

  luaunit.assertEquals(arg1, 5.4)
  luaunit.assertEquals(arg2, "abc123")
  luaunit.assertEquals(arg3, false)

end

function TestArgumentListWrapper:testCanIgnoreAllArgumentsByValue()

  local argumentListWrapper = ArgumentListWrapper()

  argumentListWrapper:ignoreArgumentValueIfExists("123abc", {1})
  argumentListWrapper:ignoreArgumentValueIfExists(true, {2})
  argumentListWrapper:ignoreArgumentValueIfExists(3.7, {3})

  local arguments = { argumentListWrapper:getRelevantArguments("123abc", true, 3.7) }

  local argumentNumbers = {}
  for argumentNumber, _ in pairs(arguments) do
    table.insert(arguments, argumentNumber)
  end

  luaunit.assertEquals(#argumentNumbers, 0)

end


-- Special cases

function TestArgumentListWrapper:testCanIgnoreNilArguments()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists(nil)

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(132, nil, nil, "test", nil, nil, nil, "end", nil)

  luaunit.assertEquals(arg1, 132)
  luaunit.assertEquals(arg2, "test")
  luaunit.assertEquals(arg3, "end")

end

function TestArgumentListWrapper:testCanForwardArgumentsWithNilValueAtMiddleAndEnd()

  local argumentListWrapper = ArgumentListWrapper()

  local arg1, arg2, arg3, arg4, arg5 = argumentListWrapper:getRelevantArguments(1, nil, 2, 3, nil)

  luaunit.assertEquals(arg1, 1)
  luaunit.assertEquals(arg2, nil)
  luaunit.assertEquals(arg3, 2)
  luaunit.assertEquals(arg4, 3)
  luaunit.assertEquals(arg5, nil)

end

function TestArgumentListWrapper:testIgnoresArgumentsWithStrictComparison()

  local argumentListWrapper = ArgumentListWrapper()
  argumentListWrapper:ignoreArgumentValueIfExists(false)

  local arg1, arg2, arg3 = argumentListWrapper:getRelevantArguments(nil, false, "", 0)

  luaunit.assertEquals(arg1, nil)
  luaunit.assertEquals(arg2, "")
  luaunit.assertEquals(arg3, 0)

end


return TestArgumentListWrapper
