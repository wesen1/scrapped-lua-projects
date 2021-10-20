---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

require "pl.compat"
local pretty = require "pl.pretty"

local generator = require"caribay.generator"
local parser = require "caribay.parser"

---
-- TODO:
--
-- function_call: unquoted strings may not contain "(" or ")"
-- function_call: function name may not contain "("
-- quoted blocks: No inner '"' allowed, because it instantly ends the quoted block
-- variable and function names cannot start with "$" (should be ok with the grammar because it is interpreted as variable_content)
--
--

local grammar = [[

  cubescript <- expressions END_OF_INPUT
  expressions <- (comment END_OF_LINE/ expression EXPRESSION_SEPARATOR)* (comment / expression)?
  comment <- '//' COMMENT?
  expression <- function_call_result /
                value_assignment /
                function_call
  function_call_result <- '(' function_call ')'
  function_call <- (variable_content / ID) value*
  value_assignment <- (variable_content / ID) '=' value
  value <- quoted_block /
           square_bracket_block /
           function_call_result /
           variable_content /
           UNQUOTED_STRING
  quoted_block <- ('"' '"') / ('"' (!'"' (expressions / .+)) '"')
  square_bracket_block <- '[' (expressions / (!'[' !']' .)+)? ']'
  variable_content <- '$' ID

  COMMENT <- (!END_OF_LINE .)+
  SQUARE_BRACKET_STRING <- [a-zA-Z0-9_\#]+
  QUOTED_STRING <- [^\"]+
  UNQUOTED_STRING <~ [a-zA-Z0-9_] [a-zA-Z0-9_]*
  MULTI_WORD_STRING <~ (%S+ WHITESPACE*)+
  WHITESPACE <- ' ' / '\t'
  END_OF_LINE <~ '\r'? '\n'
  EXPRESSION_SEPARATOR <~ (';' / END_OF_LINE)+
  SKIP <- (' ' / '\t' / '\f' / '\r')*
  ID_START    <- (!'$' %S)
  ID_END      <- %S+
  END_OF_INPUT <~ !.
]]

--[[
--]]


local code = [[
  test = a;
  print b c d e;
  (a so(hello special))
  ]]
code = [[
  //
  docident [getComparisonMapRecordTiedString][Returns the "Tied map record" message];
  //docremark [Returns the "Tied map record" message];
  //docargument [N][#1The];
  //docargument [I][1 if the map record was compared to the best map record];
  ]]

code = [[
  docident "test" hallo
  ]]


local testCode = [[

  const showGemaModeMenu [
  showmenu $menuGemaModeTitle;
  ]


  // value assignments
  test = ""
  test = []
  test = "single"
  test = [word]
  test = "multiple words"
  test = [for this test];
  test = $otherTest
  test = (testing)
  test = (testing other);

  echo ""
  //echo []
  echo "single"
  //echo [word]
  //echo "multiple words"
  // echo [for this test];


]]

--[[
]]



local match = generator.gen(grammar, nil, true, true)
local ast, errors = match(code)

if (ast) then
  print("\nAst")
  parser.show_ast(ast)
else
  print("Errors")
  pretty.dump(errors)
end

-- TODO: Remove assignments of $arg1 to some real name for performance boost
-- TODO: Move code in functions that are only used at a single place into the function that calls them
-- TODO: Merge event handlers into the event function thing
