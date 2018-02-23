-- VARIABLES and FLOW

-- Two dashes start a one-line comment.
--[[
     Adding two ['s and ]'s makes it a
     multi-line comment.
--]]

num = 42

s = 'my name' -- immutable string like python!
t = "double-quotes are also fine"
u = [[ double braskets
start
multiple
lines]]

t = nil -- remove t, lua have garbage collector


-- blocks code have DO/END
while num < 50 do
   num = num + 1 -- no ++ or += type operators.
end

-- if clauses
if num > 40 then
   print('over 40')
elseif s ~= 'my names' then
   io.write('not over 40\n')
else
   -- variables are global by default
   this_is_global = 5

   local line = io.read()

   -- String concatenation use the .. operator
   print('Winter is coming, ' .. line)
end

-- print concatenates does a kind of tabbed alignment.
print('test_print', 'a', 'b') --> test_print    a    b
print('test_print', 1) --> test_print    1
print('test_print') --> test_print

-- just concatenates, need \n
io.write('test_print', 'ok?', '\n') --> test_printok?
io.write('ok!\n') --> ok!

-- Undefined variables return nil.
-- This is not an error:
foo = anUnknownVariable  -- Now foo = nil.

a_bool = false

ans = a_bool and 'yes' or 'no' --> 'no'
ans2 = true and 'yes' or 'no'
print(ans, ans2)
