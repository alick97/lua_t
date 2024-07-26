local weakKeys = setmetatable({}, {__mode = "k"})  -- Table with weak keys
local weakValues = setmetatable({}, {__mode = "v"}) -- Table with weak values

local obj1 = {}
local obj2 = {}

weakKeys[obj1] = "Value 1"  -- obj1 is a weak key
weakValues["Key 2"] = obj2 -- obj2 is a weak value

local function show(tname, t)
   print("table: "..tname)
   for k, v in pairs(t) do
       print("k: "..tostring(k).." , v: "..tostring(v))
   end 
end
show("weakKeys", weakKeys)    
show("weakValues", weakValues)    
obj1 = nil  -- obj1 is no longer referenced elsewhere
obj2 = nil  -- obj2 is no longer referenced elsewhere

collectgarbage() -- Force garbage collection

-- At this point:
--   - The entry with the key obj1 will be removed from weakKeys.
--   - The value associated with "Key 2" in weakValues will be nil. 
show("weakKeys", weakKeys)    
show("weakValues", weakValues)    