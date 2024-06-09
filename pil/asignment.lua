local a, b, c = 0, 1
print(a)
print(b)
print(c)

local function tuple_f()
   return 1,2 
end
a, b, c = tuple_f()
print("tuple f")
print(a)
print(b)
print(c)