---
-- @author wesen
-- @copyright 2019 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

---
-- A function.
--
-- @param string _valueA
-- @param int _valueB
--
local function testing(_valueA, _valueB)
  print(_valueA)
  print(_valueB)
end



print(unpack(debug.getinfo(testing, "S")))
