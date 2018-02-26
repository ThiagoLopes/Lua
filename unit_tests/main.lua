function plus(a, b)
   return a+b
end

function make_title(name)
   local new_string = ''
   local t = function (space) if space == true then return " " else return ""  end end
   local f = function (word, space) return string.upper(string.sub(word, 1, 1))
         ..  string.sub(word, 2)
         .. t(space)
   end

   function upper_first_letter(word)
      if string.len(word) > 1 then -- dont upper single words
         return f(word, true)
      else
         return word .. " "
      end
   end

   name = f(name) -- ignore len rule

   for w in string.gmatch(name, '%S+') do
      new_string = new_string .. upper_first_letter(w)
   end
   return string.sub(new_string, 1, -2) -- remove last space :D
end
