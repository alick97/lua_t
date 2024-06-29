local function basicSerialize (o)
    if type(o) == "number" then
      return tostring(o)
    else   -- assume it is a string
      return string.format("%q", o)
    end
end

local function save (name, value, saved)
    saved = saved or {}       -- initial value
    io.write(name, " = ")
    if type(value) == "number" or type(value) == "string" then
      io.write(basicSerialize(value), "\n")
    elseif type(value) == "table" then
      if saved[value] then    -- value already saved?
        io.write(saved[value], "\n")  -- use its previous name
      else
        saved[value] = name   -- save name for next time
        io.write("{}\n")     -- create a new table
        for k,v in pairs(value) do      -- save its fields
          local fieldname = string.format("%s[%s]", name,
                                          basicSerialize(k))
          save(fieldname, v, saved)
        end
      end
    else
      error("cannot save a " .. type(value))
    end
end


a = {x=1, y=2; {3,4,5}}
a[2] = a    -- cycle
a.z = a[1]  -- shared sub-table


print("--- example 1")
save('a', a)
--[[
a = {}
a[1] = {}
a[1][1] = 3
a[1][2] = 4
a[1][3] = 5

a[2] = a
a["y"] = 2
a["x"] = 1
a["z"] = a[1]
--]]


print("--- example 2.1")
a = {{"one", "two"}, 3}
b = {k = a[1]}
save('a', a)
save('b', b)
--[[
a = {}
a[1] = {}
a[1][1] = "one"
a[1][2] = "two"
a[2] = 3
b = {}
b["k"] = {}
b["k"][1] = "one"
b["k"][2] = "two"
--]]
print("--- example 2.2")
local t = {}
save('a', a, t)
save('b', b, t)
--[[
a = {}
a[1] = {}
a[1][1] = "one"
a[1][2] = "two"
a[2] = 3
b = {}
b["k"] = a[1]
--]]