---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local luaunit = require "luaunit"
local mach = require "mach"
local Object = require "classic"

local TestFunctionWrapper = Object:extend()


function TestFunctionWrapper:setUp()

  package.loaded["ArgumentListWrapper.ArgumentListWrapper"] = nil
  local ArgumentListWrapper = require "ArgumentListWrapper.ArgumentListWrapper"
  self.argumentListWrapperDependency = ArgumentListWrapper
  self.argumentListWrapperDependencyMock = mach.mock_object(ArgumentListWrapper, "ArgumentListWrapperDependencyMock")

  setmetatable(self.argumentListWrapperDependencyMock, {
                 __call = function(...)
                   return self.argumentListWrapperDependencyMock.__call(...)
                 end
  })

  package.loaded["ArgumentListWrapper.ArgumentListWrapper"] = self.argumentListWrapperDependencyMock

  package.loaded["FunctionWrapper"] = nil
  self.functionWrapperClass = require "FunctionWrapper"

end

function TestFunctionWrapper:tearDown()

  package.loaded["ArgumentListWrapper.ArgumentListWrapper"] = self.argumentListWrapperDependency

end

function TestFunctionWrapper:testCanWrapFunction()

  local wrappedFunctionMock = mach.mock_function("wrappedFunctionMock")
  local argumentListWrapperMock = mach.mock_object(self.argumentListWrapperDependency, "ArgumentListWrapperMock")

  local functionWrapper
  self.argumentListWrapperDependencyMock.__call
    :should_be_called()
    :and_will_return(argumentListWrapperMock)
    :when(
      function()
        functionWrapper = self.functionWrapperClass(wrappedFunctionMock)
      end
         )

  local returnValueA, returnValueB, returnValueC, returnValueD, returnValueE
  argumentListWrapperMock.getFilteredArguments
    :should_be_called_with("hallo", 1, 6, 4, 1, "welt")
    :and_will_return(6, 4, "welt")
    :and_then(
      wrappedFunctionMock:should_be_called_with(6, 4, "welt")
        :and_will_return("here", "are", "your", "return", "values")
             )
    :when(
      function()

        returnValueA, returnValueB, returnValueC, returnValueD, returnValueE = functionWrapper("hallo", 1, 6, 4, 1, "welt")
      end
         )

  luaunit.assertEquals(returnValueA, "here")
  luaunit.assertEquals(returnValueB, "are")
  luaunit.assertEquals(returnValueC, "your")
  luaunit.assertEquals(returnValueD, "return")
  luaunit.assertEquals(returnValueE, "values")

end


return TestFunctionWrapper
