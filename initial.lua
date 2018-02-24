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
print '---------------------- 2 Function ----------------------'

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
print {} -- works too

---------------------- 3 Tables ----------------------
print('---------------------- 3 Tables ----------------------')

-- Tables = Lua's only compound data structure; they are associative arrays.
-- Similar to php arrays or js objects, they are hash-lookup dicts that can
-- also be used as lists!!!

-- Using tables as dictionaries / maps:

-- Dict literals have string keys by default:
t = {key1 = 'value1', key2 = false}

-- String keys can use js-like dot notation:
print(t.key1)  -- Prints 'value1'.
t.newKey = {}  -- Adds a new key/value pair.
t.key2 = nil   -- Removes key2 from the table.


-- Literal notation for any (non-nil) value as key:
u = {['@!#'] = 'qbert', [{}] = 1729, [6.28] = 'tau'}
print(u[6.28])  -- prints "tau"

-- Key matching is basically by value for numbers and strings, but by identity
-- for tables.
a = u['@!#']  -- Now a = 'qbert'.
b = u[{}]     -- We might expect 1729, but it's nil:
-- b = nil since the lookup fails. It fails because the key we used is not the
-- same object as the one used to store the original value. So strings &
-- numbers are more portable keys.

-- BUT!!!
my_d = {}
u2 = {[my_d] = 1234567}
-- this is work because is not a type is the same obj
print(u2[my_d])

-- A one-table-param function call needs no parens:
function h(x) print(x.key1) end
h{key1 = 'Sonmi~451'}  -- Prints 'Sonmi~451'.
h{key1 = 'this is a argument'} --> this is a argument

for key, val in pairs(u) do  -- Table iteration.
  print(key, val)
end

dict_for = {one = 1, two = 2, tree = 3, four = 4}
for key, val in pairs(dict_for) do  -- Table iteration.
  print(key, val)
end

-- _G is a special table of all globals.
-- like globals() in python
print(_G['_G'] == _G)  -- Prints 'true'.

-- Using tables as lists / arrays:
-- List literals implicitly set up int keys:
v = {'value1', 'value2', 1.21, 'gigawatts'}
print(#v)  -- #v is the size of v for lists.
for i = 1, #v do
  print(v[i])  -- Indices start at 1 !! WTFFFFFFFFFFF SO CRAZY!
end

---------------------- 3.1 Metatables and metamethods  ----------------------
print '---------------------- 3.1 Metatables and metamethods  ----------------------'

f1 = {a = 1, b = 2}
f2 = {a = 2, b = 3}

-- this would fail:
-- s = f1 + f2
metafraction = {}
function metafraction.__add(f1, f2)
   local sum = {}
   sum.b = f1.b * f2.b
   sum.a = f1.a * f2.b + f2.a * f1.b
   return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)
s = f1 + f2 --> s = {a = 7, b = 6}
-- call __add(f1, f2) on f1's metatable
-- f1, f2 have no key for their metatable, unlike prototypes in js, so you must
-- retrieve it as in getmetatable(f1). The metatable is a normal table with
-- keys that Lua knows about, like __add.

-- But the next line fails since s has no metatable:
-- t = s + s
-- Class-like patterns given below would fix this.

-- An __index on a metatable overloads dot lookups:
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
setmetatable(myFavs, {__index = u})
print(myFavs['@!#'])
eatenBy = myFavs.animal  -- works! thanks, metatable

--------------------------------------------------------------------------------
-- Direct table lookups that fail will retry using the metatable's __index
-- value, and this recurses.

-- An __index value can also be a function(tbl, key) for more customized
-- lookups.

-- Values of __index,add, .. are called metamethods.
-- Full list. Here a is a table with the metamethod.

-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)


---------------------- 3.2 Class-like tables and inheritance ----------------------
print('---------------------- 3.2 Class-like tables and inheritance ----------------------')

Dog = {}                                   -- 1.

function Dog:new()                         -- 2.
  local newObj = {sound = 'woof'}          -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

-- 1. Dog acts like a class; it's really a table.
-- 2. "function tablename:fn(...)" is the same as
--    "function tablename.fn(self, ...)", The : just adds a first arg called
--    self. Read 7 & 8 below for how self gets its value.
-- 3. newObj will be an instance of class Dog.
-- 4. "self" is the class being instantiated. Often self = Dog, but inheritance
--    can change it. newObj gets self's functions when we set both newObj's
--    metatable and self's __index to self.
-- 5. Reminder: setmetatable returns its first arg.

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
end
mrDog = Dog:new()                          -- 7.
mrDog:makeSound()  -- 'I say woof'         -- 8.
print(mrDog.sound)
-- 6. The : works as in 2, but this time we expect self to be an instance
--    instead of a class.
-- 7. Same as Dog.new(Dog), so self = Dog in new().
-- 8. Same as mrDog.makeSound(mrDog); self = mrDog.


-- Inheritance example:
LoudDog = Dog:new()                           -- 1.
function LoudDog:makeSound()
  local s = self.sound .. ' '                 -- 2.
  print(s .. s .. s)
end

seymour = LoudDog:new()                       -- 3.
seymour:makeSound()  -- 'woof woof woof'      -- 4.

-- 1. LoudDog gets Dog's methods and variables.
-- 2. self has a 'sound' key from new(), see 3.
-- 3. Same as "LoudDog.new(LoudDog)", and converted to "Dog.new(LoudDog)" as
--    LoudDog has no 'new' key, but does have "__index = Dog" on its metatable.
--    Result: seymour's metatable is LoudDog, and "LoudDog.__index = Dog". So
--    seymour.key will equal seymour.key, LoudDog.key, Dog.key, whichever
--    table is the first with the given key.
-- 4. The 'makeSound' key is found in LoudDog; this is the same as
--    "LoudDog.makeSound(seymour)".
