---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"

local TableUtils = Object:extend()


---
-- Calculates the number of arguments in a given list of arguments.
-- Trailing nil argument values will not be added to the number of arguments.
--
-- @tparam mixed[] _arguments The list of arguments
--
-- @treturn int The number of arguments in the list of arguments
--
function TableUtils.calculateLengthOfIndexedArray(_indexedArray)

  --
  -- Cannot use #_arguments to calculate the number of arguments because the number will be wrong when
  -- there is a nil argument in the middle and at the end of the list of arguments
  --
  -- Since the argument list is always an indexed array the number of arguments can be determined
  -- by finding and returning the highest index
  --
  local numberOfArguments = 0
  for i, _ in pairs(_indexedArray) do
    if (i > numberOfArguments) then
      numberOfArguments = i
    end
  end

  return numberOfArguments

end


return TableUtils
