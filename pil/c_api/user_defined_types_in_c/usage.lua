local function get_current_file_dir()
    local info = debug.getinfo(1, "S")
    local source = info.source:sub(2)
    local dir = source:match("(.*)%/")
    if not dir then
        return "."
    end
    return dir
end
  
local current_file_dir = get_current_file_dir()

package.cpath = package.cpath .. ";" .. current_file_dir .."/?.so"

-- start

-- local array = require("libnum_array")

require("libnum_array")

a = array.new(1000)
-- print(a)               --> userdata: 0x8064d48
print(a)               --> tostring method array<0x5576016c1b18>(1000)
print(a:size(a))   --> 1000
for i=1,1000 do
  a:set(i, 1/i)
end
print(a:get(10))  --> 0.1
-- array.get(io.stdio, 10) --> error: bad argument #1 to `getarray' (`array' expected)


-- object oriented access
-- change metaarray of array
-- local metaarray = getmetatable(array.new(1))
-- metaarray.__index = metaarray
-- metaarray.set = array.set
-- metaarray.get = array.get
-- metaarray.size = array.size
--  
-- a2 = array.new(1000)
-- print(a2:size())     --> 1000
-- a2:set(10, 3.4)
-- print(a2:get(10))    --> 3.4