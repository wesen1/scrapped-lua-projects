---
-- @author wesen
-- @copyright 2020 wesen <wesen-ac@web.de>
-- @release 0.1
-- @license MIT
--

require "pl.compat"
local pretty = require "pl.pretty"

local generator = require"caribay.generator"

local src = [[
  expressions <- expression*
  expression <- (comment / value_assignment / function_call_result / function_call) EXPRESSION_END
  value_assignment <- variable_name '=' value
  function_call_result <- '(' function_call ')'
  function_call <- function_name (!EXPRESSION_END value)*
  function_name <- variable_name
  variable_name <- value
  value <- block / function_call_result / variable_content / literal
  block <- BRACKET_OPEN expressions BRACKET_CLOSE
  variable_content <- '$' variable_name
  literal <- FLOAT / INT / string
  string <- STRING / multi_word_string_a / multi_word_string_b
  multi_word_string_a <- QUOTE MULTI_WORD_STRING* QUOTE
  multi_word_string_b <- BRACKET_OPEN MULTI_WORD_STRING* BRACKET_CLOSE
  comment <- '//' STRING*
  STRING <- %S+
  MULTI_WORD_STRING <- %S+ %s*
  WHITESPACE <- (' ' / '\t')+
  LINE_BREAK <- '\r'? '\n'
  INT <- %d+
  FLOAT <- %d+ '.' %d+
  QUOTE <- '"'
  BRACKET_OPEN <- '[' '\n'*
  BRACKET_CLOSE <- '\n'* ']'
  EXPRESSION_END <- (';' / LINE_BREAK)+
  SKIP <- (' ' / '\t' / '\f' / '\r')*
  ]]

--[[
literal <- (string / INT / FLOAT)
alias <- 'alias' ID block ';'*
--]]

--   string <- '"' (!'"' .)* '"'


local match = generator.gen(src)

local ast = match[[
  // this is a comment
  showGemaModeMenu 15;
  printGemaNotification hallo
  testing "multi word"

  hallo = valx;

  ]]

--[[

]]

-- alias test [ hi, this is a string but it looks like a function body ]


pretty.dump(ast[1])

-- TODO: Remove assignments of $arg1 to some real name for performance boost
