---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local luaunit = require "luaunit"
local Object = require "classic"

---
-- Checks that the Callable class works as expected.
--
-- @type TestCallable
--
local TestCallable = Object:extend()


---
-- Checks that a Callable instance can be called when it is using the default call handler.
--
function TestCallable:testIsCallableWithoutCustomCallHandler()

  local CallableWithoutCustomCallHandler = require "tests.classicx.example-classes.Callable.WithoutCustomCallHandler"

  local instance = CallableWithoutCustomCallHandler()

  local returnValues
  local success, errorMessage = pcall(function()
      returnValues = { instance() }
  end)

  print(errorMessage)

  luaunit.assertTrue(success)
  luaunit.assertNil(errorMessage)
  luaunit.assertEquals(returnValues, {})

end

---
-- Checks that a Callable instance can be called when it is using a custom call handler.
--
function TestCallable:testIsCallableWithCustomCallHandler()

  local CallableWithInputArgumentForwarderCallHandler = require "tests.classicx.example-classes.Callable.WithInputArgumentForwarderCallHandler"

  local instance = CallableWithInputArgumentForwarderCallHandler()

  local returnValues
  local success, errorMessage = pcall(function()
      returnValues = { instance("a", 1, nil, 4, 6, 2, 3, 8, {}, "ok") }
  end)

  print(errorMessage)

  luaunit.assertTrue(success)
  luaunit.assertNil(errorMessage)
  luaunit.assertEquals(returnValues, {"a", 1, nil, 4, 6, 2, 3, 8, {}, "ok"})

end

---
-- Checks that the call handler of a Callable instance has access to the object's attributes.
--
function TestCallable:testCanAccessObjectAttributesInCallHandler()

  local CallableWithObjectAttributeAccessInCallHandler = require "tests.classicx.example-classes.Callable.WithObjectAttributeAccessInCallHandler"

  local instance = CallableWithObjectAttributeAccessInCallHandler("just-some-object-value")
  luaunit.assertNil(CallableWithObjectAttributeAccessInCallHandler.getExamplteAttributeValueFromClass())
  luaunit.assertEquals(instance:getExampleAttributeValueFromInstance(), "just-some-object-value")

  local returnValues
  local success, errorMessage = pcall(function()
      returnValues = { instance() }
  end)

  print(errorMessage)
  luaunit.assertTrue(success)
  luaunit.assertNil(errorMessage)
  luaunit.assertEquals(returnValues, {"just-some-object-value"})

end

---
-- Checks that the call handler of a Callable works when it is a static method.
--
function TestCallable:testCanHaveStaticCallHandler()

  local CallableWithStaticInputArgumentForwarderCallHandler = require "tests.classicx.example-classes.Callable.WithStaticInputArgumentForwarderCallHandler"

  local instance = CallableWithStaticInputArgumentForwarderCallHandler()

  local returnValues
  local success, errorMessage = pcall(function()
      returnValues = { instance("#1", 2, 5, false, nil, true) }
  end)

  print(errorMessage)
  luaunit.assertTrue(success)
  luaunit.assertNil(errorMessage)
  luaunit.assertEquals(returnValues, { instance, "#1", 2, 5, false, nil, true })

end

---
-- Checks that multiple instances of a Callable class can be created.
--
function TestCallable:testCanCreateMultipleInstances()

  local CallableWithoutCustomCallHandler = require "tests.classicx.example-classes.Callable.WithoutCustomCallHandler"

  local instanceA = CallableWithoutCustomCallHandler()
  local instanceB = CallableWithoutCustomCallHandler()

  luaunit.assertTrue(instanceA:is(CallableWithoutCustomCallHandler))
  luaunit.assertTrue(instanceB:is(CallableWithoutCustomCallHandler))

end


return TestCallable
