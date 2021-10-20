---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

local BaseFilter = require "ArgumentListWrapper.Filter.BaseFilter"
local tablex = require "pl.tablex"

---
-- Allows to filter a list of arguments by values.
--
-- @type ArgumentValueFilter
--
local ArgumentValueFilter = BaseFilter:extend()


---
-- The argument values that should be ignored when extracting relevant arguments
-- This list is in the format { [value] = <table|true> }
--
-- A table of positions can be configured to be checked for the argument value
-- {
--   value = <mixed>, -- The value that should be ignored
--   positions = <int[]|true> -- The list of positions in the argument list to check and to remove the value
--                            -- from if it is found there or true to remove the value from any position
-- }
--
-- @tfield table[] ignoredArgumentValues
--
ArgumentValueFilter.ignoredArgumentValues = nil

ArgumentValueFilter.ignoredNilArgumentPositions = nil


function ArgumentValueFilter:new()
  self.ignoredArgumentValues = {}
  self.ignoredNilArgumentPositions = {}
end


---
-- Adds a argument to ignore to this ArgumentListWrapper.
-- The positions to remove the value from can be either a list of argument positions that should be checked
-- for the value or can be omitted to remove the value from any position.
--
-- @tparam mixed _argumentValue The argument value to ignore
-- @tparam int[] _argumentPositions The positions to ignore (optional)
--
function ArgumentValueFilter:filterByNotValueAt(_argumentValue, _argumentPositions)

  local argumentPositions = _argumentPositions or true

  local positionsConfig

  if (_argumentPositions) then

    -- Load the existing positions config
    if (_argumentValue == nil) then
      positionsConfig = self.ignoredNilArgumentPositions
    else
      positionsConfig = self.ignoredArgumentValues[_argumentValue]
    end

    if (positionsConfig) then

      if (positionsConfig ~= true) then
        tablex.insertvalues(positionsConfig, _argumentPositions)
      end

    else
      positionsConfig = _argumentPositions
    end



  else
    positionsConfig = true
  end




  if (_argumentValue == nil) then
    -- The value nil cannot be used for table indexes, so this needs special handling

    if (self.ignoredNilArgumentPositions ~= true) then
      tablex.insertvalues(self.ignoredNilArgumentPositions, _argumentPositions)
    end

  else
    
  end

  table.insert(self.ignoredArgumentValues, { value = _argumentValue, positions = argumentPositions })
end


function ArgumentValueFilter:matches(_argumentPosition, _argumentValue)

  if (_argumentValue == nil) then
    if (self.ignoredNilArgumentPositions[_argumentPosition]) then
      return false
    end

  elseif (self.ignoredArgumentValues[_argumentValue] == true) then
    return false

  elseif (type(self.ignoredArgumentValues[_argumentValue]) == "table") then
    if (self.ignoredArgumentValues[_argumentValue]) then
      return false
    end
  end

  return true

end


return ArgumentValueFilter
