---------------------- 1 VARIABLES and FLOW ----------------------

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
ans2 = true and 'yes' or 'no' --> 'yes'
print(ans, ans2)

-- for range!
karlSum = 0
for i = 1, 100 do
   karlSum = karlSum + i
end

-- use "100, 1, -1" as the range to count down
fredSum = 0
for j = 100, 1, -1 do fredSum = fredSum + j end

-- in geral, the rang is begin, end[, step].
for x = 0, 20, 2 do
   print(x)
end

-- Another loop contruct:
repeat
   print('the way to the future')
   num = num -1
until num == 40

---------------------- 2 Function ----------------------

function fib(n)
   if n < 2 then
      return n
   end
   return fib(n - 2) + fib(n -2)
end

-- clousures and anonymous functions are ok!!
function adder(x)
   return function (y)
      return x + y
   end
end

a1 = adder(9)
a2 = adder(36)
print(a1(16))
print(a2(64))

-- Returns, func calls, and assignments all work with lists that may be
-- mismatched in length. Unmatched receivers are nil; unmatched senders are
-- discarded.

x, y, z = 1, 2, 3, 4
-- Now x = 1, y = 2, z = 3, and 4 is thrown away.

a, b, c = 1, 2 --> c is nil

if c == nil then
   print("yes i'm right")
end

function bar(a, b, c)
   print(a, b, c)
   return 4, 8, 15, 16, 23, 42
end

x, y = bar('zaphod') --> prints "zaphod  nil nil"
-- Now x = 4, y = 8, values 15..42 are discarded.

-- function are first-class, may be local/grobal. theses are the same:
function f(x) return x * x end
f = function (x) return x * x end -- nice!

-- and so are these:
local function g(x)
   return math.sin(x)
end
-- or
local g = function(x) return math.sin(x) end
-- or
local g; g  = function (x) return math.sin(x) end

print(g)
print 'ok!'
