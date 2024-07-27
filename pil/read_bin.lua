local f = assert(io.open(arg[1], "rb"))
local block = 10
while true do
  local bytes = f:read(block)
  if not bytes then break end
  for b in string.gfind(bytes, ".") do
    io.write(string.format("%02X ", string.byte(b)))
  end
  io.write(string.rep("   ", block - string.len(bytes) + 1))
  io.write(string.gsub(bytes, "%c", "."), "\n")
end

-- run lua pil/read_bin.lua pil/read_bin.lua
-- show result eg:
-- 6C 6F 63 61 6C 20 66 20 3D 20    local f = 
-- 61 73 73 65 72 74 28 69 6F 2E    assert(io.
-- 6F 70 65 6E 28 61 72 67 5B 31    open(arg[1
-- 5D 2C 20 22 72 62 22 29 29 0A    ], "rb")).
-- 6C 6F 63 61 6C 20 62 6C 6F 63    local bloc
-- 6B 20 3D 20 31 30 0A 77 68 69    k = 10.whi
-- 6C 65 20 74 72 75 65 20 64 6F    le true do