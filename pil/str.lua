-- multi line 
local ml1 = [[
Ab
c
]]
local page = [=[
<HTML>
    <HEAD>
    <TITLE>An HTML Page</TITLE>
    </HEAD>
    <BODY>
     <A HREF="http://www.lua.org">Lua</A>
     [[a text between double brackets]]
    </BODY>
    </HTML>
]=]
print(ml1)
print(page)
print(10 + "2") -- 12
print("10" + 2) -- 102
print(10 .. 20) -- 1020
print("10" == 10)  -- false
print("10" == 10 .. "") -- true