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
print(a)               --> userdata: 0x8064d48
print(array.size(a))   --> 1000
for i=1,1000 do
  array.set(a, i, 1/i)
end
print(array.get(a, 10))  --> 0.1
array.get(io.stdio, 10) --> error: bad argument #1 to `getarray' (`array' expected)