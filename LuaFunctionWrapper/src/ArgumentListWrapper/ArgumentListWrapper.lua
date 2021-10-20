---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local Object = require "classic"
local TableUtils = require "Util.TableUtils"

---
-- Provides methods to filter lists of arguments.
--
-- @type ArgumentListWrapper
--
local ArgumentListWrapper = Object:extend()

---
-- The list of filters
--
-- @tfield BaseFilter[] filters
--
ArgumentListWrapper.filters = nil


---
-- ArgumentListWrapper constructor.
--
function ArgumentListWrapper:new()
  self.filters = {}
end


-- Public Methods

---
-- Adds a filter to this ArgumentListWrapper.
--
-- @tparam BaseFilter _filter The filter to add
--
function ArgumentListWrapper:addFilter(_filter)
  table.insert(self.filters, _filter)
end

---
-- Applies the filters to a list of arguments and returns the filtered arguments.
-- Trailing nil values will be omitted.
--
-- @tparam mixed,... ... The list of arguments to filter
--
-- @treturn mixed,... The filtered arguments
--
function ArgumentListWrapper:getFilteredArguments(...)

  local arguments = {...}
  local numberOfArguments = TableUtils.calculateLengthOfIndexedArray(arguments)

  -- Create a new list that does not contain the ignored arguments
  local relevantArguments = {}
  local relevantArgumentNumber = 0
  local lastNonNilRelevantArgumentNumber = 0

  for i = 1, numberOfArguments, 1 do

    local argumentValue = arguments[i]

    local valueMatchesFilters = true
    for _, filter in ipairs(self.filters) do
      if (not filter:matches(argumentValue)) then
        valueMatchesFilters = false
        break
      end
    end

    if (valueMatchesFilters) then
      relevantArgumentNumber = relevantArgumentNumber + 1
      relevantArguments[relevantArgumentNumber] = arguments[i]

      if (arguments[i] ~= nil) then
        lastNonNilRelevantArgumentNumber = i
      end
    end

  end

  return table.unpack(relevantArguments, 1, lastNonNilRelevantArgumentNumber)


  -- TODO: processors + forEach processor: arguments = processor:process(arguments)

end


return ArgumentListWrapper
