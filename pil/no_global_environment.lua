-- a = 1   -- create a global variable
-- -- change current environment
-- print("old _G: ", tostring(_G))
-- setfenv(1, {_G = _G})
-- _G.print(a)      --> nil
-- _G.print(_G.a)   --> 1
-- _G.print("old _G: ", _G.tostring(_G))



a = 1
local newgt = {}        -- create new environment
setmetatable(newgt, {__index = _G})
setfenv(1, newgt)    -- set it
print(a)          --> 1

-- continuing previous code
a = 10
print(a)      --> 10
print(_G.a)   --> 1
_G.a = 20
print(_G.a)   --> 20
print(a)      --> 10