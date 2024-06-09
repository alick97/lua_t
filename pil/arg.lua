-- lua -e "sin=math.sin" pil/arg.lua a b

for index, value in ipairs(arg) do
   print(index..": "..value)
end
--[[
1: a
2: b
--]]
print(arg[0])
print(arg[-1])
print(arg[-2])
print(arg[-3])
print(arg[-4])
--[[
pil/arg.lua
sin=math.sin
-e
lua
nil
--]]