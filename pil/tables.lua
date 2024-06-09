local a = {}
for i=1,1000 do a[i] = i * 2 end
print(a[9])
a.x = 10
print(a.x, ",", a["x"])

local days = {"Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}
-- index start from 1 not 0
print(days[1])
-- force satrt from 0
days = {[0]="Sunday", "Monday", "Tuesday", "Wednesday",
"Thursday", "Friday", "Saturday"}
print(days[0])

-- miss key
print("not exist key case: "..tostring(days["no_exist key"]))

local list = {"a", "b", "c"}
for k,v in ipairs(list) do
    print(k..": "..v)
end

