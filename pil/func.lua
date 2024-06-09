-- There is a special case to this rule:
-- If the function has one single argument and this argument is either 
-- a literal string or a table constructor, then the parentheses are optional
local function show(s)
    print("show: "..s)
end
show "hello1"
show("hello2")

local function f(a, b) return a or b end
print(f(3))
print(f(nil, 4))
print(f(nil, 4, 5)) -- 5 is discarded  
