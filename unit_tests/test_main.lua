lu = require('luaunit') -- import
main = require('main')

function test_plus()
   lu.assertEquals(plus(10, 5), 15)
end

function test_plus_negative()
   lu.assertEquals(plus(-1, -2), -3)
end

function test_make_title()
   lu.assertEquals(make_title('i am a script'),
                   'I Am a Script')
   lu.assertEquals(make_title('lua is nice!'),
                   'Lua Is Nice!')
   lu.assertEquals(make_title('i a b c'),
                   'I a b c')
   lu.assertEquals(make_title('1 2 3'),
                   '1 2 3')
   lu.assertEquals(make_title(''),
                   '')
end

-- run
os.exit( lu.LuaUnit.run() )
